import 'package:nocterm/nocterm.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/workflow_client.dart';

import 'package:mcp_examples/ui/chat_layout.dart';

class ClientApp extends StatefulComponent {
  final WorkflowClient client;
  final BufferedLogger logger;

  const ClientApp({super.key, required this.client, required this.logger});

  @override
  State<ClientApp> createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return NoctermApp(
      title: 'Dash Client',
      child: Focusable(
        focused: true,
        onKeyEvent: (event) {
          if (event.isControlPressed && event.character?.toLowerCase() == 'c') {
            shutdownApp();
            return true;
          }
          return false;
        },
        child:
            _showSplash
                ? Center(
                  child: AsciiText(
                    'Dash Client',
                    font: AsciiFont.standard,
                    style: const TextStyle(color: Color(0xFF00E5FF)),
                  ),
                )
                : ChatLayout(
                  client: component.client,
                  logger: component.logger,
                ),
      ),
    );
  }
}
