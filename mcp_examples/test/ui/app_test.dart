import 'package:nocterm/nocterm.dart';
import 'package:nocterm/nocterm_test.dart';
import 'package:mcp_examples/ui/app.dart';
import 'package:test/test.dart';
import '../shared/test_workflow_client.dart';

void main() {
  late TestWorkflowClient client;

  setUp(() {
    client = TestWorkflowClient();
  });

  test('ClientApp transitions from Splash to Chat when ready', () async {
    await testNocterm('App transition', (tester) async {
      // Initially "isReady" is false
      await tester.pumpComponent(ClientApp(client: client));

      // Should show splash screen
      expect(
        tester.terminalState,
        containsText('Initializing servers & skills... '),
      );

      // Set ready to true
      client.isReady.value = true;

      // Need to pump to trigger the listener
      await tester.pump();

      // Verify it transitioned to ChatLayout
      expect(tester.terminalState, containsText('Chat'));
      expect(tester.terminalState, containsText('MCP Servers'));
      expect(tester.terminalState, containsText('Tokens:'));
    });
  });
}
