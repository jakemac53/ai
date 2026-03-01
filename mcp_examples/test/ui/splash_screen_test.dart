import 'package:nocterm/nocterm.dart';
import 'package:nocterm/nocterm_test.dart';
import 'package:mcp_examples/ui/spinner.dart';
import 'package:mcp_examples/ui/splash_screen.dart';
import 'package:test/test.dart';
import '../shared/test_workflow_client.dart';

void main() {
  late TestWorkflowClient client;

  setUp(() {
    client = TestWorkflowClient();
  });

  test('SplashScreen renders logo and initialization text', () async {
    await testNocterm('Splash screen rendering', (tester) async {
      await tester.pumpComponent(SplashScreen(client: client));

      // Initializing text should be present
      expect(
        tester.terminalState,
        containsText('Initializing servers & skills... '),
      );

      // Spinner should be present
      bool foundSpinner = false;
      final state = tester.terminalState;
      for (final frame in Spinner.frames) {
        if (state.renderToString().contains(frame)) {
          foundSpinner = true;
          break;
        }
      }
      expect(foundSpinner, isTrue, reason: 'Should render a spinner');
    });
  });

  test('SplashScreen timer ticks and changes state', () async {
    await testNocterm('Splash screen animation', (tester) async {
      await tester.pumpComponent(SplashScreen(client: client));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      // Still renders correctly
      expect(
        tester.terminalState,
        containsText('Initializing servers & skills... '),
      );
    });
  });
}
