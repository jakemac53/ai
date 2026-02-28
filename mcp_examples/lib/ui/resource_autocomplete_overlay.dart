import 'package:nocterm/nocterm.dart';
import 'package:dart_mcp/client.dart';

class ResourceAutocompleteOverlay extends StatelessComponent {
  final List<Resource> resources;
  final int selectedIndex;

  const ResourceAutocompleteOverlay({
    super.key,
    required this.resources,
    required this.selectedIndex,
  });

  @override
  Component build(BuildContext context) {
    if (resources.isEmpty) return const SizedBox();
    final theme = TuiTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        border: BoxBorder.all(color: theme.primary),
      ),
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ' Resources ',
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.primary),
          ),
          const Divider(),
          ...List.generate(resources.length, (index) {
            final resource = resources[index];
            final isSelected = index == selectedIndex;
            return Container(
              color: isSelected ? theme.outlineVariant : null,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                children: [
                  Text(
                    isSelected ? '> ' : '  ',
                    style: TextStyle(color: theme.primary),
                  ),
                  Text(
                    resource.name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? theme.onSurface : theme.outline,
                    ),
                  ),
                  if (resource.description != null)
                    Expanded(
                      child: Text(
                        ' - ${resource.description}',
                        style: TextStyle(color: theme.outline),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
