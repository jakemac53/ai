// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:dart_mcp/client.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;
import 'package:google_cloud_protobuf/protobuf.dart' as pb;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'buffered_logger.dart';
import 'skills.dart';

final class WorkflowClient extends MCPClient
    with RootsSupport, ElicitationFormSupport {
  WorkflowClient(
    this.serverCommands, {
    required String geminiApiKey,
    required String model,
    required this.logger,
    String? dtdUri,
    this.verbose = false,
    this.persona,
    File? logFile,
  }) : modelName = model.startsWith('models/') ? model : 'models/$model',
       _client = auth.clientViaApiKey(geminiApiKey),
       stdinQueue = StreamQueue(_inputController.stream),
       _skillLoader = SkillLoader(logger: logger),
       super(Implementation(name: 'Gemini workflow client', version: '0.1.0')) {
    api = gemini.GenerativeService(client: _client);
    logSink = _createLogSink(logFile);
    addRoot(
      Root(
        uri: Directory.current.absolute.uri.toString(),
        name: 'The working dir',
      ),
    );
    _chatHistory.add(
      gemini.Content(
        parts: [
          gemini.Part(
            text:
                'The current working directory is '
                '${Directory.current.absolute.uri.toString()}. Convert all relative '
                'URIs to absolute using this root. For tools that want a root, use '
                'this URI.',
          ),
        ],
        role: 'user',
      ),
    );
    if (dtdUri != null) {
      _chatHistory.add(
        gemini.Content(
          parts: [
            gemini.Part(
              text:
                  'If you need to establish a Dart Tooling Daemon (DTD) connection, '
                  'use this URI: $dtdUri.',
            ),
          ],
          role: 'user',
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
  final SkillLoader _skillLoader;
  Sink<String>? logSink;
  final ValueNotifier<int> totalInputTokens = ValueNotifier(0);
  final ValueNotifier<int> totalOutputTokens = ValueNotifier(0);
  final ValueNotifier<int> totalCachedInputTokens = ValueNotifier(0);
  final ValueNotifier<int> latestTotalTokens = ValueNotifier(0);
  final ValueNotifier<int> totalThoughtsTokens = ValueNotifier(0);
  final ValueNotifier<bool> isThinking = ValueNotifier(false);
  final ValueNotifier<bool> isStreaming = ValueNotifier(false);

  final ValueNotifier<bool> thinkingEnabled = ValueNotifier(false);
  final ValueNotifier<int> thinkingBudget = ValueNotifier(1024);
  final StreamQueue<String> stdinQueue;
  final List<String> serverCommands;
  final List<ServerConnection> serverConnections = [];
  final Map<String, ServerConnection?> connectionForFunction = {};
  final Map<String, ServerConnection> connectionForPrompt = {};

  final List<gemini.Content> _chatHistory = [];
  List<gemini.Content> get chatHistory => List.unmodifiable(_chatHistory);
  final List<gemini.Content> _uiChatHistory = [];
  List<gemini.Content> get uiChatHistory => List.unmodifiable(_uiChatHistory);
  final StreamController<void> _chatUpdateController =
      StreamController.broadcast();
  Stream<void> get onChatUpdate => _chatUpdateController.stream;

  final ValueNotifier<ElicitRequest?> activeElicitation = ValueNotifier(null);
  Completer<ElicitResult>? _elicitationCompleter;

  final ValueNotifier<Prompt?> activePromptElicitation = ValueNotifier(null);
  Completer<Map<String, String>?>? _promptElicitationCompleter;

  final ValueNotifier<List<Prompt>> availablePrompts = ValueNotifier([]);
  final ValueNotifier<List<Resource>> availableResources = ValueNotifier([]);
  final ValueNotifier<List<Skill>> availableSkills = ValueNotifier([]);

  late final gemini.GenerativeService api;
  final http.Client _client;
  final String modelName;
  gemini.Content get systemInstruction {
    final instructions = [
      'You are a developer assistant for Dart and Flutter apps. You are an expert software developer.',
      if (persona != null) '\n$persona\n',
      ..._serverInstructions,
      'You can help developers with writing code by generating Dart and Flutter code or making changes to their existing app. You can also help developers with debugging their code by connecting into the live state of their apps, helping them with all aspects of the software development lifecycle.',
      'If a user asks about an error or a widget in the app, you should have several tools available to you to aid in debugging, so make sure to use those.',
      'If a user asks for code that requires adding or removing a dependency, you have several tools available to you for managing pub dependencies.',
      'If a user asks for code that requires writing to files, only edit the part of the file that is required. After you apply the edit, the file should contain all of the contents it did before with the changes you made applied. After editing files, always fix any errors and perform a hot reload to apply the changes.',
      'When a user asks you to complete a non-trivial task (such as any coding related task), you must start a new workflow by calling `start_workflow`. Then, you should develop a plan with the user, which may involve multiple steps and the use of tools available to you. Report this plan back to the user before proceeding and ask for approval before proceeding.',
      'You have "Skills" available for assisting with various tasks. Use `read_skill` to read the instructions for a specific skill.',
    ];
    return gemini.Content(
      parts: [gemini.Part(text: instructions.join('\n\n'))],
    );
  }

  final String? persona;
  final List<String> _serverInstructions = [];
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
    await _fetchPrompts();
    await _fetchResources();
    await _fetchSkills();

    _chatHistory.add(
      gemini.Content(
        parts: [
          gemini.Part(text: '<resource-list>'),
          for (final resource in availableResources.value)
            gemini.Part(
              text:
                  '<resource uri="${resource.uri}" name="${resource.name}">${resource.description}</resource>',
            ),
          gemini.Part(text: '</resource-list>'),
          gemini.Part(text: '<skill-list>'),
          for (final skill in availableSkills.value)
            gemini.Part(
              text: '<skill name="${skill.name}">${skill.description}</skill>',
            ),
          gemini.Part(text: '</skill-list>'),
        ],
        role: 'user',
      ),
    );

    // Introduce yourself.
    _addToHistory('Please introduce yourself and explain how you can help.');
    final introResponse = await _generateContent(
      context: chatHistory,
      tools: serverTools,
    );
    // Note: _generateContent now adds to history directly when it starts streaming.
    // So we don't need to add it here, but we still need to process any tool calls
    // or continuations from the final result.
    await _handleModelResponse(introResponse, addToHistory: false);

    while (true) {
      await _waitForInputAndAddToHistory();

      var response = await _generateContent(
        context: chatHistory,
        tools: serverTools,
      );
      while (true) {
        final continuation =
            await _handleModelResponse(response, addToHistory: false);
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
  FutureOr<ElicitResult> handleElicitation(
    ElicitRequest request,
    ServerConnection connection,
  ) async {
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

  Future<Map<String, String>?> elicitPromptArguments(Prompt prompt) async {
    activePromptElicitation.value = prompt;
    _promptElicitationCompleter = Completer<Map<String, String>?>();
    final result = await _promptElicitationCompleter!.future;
    activePromptElicitation.value = null;
    _promptElicitationCompleter = null;
    return result;
  }

  void submitPromptElicitation(Map<String, String>? arguments) {
    _promptElicitationCompleter?.complete(arguments);
  }

  /// Handles a response from the model.
  ///
  /// If this function returns a [String], then it should be fed back into the
  /// model as a user message in order to continue the conversation.
  /// If [addToHistory] is true (default), the response is added to the history.
  /// If false, it's assumed the response is already in history (e.g. from streaming).
  Future<String?> _handleModelResponse(
    gemini.Content response, {
    bool addToHistory = true,
  }) async {
    if (addToHistory) {
      _chatHistory.add(response);
      _uiChatHistory.add(response);
      _chatUpdateController.add(null);
    }

    String? continuation;
    for (var part in response.parts) {
      if (part.text != null) {
        if (addToHistory) {
          _chatToUser(part.text!);
        }
        continuation = null;
      } else if (part.functionCall != null) {
        final functionCall = part.functionCall!;
        if (functionCall.name == 'stop_workflow') {
          continuation = null;
        } else {
          continuation = 'Please proceed to the next step of the plan.';
        }
        await handleFunctionCall(functionCall, addToHistory: addToHistory);
      } else {
        logger.stderr('Unrecognized response type from the model: $response.');
      }
    }

    return continuation;
  }

  Future<String> _waitForInputAndAddToHistory() async {
    final input = await stdinQueue.next;
    if (input.isNotEmpty) {
      final content = gemini.Content(
        parts: [gemini.Part(text: input)],
        role: 'user',
      );
      _chatHistory.add(content);
      _uiChatHistory.add(content);
      _chatUpdateController.add(null);
    }
    return input;
  }

  void _addToHistory(String content) {
    _chatHistory.add(
      gemini.Content(parts: [gemini.Part(text: content)], role: 'user'),
    );
    _chatUpdateController.add(null);
  }

  Future<gemini.Content> _generateContent({
    required List<gemini.Content> context,
    List<gemini.Tool>? tools,
  }) async {
    final progress = logger.progress('thinking');
    gemini.GenerateContentResponse? lastResponse;
    final accumulatedParts = <gemini.Part>[];

    isThinking.value = false;
    isStreaming.value = true;

    // Create the initial empty model message in history and keep reference to update
    final initialContent = gemini.Content(
      parts: [],
      role: 'model',
    );
    _chatHistory.add(initialContent);
    _uiChatHistory.add(initialContent);
    _chatUpdateController.add(null);

    final historyIndex = _chatHistory.length - 1;
    final uiHistoryIndex = _uiChatHistory.length - 1;

    try {
      final stream = api.streamGenerateContent(
        gemini.GenerateContentRequest(
          model: modelName,
          contents: context,
          tools: tools ?? [],
          systemInstruction: systemInstruction,
          generationConfig: gemini.GenerationConfig(
            thinkingConfig:
                thinkingEnabled.value
                    ? gemini.ThinkingConfig(
                      includeThoughts: true,
                      thinkingBudget: thinkingBudget.value,
                    )
                    : null,
          ),
        ),
      );

      await for (final response in stream) {
        lastResponse = response;
        final content = response.candidates.firstOrNull?.content;
        if (content == null) continue;

        for (final part in content.parts) {
          if (part.text != null) {
            // Append text to the last part if it was also text and same thought status
            if (accumulatedParts.isNotEmpty &&
                accumulatedParts.last.text != null &&
                accumulatedParts.last.thought == part.thought) {
              accumulatedParts.last = gemini.Part(
                text: accumulatedParts.last.text! + part.text!,
                thought: part.thought,
                thoughtSignature: part.thoughtSignature,
              );
            } else {
              accumulatedParts.add(part);
            }
          } else {
            accumulatedParts.add(part);
          }
        }

        // Update the history entries in place
        final updatedContent = gemini.Content(
          parts: List.from(accumulatedParts),
          role: 'model',
        );
        _chatHistory[historyIndex] = updatedContent;
        _uiChatHistory[uiHistoryIndex] = updatedContent;
        _chatUpdateController.add(null);
      }

      return _chatHistory[historyIndex];
    } catch (e) {
      final errorContent = gemini.Content(
        parts: [gemini.Part(text: 'Error: $e')],
        role: 'model',
      );
      // We already pushed an entry, so we replace it with the error
      _chatHistory[historyIndex] = errorContent;
      _uiChatHistory[uiHistoryIndex] = errorContent;
      _chatUpdateController.add(null);
      return errorContent;
    } finally {
      isStreaming.value = false;
      isThinking.value = false;
      _chatUpdateController.add(null);
      if (lastResponse != null) {
        final usage = lastResponse.usageMetadata;
        if (usage != null) {
          final inputTokens = usage.promptTokenCount;
          final outputTokens = usage.candidatesTokenCount;
          final cachedTokens = usage.cachedContentTokenCount;
          final thoughtsTokens = usage.thoughtsTokenCount;

          totalInputTokens.value += inputTokens;
          totalOutputTokens.value += outputTokens;
          totalCachedInputTokens.value += cachedTokens;
          totalThoughtsTokens.value += thoughtsTokens;
          latestTotalTokens.value = inputTokens + outputTokens + thoughtsTokens;

          progress.finish(
            message:
                '(input token usage: ${totalInputTokens.value} (+$inputTokens), output '
                'token usage: ${totalOutputTokens.value} (+$outputTokens), thoughts: ${totalThoughtsTokens.value} (+$thoughtsTokens))',
            showTiming: true,
          );
        } else {
          progress.finish(message: 'done', showTiming: true);
        }
      } else {
        progress.finish(message: 'failed', showTiming: true);
      }
    }
  }

  /// Prints `text` and adds it to the chat history
  void _chatToUser(String text) {
    final content = gemini.Content(
      parts: [gemini.Part(text: text)],
      role: 'model',
    );
    _chatHistory.add(content);
    _uiChatHistory.add(content);
    _chatUpdateController.add(null);
  }

  /// Handles a function call response from the model.
  ///
  /// Invokes a function and adds the result as context to the chat history.
  /// If [addToHistory] is true (default), the call is added to history.
  /// If false, it's assumed the call is already in history (e.g. from streaming).
  Future<void> handleFunctionCall(
    gemini.FunctionCall functionCall, {
    bool addToHistory = true,
  }) async {
    if (addToHistory) {
      final callContent = gemini.Content(
        parts: [gemini.Part(functionCall: functionCall)],
        role: 'model',
      );
      _chatHistory.add(callContent);
      _uiChatHistory.add(callContent);
      _chatUpdateController.add(null);
    }

    final connection = connectionForFunction[functionCall.name];
    var output = '';

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
            output = functionCall.args?.fields['summary']?.stringValue ?? '';
            _taskStartIndex = null;
          }
        case 'list_resources':
          final resources = <Resource>[];
          for (var connection in serverConnections) {
            if (connection.serverCapabilities.resources != null) {
              final result = await connection.listResources();
              resources.addAll(result.resources);
            }
          }
          output = jsonEncode([
            for (var r in resources)
              {
                'uri': r.uri,
                'name': r.name,
                'description': r.description,
                'mimeType': r.mimeType,
              },
          ]);
        case 'read_resource':
          final uri = functionCall.args?.fields['uri']?.stringValue;
          if (uri == null) {
            output = 'Error: uri argument is required';
          } else {
            ReadResourceResult? result;
            for (var connection in serverConnections) {
              if (connection.serverCapabilities.resources != null) {
                try {
                  result = await connection.readResource(
                    ReadResourceRequest(uri: uri),
                  );
                  break;
                } catch (_) {
                  // Try next server
                }
              }
            }
            if (result == null) {
              output = 'Error: Resource not found at $uri';
            } else {
              final sb = StringBuffer();
              for (var content in result.contents) {
                if (content is TextResourceContents) {
                  sb.writeln(content.text);
                } else if (content is BlobResourceContents) {
                  sb.writeln('Binary data (mimeType: ${content.mimeType})');
                }
              }
              output = sb.toString();
            }
          }
        case 'read_skill':
          final name = functionCall.args?.fields['name']?.stringValue;
          if (name == null) {
            output = 'Error: name argument is required';
          } else {
            try {
              final skill = availableSkills.value.firstWhere(
                (s) => s.name == name,
              );
              output = await File(skill.path).readAsString();
            } catch (e) {
              output = 'Error: Skill "$name" not found';
            }
          }
        default:
          output = 'Unknown internal tool ${functionCall.name}';
      }
    } else {
      final result = await connection.callTool(
        CallToolRequest(
          name: functionCall.name,
          arguments: functionCall.args?.toJson() as Map<String, Object?>? ?? {},
        ),
      );
      final response = StringBuffer();

      for (var content in result.content) {
        switch (content) {
          case final TextContent content when content.isText:
            response.writeln(content.text);
          case final ImageContent content when content.isImage:
            final part = gemini.Part(
              inlineData: gemini.Blob(
                data: base64Decode(content.data),
                mimeType: content.mimeType,
              ),
            );
            _chatHistory.add(gemini.Content(parts: [part], role: 'user'));
            _uiChatHistory.add(gemini.Content(parts: [part], role: 'user'));
            _chatUpdateController.add(null);
            response.writeln('Image added to context');
          default:
            response.writeln('Got unsupported response type ${content.type}');
        }
      }
      output = response.toString();
    }

    final responseContent = gemini.Content(
      parts: [
        gemini.Part(
          functionResponse: gemini.FunctionResponse(
            name: functionCall.name,
            response: pb.Struct.fromJson({'output': output}),
          ),
        ),
      ],
      role: 'user',
    );
    _chatHistory.add(responseContent);
    _uiChatHistory.add(responseContent);
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
        if (result.instructions != null) {
          _serverInstructions.add(result.instructions!);
        }
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
          '${event.level.name != 'info' ? '[${event.logger}] ' : ''}${event.data}',
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
            name: tool.name,
            description: tool.description ?? '',
            parameters: _schemaToGeminiSchema(tool.inputSchema),
          ),
        );
        connectionForFunction[tool.name] = connection;
      }
    }

    // Add internal workflow tools
    functions.add(
      gemini.FunctionDeclaration(
        name: 'start_workflow',
        description:
            'Call this tool to signal that you are starting a new workflow '
            'execution after your plan has been approved.',
        parameters: gemini.Schema(type: gemini.Type.object, properties: {}),
      ),
    );
    connectionForFunction['start_workflow'] = null;

    functions.add(
      gemini.FunctionDeclaration(
        name: 'stop_workflow',
        description:
            'Call this tool when you have completed all the steps in your plan.',
        parameters: gemini.Schema(
          type: gemini.Type.object,
          properties: {
            'summary': gemini.Schema(
              type: gemini.Type.string,
              description:
                  'A concise summary of all the work performed during '
                  'this workflow.',
            ),
          },
          required: ['summary'],
        ),
      ),
    );
    connectionForFunction['stop_workflow'] = null;

    if (serverConnections.any((c) => c.serverCapabilities.resources != null)) {
      functions.add(
        gemini.FunctionDeclaration(
          name: 'list_resources',
          description:
              'Lists all resources available from all connected MCP servers.',
          parameters: gemini.Schema(type: gemini.Type.object, properties: {}),
        ),
      );
      connectionForFunction['list_resources'] = null;

      functions.add(
        gemini.FunctionDeclaration(
          name: 'read_resource',
          description: 'Reads a resource from an MCP server by its URI.',
          parameters: gemini.Schema(
            type: gemini.Type.object,
            properties: {
              'uri': gemini.Schema(
                type: gemini.Type.string,
                description: 'The URI of the resource to read.',
              ),
            },
            required: ['uri'],
          ),
        ),
      );
      connectionForFunction['read_resource'] = null;
    }

    functions.add(
      gemini.FunctionDeclaration(
        name: 'read_skill',
        description:
            'Reads the instructions and details of a specific agent skill by its name.',
        parameters: gemini.Schema(
          type: gemini.Type.object,
          properties: {
            'name': gemini.Schema(
              type: gemini.Type.string,
              description: 'The name of the skill to read.',
            ),
          },
          required: ['name'],
        ),
      ),
    );
    connectionForFunction['read_skill'] = null;

    return functions.isEmpty
        ? []
        : [gemini.Tool(functionDeclarations: functions)];
  }

  /// Lists all the prompts available on the [serverConnections].
  Future<void> _fetchPrompts() async {
    final prompts = <Prompt>[];
    for (var connection in serverConnections) {
      if (connection.serverCapabilities.prompts != null) {
        try {
          final response = await connection.listPrompts();
          for (final prompt in response.prompts) {
            prompts.add(prompt);
            connectionForPrompt[prompt.name] = connection;
          }
        } catch (e) {
          logger.stderr('Failed to list prompts from server: $e');
        }
      }
    }
    availablePrompts.value = prompts;
  }

  Future<void> _fetchResources() async {
    final resources = <Resource>[];
    for (var connection in serverConnections) {
      if (connection.serverCapabilities.resources != null) {
        final result = await connection.listResources();
        resources.addAll(result.resources);
      }
    }
    availableResources.value = resources;
  }

  Future<void> _fetchSkills() async {
    availableSkills.value = await _skillLoader.load();
  }

  Future<void> usePrompt(Prompt prompt, Map<String, String>? arguments) async {
    final connection = connectionForPrompt[prompt.name];
    if (connection == null) {
      logger.stderr('No connection found for prompt ${prompt.name}');
      return;
    }

    try {
      final response = await connection.getPrompt(
        GetPromptRequest(name: prompt.name, arguments: arguments),
      );

      for (final message in response.messages) {
        final role = message.role == Role.user ? 'user' : 'model';
        final parts = <gemini.Part>[];

        final content = message.content;
        if (content is TextContent) {
          parts.add(gemini.Part(text: content.text));
        } else if (content is ImageContent) {
          parts.add(
            gemini.Part(
              inlineData: gemini.Blob(
                data: base64Decode(content.data),
                mimeType: content.mimeType,
              ),
            ),
          );
        } else if (content is EmbeddedResource) {
          final resource = content.resource;
          if (resource is TextResourceContents) {
            parts.add(
              gemini.Part(
                text: '[Resource: ${resource.uri}]\n${resource.text}',
              ),
            );
          } else if (resource is BlobResourceContents) {
            parts.add(
              gemini.Part(
                inlineData: gemini.Blob(
                  data: base64Decode(resource.blob),
                  mimeType: resource.mimeType ?? '',
                ),
              ),
            );
          }
        }

        final geminiContent = gemini.Content(parts: parts, role: role);
        _chatHistory.add(geminiContent);
        _uiChatHistory.add(geminiContent);
      }
      _chatUpdateController.add(null);
      _inputController.add('');
    } catch (e) {
      logger.stderr('Failed to get prompt ${prompt.name}: $e');
    }
  }

  gemini.Schema _schemaToGeminiSchema(Schema inputSchema, {bool? nullable}) {
    final description = inputSchema.description ?? '';

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
        return gemini.Schema(
          type: gemini.Type.object,
          description: description,
          properties: properties ?? <String, gemini.Schema>{},
          nullable: nullable ?? false,
          required: objectSchema.required ?? <String>[],
        );
      case JsonType.string
          when (inputSchema as StringSchema).enumValues == null:
        return gemini.Schema(
          type: gemini.Type.string,
          description: description,
          nullable: nullable ?? false,
        );
      case JsonType.string
          when (inputSchema as StringSchema).enumValues != null:
      case JsonType.enumeration: // ignore: deprecated_member_use
        final schema = inputSchema as StringSchema;
        return gemini.Schema(
          type: gemini.Type.string,
          enum$: schema.enumValues?.whereType<String>().toList() ?? <String>[],
          description: description,
          nullable: nullable ?? false,
        );
      case JsonType.list:
        final listSchema = inputSchema as ListSchema;
        final itemSchema =
            listSchema.items == null
                ?
                // A bit of a hack here, gemini requires item schemas, just fall
                // back on string.
                gemini.Schema(type: gemini.Type.string)
                : _schemaToGeminiSchema(listSchema.items!);
        return gemini.Schema(
          type: gemini.Type.array,
          description: description,
          items: itemSchema,
          nullable: nullable ?? false,
        );
      case JsonType.num:
        return gemini.Schema(
          type: gemini.Type.number,
          description: description,
          nullable: nullable ?? false,
        );
      case JsonType.int:
        return gemini.Schema(
          type: gemini.Type.integer,
          description: description,
          nullable: nullable ?? false,
        );
      case JsonType.bool:
        return gemini.Schema(
          type: gemini.Type.boolean,
          description: description,
          nullable: nullable ?? false,
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
gemini.Content systemInstructions({String? persona}) => gemini.Content(
  parts: [
    gemini.Part(
      text: '''
You are a developer assistant for Dart and Flutter apps. You are an expert
software developer.
${persona != null ? '\n$persona\n' : ''}
You can help developers with writing code by generating Dart and Flutter code or
making changes to their existing app. You can also help developers with
debugging their code by connecting into the live state of their apps, helping
them with all aspects of the software development lifecycle.

If a user asks about an error or a widget in the app, you should have several
tools available to you to aid in debugging, so make sure to use those.

If a user asks for code that requires adding or removing a dependency, you have
several tools available to you for managing pub dependencies.

If a user asks for code that requires writing to files, only edit
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
''',
    ),
  ],
  role: 'system',
);
