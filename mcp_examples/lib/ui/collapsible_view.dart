import 'package:nocterm/nocterm.dart';

class CollapsibleView extends StatefulComponent {
  final String label;
  final String title;
  final Color titleColor;
  final String contents;
  final bool initiallyExpanded;

  const CollapsibleView({
    super.key,
    required this.label,
    required this.title,
    required this.titleColor,
    required this.contents,
    this.initiallyExpanded = false,
  });

  @override
  State<CollapsibleView> createState() => _CollapsibleViewState();
}

class _CollapsibleViewState extends State<CollapsibleView> {
  late bool _isExpanded = component.initiallyExpanded;

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);

    return Container(
      decoration: BoxDecoration(border: BoxBorder.all(color: theme.outline)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Text(
                  _isExpanded ? '▼ ' : '▶ ',
                  style: TextStyle(color: theme.outline),
                ),
                Text(
                  '${component.label}: ',
                  style: TextStyle(
                    color: component.titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  component.title,
                  style: TextStyle(
                    color: component.titleColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Container(
              decoration: BoxDecoration(
                border: BoxBorder(top: BorderSide(color: theme.outline)),
              ),
              child: Text(
                component.contents,
                softWrap: true,
                style: TextStyle(color: theme.onSurface),
              ),
            ),
        ],
      ),
    );
  }
}
