// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:test/test.dart';
import 'shared/fake_generative_service.dart';
import 'shared/fake_skill_loader.dart';

void main() {
  group('WorkflowClient logic', () {
    late FakeGenerativeService fakeApi;
    late WorkflowClient client;
    late BufferedLogger logger;
    late FakeSkillLoader fakeSkillLoader;

    setUp(() {
      fakeApi = FakeGenerativeService();
      logger = BufferedLogger(name: 'test');
      fakeSkillLoader = FakeSkillLoader();
      client = WorkflowClient(
        [], // no server commands
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
      await _waitForRequest(fakeApi);
      fakeApi.sendTextResponse('I am ready.');
      fakeApi.closeRequest();
      await _waitForReady(client);

      // 2. User starts a task
      client.submitInput('Perform complex task');
      await _waitForRequest(fakeApi, count: 2);

      // 3. AI decides to start a workflow
      fakeApi.sendFunctionCall('start_workflow', {});
      fakeApi.closeRequest();

      // 4. AI performs a tool call (e.g. read_resource)
      await _waitForRequest(fakeApi, count: 3);
      // Verify start_workflow was sent back to AI in context (internal history)
      expect(
        fakeApi.requests.last.contents.any(
          (c) =>
              c.parts.any((p) => p.functionResponse?.name == 'start_workflow'),
        ),
        isTrue,
      );

      fakeApi.sendFunctionCall('read_resource', {'uri': 'file:///test.txt'});
      fakeApi.closeRequest();

      // 5. AI stops workflow with summary
      await _waitForRequest(fakeApi, count: 4);
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
  });
}

Future<void> _waitForRequest(FakeGenerativeService api, {int count = 1}) async {
  var attempts = 20;
  while (api.requests.length < count && attempts-- > 0) {
    await Future.delayed(Duration(milliseconds: 10));
  }
}

Future<void> _waitForReady(WorkflowClient client) async {
  var attempts = 20;
  while (!client.isReady.value && attempts-- > 0) {
    await Future.delayed(Duration(milliseconds: 10));
  }
}
