import 'package:nocterm/nocterm.dart';
import 'package:mcp_examples/buffered_logger.dart';

class LogView extends StatelessComponent {
  final BufferedLogger logger;
  final VoidCallback onActivated;

  const LogView({super.key, required this.logger, required this.onActivated});

  @override
  Component build(BuildContext context) {
    onActivated(); // Mark as read when built
    return ListView.builder(
      itemCount: logger.logs.length,
      itemBuilder: (context, index) {
        return Text(logger.logs[index]);
      },
    );
  }
}
