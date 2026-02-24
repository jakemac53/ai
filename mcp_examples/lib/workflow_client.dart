import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dart_mcp/client.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:google_generative_ai/google_generative_ai.dart' as gemini;

import 'buffered_logger.dart';

final class WorkflowClient extends MCPClient
    with RootsSupport, ElicitationSupport {
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
  final ValueNotifier<int> totalCachedInputTokens = ValueNotifier(0);
  final ValueNotifier<int> latestTotalTokens = ValueNotifier(0);
  final ValueNotifier<bool> isThinking = ValueNotifier(false);
  final StreamQueue<String> stdinQueue;
  final List<String> serverCommands;
  final List<ServerConnection> serverConnections = [];
  final Map<String, ServerConnection?> connectionForFunction = {};

  final List<gemini.Content> _chatHistory = [];
  List<gemini.Content> get chatHistory => List.unmodifiable(_chatHistory);
  final List<gemini.Content> _uiChatHistory = [];
  List<gemini.Content> get uiChatHistory => List.unmodifiable(_uiChatHistory);
  final StreamController<void> _chatUpdateController =
      StreamController.broadcast();
  Stream<void> get onChatUpdate => _chatUpdateController.stream;

  final ValueNotifier<ElicitRequest?> activeElicitation = ValueNotifier(null);
  Completer<ElicitResult>? _elicitationCompleter;

  final gemini.GenerativeModel model;
  final bool verbose;

  int? _taskStartIndex;

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
      await _waitForInputAndAddToHistory();

      var response = await _generateContent(
        context: chatHistory,
        tools: serverTools,
      );
      while (true) {
        final continuation = await _handleModelResponse(response);
        if (continuation == null) break;
        _addToHistory(continuation);
        response = await _generateContent(
          context: chatHistory,
          tools: serverTools,
        );
      }
    }
  }

  @override
  FutureOr<ElicitResult> handleElicitation(ElicitRequest request) async {
    // Expose the current elicitation request directly to the Nocterm UI.
    activeElicitation.value = request;

    // Wait until the user completes it using submitElicitation
    _elicitationCompleter = Completer<ElicitResult>();
    final result = await _elicitationCompleter!.future;

    activeElicitation.value = null;
    _elicitationCompleter = null;
    return result;
  }

  void submitElicitation(ElicitResult result) {
    _elicitationCompleter?.complete(result);
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
          continuation = null;
        case gemini.FunctionCall():
          if (part.name == 'stop_workflow') {
            continuation = null;
          } else {
            continuation = 'Please proceed to the next step of the plan.';
          }
          await _handleFunctionCall(part);
        default:
          logger.stderr(
            'Unrecognized response type from the model: $response.',
          );
      }
    }

    return continuation;
  }

  Future<String> _waitForInputAndAddToHistory() async {
    final input = await stdinQueue.next;
    _chatHistory.add(gemini.Content.text(input));
    _uiChatHistory.add(gemini.Content.text(input));
    _chatUpdateController.add(null);
    return input;
  }

  void _addToHistory(String content) {
    _chatHistory.add(gemini.Content.text(content));
    _chatUpdateController.add(null);
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
        final inputTokens = response.usageMetadata?.promptTokenCount ?? 0;
        final outputTokens = response.usageMetadata?.candidatesTokenCount ?? 0;
        // Note: google_generative_ai doesn't currently expose cached tokens
        // in UsageMetadata directly in some versions, but we'll try to find it
        // if available or assume it's part of promptTokenCount for now.
        // If the API supports it, it might be in a field like 'cachedContentTokenCount'.
        // For this example, we'll placeholder it.
        final cachedTokens = 0; // Placeholder

        totalInputTokens.value += inputTokens;
        totalOutputTokens.value += outputTokens;
        totalCachedInputTokens.value += cachedTokens;
        latestTotalTokens.value = inputTokens + outputTokens;

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
    _uiChatHistory.add(gemini.Content.model([gemini.TextPart(text)]));
    _chatUpdateController.add(null);
  }

  /// Handles a function call response from the model.
  ///
  /// Invokes a function and adds the result as context to the chat history.
  Future<void> _handleFunctionCall(gemini.FunctionCall functionCall) async {
    _chatHistory.add(gemini.Content.model([functionCall]));
    _uiChatHistory.add(gemini.Content.model([functionCall]));
    _chatUpdateController.add(null);

    final connection = connectionForFunction[functionCall.name];
    final String output;

    if (connection == null) {
      // Internal tool
      switch (functionCall.name) {
        case 'start_workflow':
          if (_taskStartIndex != null) {
            output = 'Workflow already started, you must stop that one first';
          } else {
            output = 'Workflow started';
            _taskStartIndex = _chatHistory.length;
          }
        case 'stop_workflow':
          if (_taskStartIndex == null) {
            output = 'Workflow not started, you must start one first';
          } else {
            _chatHistory.removeRange(_taskStartIndex!, _chatHistory.length);
            output = functionCall.args['summary'] as String;
            _taskStartIndex = null;
          }
        default:
          output = 'Unknown internal tool ${functionCall.name}';
      }
    } else {
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
            _uiChatHistory.add(
              gemini.Content.data(content.mimeType, base64Decode(content.data)),
            );
            _chatUpdateController.add(null);
            response.writeln('Image added to context');
          default:
            response.writeln('Got unsupported response type ${content.type}');
        }
      }
      output = response.toString();
    }

    _chatHistory.add(
      gemini.Content.functionResponse(functionCall.name, {'output': output}),
    );
    _uiChatHistory.add(
      gemini.Content.functionResponse(functionCall.name, {'output': output}),
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

    // Add internal workflow tools
    functions.add(
      gemini.FunctionDeclaration(
        'start_workflow',
        'Call this tool to signal that you are starting a new workflow '
            'execution after your plan has been approved.',
        gemini.Schema.object(properties: {}),
      ),
    );
    connectionForFunction['start_workflow'] = null;

    functions.add(
      gemini.FunctionDeclaration(
        'stop_workflow',
        'Call this tool when you have completed all the steps in your plan.',
        gemini.Schema.object(
          properties: {
            'summary': gemini.Schema.string(
              description:
                  'A concise summary of all the work performed during '
                  'this workflow.',
            ),
          },
          requiredProperties: ['summary'],
        ),
      ),
    );
    connectionForFunction['stop_workflow'] = null;

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

When a user asks you to complete a non-trivial task (such as any coding related
task), you must start a new workflow by calling `start_workflow`. Then, you
should develop a plan with the user, which may involve multiple steps and the
use of tools available to you. Report this plan back to the user before
proceeding and ask for approval before proceeding.

When you have completed all the steps in the workflow, or the use or tells you to
stop the workflow, you must call the `stop_workflow` tool with a summary of
everything that was done.

Generally, if you are asked to make code changes, you should follow this high
level process:

1) Write the code and apply edits to the codebase
2) Check for static analysis errors and warnings and fix them
3) Check for runtime errors and fix them
4) Ensure that all code is formatted properly
5) Hot reload the changes to the running app

If, while executing your plan, you end up skipping steps because they are no
longer applicable, explain why you are skipping them.
''');
