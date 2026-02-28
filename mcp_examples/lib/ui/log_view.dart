import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/ui/collapsible_view.dart';
import 'package:nocterm/nocterm.dart';

class LogView extends StatefulComponent {
  final BufferedLogger logger;
  final VoidCallback onActivated;
  final ScrollController controller = ScrollController();

  LogView({super.key, required this.logger, required this.onActivated});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  bool _shouldScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    component.logger.onUpdate.listen(_handleUpdate);
  }

  void _handleUpdate(_) {
    if (!mounted) return;
    final controller = component.controller;
    if (controller.offset >= controller.maxScrollExtent - 1) {
      _shouldScrollToBottom = true;
    }
    setState(() {});
  }

  @override
  Component build(BuildContext context) {
    component.onActivated(); // Mark as read when built

    if (_shouldScrollToBottom) {
      _shouldScrollToBottom = false;
      TerminalBinding.instance.addPostFrameCallback((_) {
        component.controller.scrollToEnd();
      });
    }

    final theme = TuiTheme.of(context);

    return ListView.builder(
      controller: component.controller,
      itemCount: component.logger.logEntries.length,
      itemBuilder: (context, index) {
        final entry = component.logger.logEntries[index];
        final label = _getLabel(entry.level);
        final color = _getColor(entry.level, theme);
        
        // Take first 60 chars for title
        String title = entry.message.trim();
        if (title.length > 60) {
          title = '${title.substring(0, 57)}...';
        }
        if (title.isEmpty) title = '(empty)';

        return CollapsibleView(
          label: label,
          title: title,
          titleColor: color,
          contents: entry.message,
        );
      },
    );
  }

  String _getLabel(LogLevel level) {
    switch (level) {
      case LogLevel.stdout:
        return 'STDOUT';
      case LogLevel.stderr:
        return 'STDERR';
      case LogLevel.progress:
        return 'PROGRESS';
      case LogLevel.trace:
        return 'TRACE';
    }
  }

  Color _getColor(LogLevel level, TuiThemeData theme) {
    switch (level) {
      case LogLevel.stdout:
        return theme.success;
      case LogLevel.stderr:
        return theme.error;
      case LogLevel.progress:
        return theme.warning;
      case LogLevel.trace:
        return theme.secondary;
    }
  }
}
