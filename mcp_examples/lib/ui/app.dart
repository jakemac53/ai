import 'package:nocterm/nocterm.dart';
import 'package:mcp_examples/workflow_client.dart';

import 'package:mcp_examples/ui/chat_layout.dart';
import 'package:mcp_examples/ui/splash_screen.dart';

class ClientApp extends StatefulComponent {
  final WorkflowClient client;

  const ClientApp({super.key, required this.client});

  @override
  State<ClientApp> createState() => _ClientAppState();
}

class _ClientAppState extends State<ClientApp> {
  bool _showSplash = true;
  bool _isDark = true;

  @override
  void initState() {
    super.initState();
    component.client.isReady.addListener(_onReadyChanged);
    _onReadyChanged(); // Check initial state
  }

  @override
  void dispose() {
    component.client.isReady.removeListener(_onReadyChanged);
    super.dispose();
  }

  void _onReadyChanged() {
    if (component.client.isReady.value) {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Component build(BuildContext context) {
    final theme = _isDark ? TuiThemeData.dark : TuiThemeData.light;
    return NoctermApp(
      title: 'Dash Client',
      theme: theme,
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
                ? SplashScreen(client: component.client)
                : ChatLayout(
                  client: component.client,
                  isDark: _isDark,
                  onThemeToggle: _toggleTheme,
                ),
      ),
    );
  }
}
