import 'package:nocterm/nocterm.dart';

class ResourceView extends StatefulComponent {
  final String uri;
  final String? name;
  final String contents;

  const ResourceView({
    super.key,
    required this.uri,
    this.name,
    required this.contents,
  });

  @override
  State<ResourceView> createState() => _ResourceViewState();
}

class _ResourceViewState extends State<ResourceView> {
  bool _isExpanded = false;

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    final displayName = component.name ?? component.uri;

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
                  'Resource: ',
                  style: TextStyle(
                    color: theme.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  displayName,
                  style: TextStyle(
                    color: theme.warning,
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
