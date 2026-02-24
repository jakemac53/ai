import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dart_mcp/client.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as gemini;

import 'buffered_logger.dart';

final class WorkflowClient extends MCPClient with RootsSupport {
  WorkflowClient(
    this.serverCommands, {
    required String geminiApiKey,
    required String model,
    required this.logger,
    String? dtdUri,
    this.verbose = false,
    String? persona,
    File? logFile,
  }) : model = gemini.GenerativeModel(
         model: model,
         apiKey: geminiApiKey,
         systemInstruction: systemInstructions(persona: persona),
       ),
       stdinQueue = StreamQueue(_inputController.stream),
       super(Implementation(name: 'Gemini workflow client', version: '0.1.0')) {
    logSink = _createLogSink(logFile);
    addRoot(
      Root(
        uri: Directory.current.absolute.uri.toString(),
        name: 'The working dir',
      ),
    );
    _chatHistory.add(
      gemini.Content.text(
        'The current working directory is '
        '${Directory.current.absolute.uri.toString()}. Convert all relative '
        'URIs to absolute using this root. For tools that want a root, use '
        'this URI.',
      ),
    );
    if (dtdUri != null) {
      _chatHistory.add(
        gemini.Content.text(
          'If you need to establish a Dart Tooling Daemon (DTD) connection, '
          'use this URI: $dtdUri.',
        ),
      );
    }
    _startChat();
  }

  static final StreamController<String> _inputController =
      StreamController<String>.broadcast();

  void submitInput(String value) {
    if (value.isNotEmpty) {
      _inputController.add(value);
    }
  }

  final BufferedLogger logger;
  Sink<String>? logSink;
  final ValueNotifier<int> totalInputTokens = ValueNotifier(0);
  final ValueNotifier<int> totalOutputTokens = ValueNotifier(0);
  final ValueNotifier<bool> isThinking = ValueNotifier(false);
  final StreamQueue<String> stdinQueue;
  final List<String> serverCommands;
  final List<ServerConnection> serverConnections = [];
  final Map<String, ServerConnection> connectionForFunction = {};

  final List<gemini.Content> _chatHistory = [];
  List<gemini.Content> get chatHistory => List.unmodifiable(_chatHistory);
  final StreamController<void> _chatUpdateController =
      StreamController.broadcast();
  Stream<void> get onChatUpdate => _chatUpdateController.stream;

  final gemini.GenerativeModel model;
  final bool verbose;

  Sink<String>? _createLogSink(File? logFile) {
    if (logFile == null) {
      return null;
    }
    Sink<String>? logSink;
    logFile.createSync(recursive: true);
    final fileByteSink = logFile.openWrite(
      mode: FileMode.write,
      encoding: utf8,
    );
    logSink = fileByteSink.transform<String>(
      StreamSinkTransformer.fromHandlers(
        handleData: (String data, EventSink<List<int>> innerSink) {
          innerSink.add(utf8.encode(data));
        },
        handleError: (
          Object error,
          StackTrace stackTrace,
          EventSink<List<int>> innerSink,
        ) {
          innerSink.addError(error, stackTrace);
          fileByteSink.flush();
        },
        handleDone: (EventSink<List<int>> innerSink) {
          innerSink.close();
        },
      ),
    );
    return logSink;
  }

  void _startChat() async {
    if (serverCommands.isNotEmpty) {
      await _connectToServers();
    }
    await _initializeServers();
    _listenToLogs();
    final serverTools = await _listServerCapabilities();

    // Introduce yourself.
    _addToHistory('Please introduce yourself and explain how you can help.');
    final introResponse = await _generateContent(
      context: chatHistory,
      tools: serverTools,
    );
    await _handleModelResponse(introResponse);

    while (true) {
      final next = await _waitForInputAndAddToHistory();

      // Remember where the history starts for this workflow
      final historyStartIndex = chatHistory.length;
      final summary = await _makeAndExecutePlan(next, serverTools);

      // Workflow/Plan execution finished, now summarize and clean up context.
      if (historyStartIndex < chatHistory.length) {
        // Remove the entire history.
        _chatHistory.removeRange(historyStartIndex, chatHistory.length);
      }

      // Add the summary to the chat history.
      await _handleModelResponse(summary);
    }
  }

