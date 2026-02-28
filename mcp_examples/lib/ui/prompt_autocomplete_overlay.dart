import 'package:nocterm/nocterm.dart';
import 'package:dart_mcp/client.dart';

class PromptAutocompleteOverlay extends StatelessComponent {
  final List<Prompt> prompts;
  final int selectedIndex;

  const PromptAutocompleteOverlay({
    super.key,
    required this.prompts,
    required this.selectedIndex,
  });

  @override
  Component build(BuildContext context) {
    if (prompts.isEmpty) return const SizedBox();
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
            ' Prompts ',
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.primary),
          ),
          const Divider(),
          ...List.generate(prompts.length, (index) {
            final prompt = prompts[index];
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
                    prompt.name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? theme.onSurface : theme.outline,
                    ),
                  ),
                  if (prompt.description != null)
                    Expanded(
                      child: Text(
                        ' - ${prompt.description}',
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
