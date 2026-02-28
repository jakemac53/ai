import 'package:mcp_examples/ui/collapsible_view.dart';
import 'package:nocterm/nocterm.dart';

class SkillView extends StatelessComponent {
  final String name;
  final String path;
  final String contents;

  const SkillView({
    super.key,
    required this.name,
    required this.path,
    required this.contents,
  });

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);

    return CollapsibleView(
      label: 'Skill',
      title: name,
      titleColor: theme.success,
      contents: contents,
    );
  }
}