  /// Handles a response from the [model].
  ///
  /// If this function returns a [String], then it should be fed back into the
  /// model as a user message in order to continue the conversation.
  Future<String?> _handleModelResponse(gemini.Content response) async {
    String? continuation;
    for (var part in response.parts) {
      switch (part) {
        case gemini.TextPart():
          _chatToUser(part.text);
        case gemini.FunctionCall():
          await _handleFunctionCall(part);
          continuation = 'Please proceed to the next step of the plan.';
        default:
          logger.stderr(
            'Unrecognized response type from the model: $response.',
          );
      }
    }
    return continuation;
  }

  /// Executes a plan and returns a summary of it.
  Future<gemini.Content> _makeAndExecutePlan(
    String userPrompt,
    List<gemini.Tool> serverTools, {
    bool editPreviousPlan = false,
  }) async {
    final instruction =
        editPreviousPlan
            ? 'Edit the previous plan with the following changes:'
            : 'Create a new plan for the following task:';
    final planPrompt =
        '$instruction\n$userPrompt\n\n After you have made a '
        'plan, ask the user if they wish to proceed or if they want to make '
        'any changes to your plan.';
    _addToHistory(planPrompt);

    final planResponse = await _generateContent(
      context: chatHistory,
      tools: serverTools,
    );
    await _handleModelResponse(planResponse);

    final userResponse = await _waitForInputAndAddToHistory();
    final wasApproval = await _analyzeSentiment(userResponse);
    return wasApproval
        ? await _executePlan(serverTools)
        : await _makeAndExecutePlan(
          userResponse,
          serverTools,
          editPreviousPlan: true,
        );
  }

  /// Executes a plan and returns a summary of it.
  Future<gemini.Content> _executePlan(List<gemini.Tool> serverTools) async {
    // If assigned then it is used as the next input from the user
    // instead of reading from stdin.
    String? continuation =
        'Execute the plan. After each step of the plan, report your progress. '
        'When you are completely done executing the plan, say exactly '
        '"Workflow complete" followed by a summary of everything that was done '
        'so you can remember it for future tasks.';

    while (true) {
      final nextMessage = continuation ?? await stdinQueue.next;
      continuation = null;
      _addToHistory(nextMessage);
      final modelResponse = await _generateContent(
        context: chatHistory,
        tools: serverTools,
      );
      if (modelResponse.parts.first case final gemini.TextPart text) {
        if (text.text.toLowerCase().contains('workflow complete')) {
          return modelResponse;
        }
      }

      continuation = await _handleModelResponse(modelResponse);
    }
  }

  Future<String> _waitForInputAndAddToHistory() async {
    final input = await stdinQueue.next;
    _chatHistory.add(gemini.Content.text(input));
    return input;
  }

  void _addToHistory(String content) {
    _chatHistory.add(gemini.Content.text(content));
    _chatUpdateController.add(null);
  }

  /// Analyzes a user [message] to see if it looks like they approved of the
  /// previous action.
  Future<bool> _analyzeSentiment(String message) async {
    if (message.toLowerCase() == 'y' || message.toLowerCase() == 'yes') {
      return true;
    }
    final sentimentResult = await _generateContent(
      context: [
        gemini.Content.text(
          'Analyze the sentiment of the following response. If the response '
          'indicates a need for any changes, then this is not an approval. '
          'If you are highly confident that the user approves of running the '
          'previous action then respond with a single character "y". '
          'Otherwise respond with "n".',
        ),
        gemini.Content.text(message),
      ],
    );
    final response = StringBuffer();
    for (var part in sentimentResult.parts.whereType<gemini.TextPart>()) {
      response.write(part.text.trim());
    }
    return response.toString().toLowerCase() == 'y';
  }

