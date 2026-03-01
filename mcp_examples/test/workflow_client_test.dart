// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:dart_mcp/server.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/mcp_server_manager.dart';
import 'package:mcp_examples/workflow_client.dart';
import 'package:test/test.dart';

import 'shared/extensions.dart';
import 'shared/fake_generative_service.dart';
import 'shared/fake_skill_loader.dart';
import 'shared/test_mcp_server.dart';

void main() {
  group('WorkflowClient logic', () {
    late FakeGenerativeService fakeApi;
    late WorkflowClient client;
    late BufferedLogger logger;
    late FakeSkillLoader fakeSkillLoader;
    late FakeMcpServerManager fakeMcpServerManager;

    setUp(() {
      fakeMcpServerManager = FakeMcpServerManager();
      fakeApi = FakeGenerativeService();
      logger = BufferedLogger(name: 'test');
      fakeSkillLoader = FakeSkillLoader();
      client = WorkflowClient(
        fakeMcpServerManager,
        api: fakeApi,
        model: 'gemini-pro',
        logger: logger,
        autoStart: false,
        skillLoader: fakeSkillLoader,
      );
    });

    test('submitInput triggers model request after initialization', () async {
      // Start the chat
      client.startChat();

      // We expect an initial introduction request
      // We need to wait for the first request to arrive
      // Loop until a request is sent or we timeout
      var maxAttempts = 10;
      while (fakeApi.requests.isEmpty && maxAttempts-- > 0) {
        await Future.delayed(Duration(milliseconds: 10));
      }

      expect(
        fakeApi.requests,
        isNotEmpty,
        reason: 'Initial intro request should be sent',
      );
      expect(fakeApi.requests.length, 1);

      // Provide introduction response
      fakeApi.sendTextResponse('Hello! I am your AI assistant.');
      fakeApi.closeRequest();

      // Wait for intro to finish and client to become ready
      maxAttempts = 10;
      while (!client.isReady.value && maxAttempts-- > 0) {
        await Future.delayed(Duration(milliseconds: 10));
      }
      expect(client.isReady.value, isTrue);
      expect(
        client.uiChatHistory.last.parts.first.text,
        'Hello! I am your AI assistant.',
      );

      // Now submit user input
      client.submitInput('Do something interesting');

      // Wait for internal loop to pick up input and send to API
      maxAttempts = 10;
      while (fakeApi.requests.length < 2 && maxAttempts-- > 0) {
        await Future.delayed(Duration(milliseconds: 10));
      }

      expect(
        fakeApi.requests.length,
        2,
        reason: 'Should have sent a new request for user input',
      );

      // Verify content of the request
      final lastRequest = fakeApi.requests.last;
      expect(lastRequest.contents.last.role, 'user');
      expect(
        lastRequest.contents.last.parts.first.text,
        'Do something interesting',
      );
    });

    test('workflow orchestration hides tool calls from UI history', () async {
      client.startChat();

      // 1. Initial Intro
      await fakeApi.nextRequest;
      fakeApi.sendTextResponse('I am ready.');
      fakeApi.closeRequest();
      await client.ready;

      // 2. User starts a task
      client.submitInput('Perform complex task');
      await fakeApi.nextRequest;

      // 3. AI decides to start a workflow
      fakeApi.sendFunctionCall('start_workflow', {});
      fakeApi.closeRequest();

      // 4. AI performs a tool call (e.g. read_resource)
      final request = await fakeApi.nextRequest;
      // Verify start_workflow was sent back to AI in context (internal history)
      expect(
        request.contents.any(
          (c) =>
              c.parts.any((p) => p.functionResponse?.name == 'start_workflow'),
        ),
        isTrue,
      );

      fakeApi.sendFunctionCall('read_resource', {'uri': 'file:///test.txt'});
      fakeApi.closeRequest();

      // 5. AI stops workflow with summary
      await fakeApi.nextRequest;
      fakeApi.sendFunctionCall('stop_workflow', {
        'summary': 'Task completed successfully.',
      });
      fakeApi.closeRequest();

      // 6. Wait for processing to finish
      // The loop will wait for input again after stop_workflow
      await Future.delayed(Duration(milliseconds: 50));

      // 7. Verify UI History vs Internal History
      // uiChatHistory should NOT contain read_resource or start_workflow
      final uiTexts =
          client.uiChatHistory
              .expand((c) => c.parts)
              .where((p) => p.text != null)
              .map((p) => p.text!)
              .toList();

      expect(uiTexts, contains('Task completed successfully.'));
      expect(
        uiTexts.any((t) => t.contains('read_resource')),
        isFalse,
        reason: 'Tool calls should be hidden from UI',
      );

      // internal chatHistory SHOULD contain them
      final internalTools =
          client.chatHistory
              .expand((c) => c.parts)
              .where((p) => p.functionCall != null)
              .map((p) => p.functionCall!.name)
              .toList();

      expect(internalTools, contains('read_resource'));
      expect(internalTools, contains('start_workflow'));
      expect(internalTools, contains('stop_workflow'));
    });

    test('MCP tools are discovered and can be called', () async {
      fakeMcpServerManager.serverFactories.add((channel) async {
        final server = TestMcpServer(channel);
        server.registerTool(
          Tool(
            name: 'mcp_tool',
            description: 'An MCP tool',
            inputSchema: ObjectSchema(properties: {}),
          ),
          (request) async =>
              CallToolResult(content: [Content.text(text: 'MCP Result')]),
        );
        return server;
      });

      client.startChat();

      // 1. Check tool discovery in the first API request
      final request1 = await fakeApi.nextRequest;
      final tools = request1.tools;
      expect(
        tools.any(
          (t) =>
              t.functionDeclarations.any((f) => f.name == 'mcp_tool') == true,
        ),
        isTrue,
        reason: 'The mcp_tool should be discovered and sent to Gemini',
      );

      fakeApi.sendTextResponse('Initialization done.');
      fakeApi.closeRequest();
      await client.ready;

      // 2. Simulate Gemini calling the MCP tool
      client.submitInput('Call the mcp tool');
      await fakeApi.nextRequest;
      fakeApi.sendFunctionCall('mcp_tool', {});
      fakeApi.closeRequest();

      // 3. Verify the client sends the tool result back to Gemini
      final request3 = await fakeApi.nextRequest;
      expect(
        request3.contents.any(
          (c) => c.parts.any(
            (p) =>
                p.functionResponse?.name == 'mcp_tool' &&
                p.functionResponse?.response?.fields['output']?.stringValue ==
                    'MCP Result\n',
          ),
        ),
        isTrue,
        reason: 'The result of the MCP tool should be sent back to Gemini',
      );
    });

    test('MCP resources are discovered and can be read', () async {
      fakeMcpServerManager.serverFactories.add((channel) async {
        final server = TestMcpServer(channel);
        server.addResource(
          Resource(
            uri: 'test://resource',
            name: 'Test Resource',
            description: 'A test resource',
            mimeType: 'text/plain',
          ),
          (request) async => ReadResourceResult(
            contents: [
              TextResourceContents(
                text: 'Resource Content',
                uri: 'test://resource',
              ),
            ],
          ),
        );
        return server;
      });

      client.startChat();

      await fakeApi.nextRequest;
      fakeApi.sendTextResponse('Initialization done.');
      fakeApi.closeRequest();
      await client.ready;

      // 1. Test list_resources internal tool
      client.submitInput('List resources');
      await fakeApi.nextRequest;
      fakeApi.sendFunctionCall('list_resources', {});
      fakeApi.closeRequest();

      final request2 = await fakeApi.nextRequest;
      final resourcesPart = request2.contents
          .expand((c) => c.parts)
          .firstWhere((p) => p.functionResponse?.name == 'list_resources');
      final resourcesJson =
          resourcesPart
              .functionResponse!
              .response
              ?.fields['output']
              ?.stringValue;
      expect(resourcesJson, contains('Test Resource'));
      fakeApi.sendTextResponse('I got all the resources');
      fakeApi.closeRequest();

      // 2. Test read_resource internal tool
      client.submitInput('Read the test://resource resource');
      await fakeApi.nextRequest;
      fakeApi.sendFunctionCall('read_resource', {'uri': 'test://resource'});
      fakeApi.closeRequest();

      final request3 = await fakeApi.nextRequest;
      final readResourcePart = request3.contents
          .expand((c) => c.parts)
          .firstWhere((p) => p.functionResponse?.name == 'read_resource');
      final resourceContent =
          readResourcePart
              .functionResponse!
              .response
              ?.fields['output']
              ?.stringValue;
      expect(resourceContent, contains('Resource Content'));
      fakeApi.sendTextResponse('I read the resource');
      fakeApi.closeRequest();
    });

    test('MCP prompts are discovered', () async {
      fakeMcpServerManager.serverFactories.add((channel) async {
        final server = TestMcpServer(channel);
        server.addPrompt(
          Prompt(
            name: 'test_prompt',
            description: 'A test prompt',
            arguments: [
              PromptArgument(
                name: 'arg1',
                description: 'Argument 1',
                required: true,
              ),
            ],
          ),
          (request) async => GetPromptResult(
            description: 'Test Prompt Result',
            messages: [
              PromptMessage(
                role: Role.user,
                content: TextContent(text: 'Prompt text'),
              ),
            ],
          ),
        );
        return server;
      });

      client.startChat();

      await fakeApi.nextRequest;
      fakeApi.sendTextResponse('Initialization done.');
      fakeApi.closeRequest();
      await client.ready;

      expect(client.availablePrompts.value.length, 1);
      expect(client.availablePrompts.value.first.name, 'test_prompt');
    });
  });
}
