// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_mcp/server.dart';
import 'package:mcp_examples/mcp_server_manager.dart';
import 'package:mcp_examples/ui/app.dart';
import 'package:nocterm/nocterm.dart';
import 'package:test/test.dart';

import '../shared/extensions.dart';
import '../shared/fake_generative_service.dart';
import '../shared/test_mcp_server.dart';
import '../shared/test_workflow_client.dart';

void main() {
  late TestWorkflowClient client;
  late FakeGenerativeService fakeGemini;

  setUp(() {
    NoctermBinding.resetInstance();
    client = TestWorkflowClient();
    fakeGemini = client.api as FakeGenerativeService;
  });

  tearDown(() async {
    await client.shutdown();
  });

  test('Prompt autocomplete shows up when typing /', () async {
    await testNocterm('Prompt autocomplete', (tester) async {
      final manager = client.mcpServerManager as FakeMcpServerManager;
      manager.serverFactories.add((channel) async {
        final server = TestMcpServer(channel);
        server.addPrompt(
          Prompt(
            name: 'test-prompt',
            description: 'A test prompt',
            arguments: [
              PromptArgument(
                name: 'arg1',
                description: 'Argument 1',
                required: true,
              ),
            ],
          ),
          (request) => GetPromptResult(
            description: 'Test prompt description',
            messages: [
              PromptMessage(
                role: Role.user,
                content: TextContent(
                  text: 'Hello from prompt ${request.arguments!['arg1']}',
                ),
              ),
            ],
          ),
        );
        return server;
      });

      // Start the client chat loop
      client.startChat();

      // Start the app
      await tester.pumpComponent(ClientApp(client: client));

      // Splash screen should be showing initially
      await tester.pump();
      expect(
        tester.terminalState,
        containsText('Initializing servers & skills...'),
      );

      // Wait for introduction request
      final introRequest = await fakeGemini.nextRequest;
      expect(
        introRequest.contents.last.parts.last.text,
        contains('Please introduce yourself'),
      );

      fakeGemini.sendTextResponse('I am your assistant.');
      fakeGemini.closeRequest();

      // Wait for isReady to become true and transition to happen
      await client.ready;

      // Ensure we are in Chat view
      await tester.pump();
      expect(tester.terminalState, containsText('Chat'));

      // Type '/' to trigger prompt autocomplete
      await tester.enterText('/');
      await tester.pump();

      // Verify autocomplete overlay is visible
      expect(tester.terminalState, containsText('test-prompt'));
      expect(tester.terminalState, containsText('A test prompt'));

      // Select the prompt with Enter
      await tester.sendEnter();
      await tester.pump();
      await tester.pump();

      // Since it has arguments, it should show the PromptArgumentsOverlay
      expect(
        tester.terminalState,
        containsText('Prompt Arguments: test-prompt'),
      );
      expect(tester.terminalState, containsText('arg1'));
      await tester.enterText('arg1Value');
      await tester.pump();
      await tester.sendEnter();
      await tester.pump();
      await tester.pump();
      expect(tester.terminalState, containsText('Hello from prompt arg1Value'));
    });
  });

  test('Resource autocomplete shows up when typing @', () async {
    await testNocterm('Resource autocomplete', (tester) async {
      // Add a fake server with resources
      final manager = client.mcpServerManager as FakeMcpServerManager;
      manager.serverFactories.add((channel) async {
        final server = TestMcpServer(channel);
        server.addResource(
          Resource(
            uri: 'test://resource',
            name: 'test-resource',
            description: 'A test resource',
          ),
          (request) => ReadResourceResult(
            contents: [
              TextResourceContents(
                uri: 'test://resource',
                text: 'Resource content',
              ),
            ],
          ),
        );
        return server;
      });

      client.startChat();
      await tester.pumpComponent(ClientApp(client: client));

      // Complete introduction
      await fakeGemini.nextRequest;
      fakeGemini.sendTextResponse('I am your assistant.');
      fakeGemini.closeRequest();

      await client.ready;
      await tester.pump();

      // Type '@' to trigger resource autocomplete
      await tester.enterText('@');
      await tester.pump();

      // Verify autocomplete overlay is visible
      expect(tester.terminalState, containsText('test-resource'));

      // Select the resource with Enter
      await tester.sendEnter();
      await tester.pump();
      await tester.pump();

      // Selecting a resource should trigger read_resource and clear the input.
      expect(tester.terminalState, isNot(containsText('test-resource')));
      // Should see the resource item in the chat history.
      expect(tester.terminalState, containsText('Resource: test://resource'));
    });
  });
}