  Future<gemini.Content> _generateContent({
    required Iterable<gemini.Content> context,
    List<gemini.Tool>? tools,
  }) async {
    isThinking.value = true;
    final progress = logger.progress('thinking');
    gemini.GenerateContentResponse? response;
    try {
      response = await model.generateContent(context, tools: tools);
      return response.candidates.single.content;
    } on gemini.GenerativeAIException catch (e) {
      return gemini.Content.model([gemini.TextPart('Error: $e')]);
    } finally {
      if (response != null) {
        final inputTokens = response.usageMetadata?.promptTokenCount;
        final outputTokens = response.usageMetadata?.candidatesTokenCount;
        totalInputTokens.value += inputTokens ?? 0;
        totalOutputTokens.value += outputTokens ?? 0;
        progress.finish(
          message:
              '(input token usage: ${totalInputTokens.value} (+$inputTokens), output '
              'token usage: ${totalOutputTokens.value} (+$outputTokens))',
          showTiming: true,
        );
      } else {
        progress.finish(message: 'failed', showTiming: true);
      }
      isThinking.value = false;
    }
  }

  /// Prints `text` and adds it to the chat history
  void _chatToUser(String text) {
    final content = gemini.Content.text(text);
    final dashText = StringBuffer();
    for (var part in content.parts.whereType<gemini.TextPart>()) {
      dashText.write(part.text);
    }
    logger.stdout('\n$dashText');
    // Add the non-personalized text to the context as it might lose some
    // useful info.
    _chatHistory.add(gemini.Content.model([gemini.TextPart(text)]));
    _chatUpdateController.add(null);
  }

  /// Handles a function call response from the model.
  ///
  /// Invokes a function and adds the result as context to the chat history.
  Future<void> _handleFunctionCall(gemini.FunctionCall functionCall) async {
    _chatHistory.add(gemini.Content.model([functionCall]));
    _chatUpdateController.add(null);
    final connection = connectionForFunction[functionCall.name]!;
    final result = await connection.callTool(
      CallToolRequest(name: functionCall.name, arguments: functionCall.args),
    );
    final response = StringBuffer();

    for (var content in result.content) {
      switch (content) {
        case final TextContent content when content.isText:
          response.writeln(content.text);
        case final ImageContent content when content.isImage:
          _chatHistory.add(
            gemini.Content.data(content.mimeType, base64Decode(content.data)),
          );
          _chatUpdateController.add(null);
          response.writeln('Image added to context');
        default:
          response.writeln('Got unsupported response type ${content.type}');
      }
    }
    _chatHistory.add(
      gemini.Content.functionResponse(functionCall.name, {
        'output': response.toString(),
      }),
    );
    _chatUpdateController.add(null);
  }

  /// Connects to all servers using [serverCommands].
  Future<void> _connectToServers() async {
    for (var server in serverCommands) {
      final parts = server.split(' ');
      try {
        final process = await Process.start(
          parts.first,
          parts.skip(1).toList(),
        );
        serverConnections.add(
          connectServer(
            stdioChannel(input: process.stdout, output: process.stdin),
            protocolLogSink: logSink,
          )..done.then((_) => process.kill()),
        );
      } catch (e) {
        logger.stderr('Failed to connect to server $server: $e');
      }
    }
  }

  /// Initialization handshake.
  Future<void> _initializeServers() async {
    // Use a copy of the list to allow removal during iteration
    final connectionsToInitialize = List.of(serverConnections);
    for (var connection in connectionsToInitialize) {
      final result = await connection.initialize(
        InitializeRequest(
          protocolVersion: ProtocolVersion.latestSupported,
          capabilities: capabilities,
          clientInfo: implementation,
        ),
      );
      final serverName = connection.serverInfo?.name ?? 'server';
      if (!result.protocolVersion!.isSupported) {
        logger.stderr(
          'Protocol version mismatch for $serverName, '
          'expected a version between ${ProtocolVersion.oldestSupported} and '
          '${ProtocolVersion.latestSupported}, but got '
          '${result.protocolVersion}. Disconnecting.',
        );
        await connection.shutdown();
        serverConnections.remove(connection);
      } else {
        connection.notifyInitialized(InitializedNotification());
      }
    }
  }

  /// Listens for log messages on all [serverConnections] that support logging.
  void _listenToLogs() {
    for (var connection in serverConnections) {
      if (connection.serverCapabilities.logging == null) {
        continue;
      }

      connection.setLogLevel(
        SetLevelRequest(
          level: verbose ? LoggingLevel.debug : LoggingLevel.warning,
        ),
      );
      connection.onLog.listen((event) {
        final logServerName = connection.serverInfo?.name ?? '?';
        logger.stdout(
          'Server Log ($logServerName/${event.level.name}): '
          '${event.logger != null ? '[${event.logger}] ' : ''}${event.data}',
        );
      });
    }
  }

