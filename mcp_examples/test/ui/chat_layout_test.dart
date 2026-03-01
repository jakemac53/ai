import 'package:nocterm/nocterm.dart';
import 'package:nocterm/nocterm_test.dart';
import 'package:mcp_examples/ui/chat_layout.dart';
import 'package:test/test.dart';
import '../shared/test_workflow_client.dart';

void main() {
  late TestWorkflowClient client;

  setUp(() {
    client = TestWorkflowClient();
  });

  test('ChatLayout submits input when enter is pressed', () async {
    await testNocterm('Chat input', (tester) async {
      await tester.pumpComponent(
        ChatLayout(client: client, isDark: true, onThemeToggle: () {}),
      );

      // Enter text into the TextField.
      await tester.enterText('Hello world');

      // Press enter.
      await tester.sendEnter();

      // Verify client recorded the input call.
      expect(client.submittedInputs, contains('Hello world'));
    });
  });
}