  /// Lists all the tools available the [serverConnections].
  Future<List<gemini.Tool>> _listServerCapabilities() async {
    final functions = <gemini.FunctionDeclaration>[];
    for (var connection in serverConnections) {
      final response = await connection.listTools();
      for (var tool in response.tools) {
        functions.add(
          gemini.FunctionDeclaration(
            tool.name,
            tool.description ?? '',
            _schemaToGeminiSchema(tool.inputSchema),
          ),
        );
        connectionForFunction[tool.name] = connection;
      }
    }
    return functions.isEmpty
        ? []
        : [gemini.Tool(functionDeclarations: functions)];
  }

  gemini.Schema _schemaToGeminiSchema(Schema inputSchema, {bool? nullable}) {
    final description = inputSchema.description;

    switch (inputSchema.type) {
      case JsonType.object:
        final objectSchema = inputSchema as ObjectSchema;
        Map<String, gemini.Schema>? properties;
        if (objectSchema.properties case final originalProperties?) {
          properties = {
            for (var entry in originalProperties.entries)
              entry.key: _schemaToGeminiSchema(
                entry.value,
                nullable: objectSchema.required?.contains(entry.key) ?? false,
              ),
          };
        }
        return gemini.Schema.object(
          description: description,
          properties: properties ?? {},
          nullable: nullable,
        );
      case JsonType.string
          when (inputSchema as StringSchema).enumValues == null:
        return gemini.Schema.string(
          description: inputSchema.description,
          nullable: nullable,
        );
      case JsonType.string
          when (inputSchema as StringSchema).enumValues != null:
      case JsonType.enumeration: // ignore: deprecated_member_use
        final schema = inputSchema as StringSchema;
        return gemini.Schema.enumString(
          enumValues: schema.enumValues!.toList(),
          description: description,
          nullable: nullable,
        );
      case JsonType.list:
        final listSchema = inputSchema as ListSchema;
        final itemSchema =
            listSchema.items == null
                ?
                // A bit of a hack here, gemini requires item schemas, just fall
                // back on string.
                gemini.Schema.string()
                : _schemaToGeminiSchema(listSchema.items!);
        return gemini.Schema.array(
          description: description,
          items: itemSchema,
          nullable: nullable,
        );
      case JsonType.num:
        return gemini.Schema.number(
          description: description,
          nullable: nullable,
        );
      case JsonType.int:
        return gemini.Schema.integer(
          description: description,
          nullable: nullable,
        );
      case JsonType.bool:
        return gemini.Schema.boolean(
          description: description,
          nullable: nullable,
        );
      default:
        throw UnimplementedError(
          'Unimplemented schema type ${inputSchema.type}',
        );
    }
  }
}

/// If a [persona] is passed, it will be added to the system prompt as its own
/// paragraph.
gemini.Content systemInstructions({String? persona}) =>
    gemini.Content.system('''
You are a developer assistant for Dart and Flutter apps. You are an expert
software developer.
${persona != null ? '\n\$persona\n' : ''}
You can help developers with writing code by generating Dart and Flutter code or
making changes to their existing app. You can also help developers with
debugging their code by connecting into the live state of their apps, helping
them with all aspects of the software development lifecycle.

If a user asks about an error or a widget in the app, you should have several
tools available to you to aid in debugging, so make sure to use those.

If a user asks for code that requires adding or removing a dependency, you have
several tools available to you for managing pub dependencies.

If a user asks you to complete a task that requires writing to files, only edit
the part of the file that is required. After you apply the edit, the file should
contain all of the contents it did before with the changes you made applied.
After editing files, always fix any errors and perform a hot reload to apply the
changes.

When a user asks you to complete a task, you should first make a plan, which may
involve multiple steps and the use of tools available to you. Report this plan
back to the user before proceeding.

Generally, if you are asked to make code changes, you should follow this high
level process:

1) Write the code and apply the codebase
2) Check for static analysis errors and warnings and fix them
3) Check for runtime errors and fix them
4) Ensure that all code is formatted properly
5) Hot reload the changes to the running app

If, while executing your plan, you end up skipping steps because they are no
longer applicable, explain why you are skipping them.
''');
