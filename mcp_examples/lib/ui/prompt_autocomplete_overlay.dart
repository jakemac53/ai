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

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: BoxBorder.all(color: const Color(0xFF00E5FF)),
      ),
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            ' Prompts ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00E5FF),
            ),
          ),
          const Divider(),
          ...List.generate(prompts.length, (index) {
            final prompt = prompts[index];
            final isSelected = index == selectedIndex;
            return Container(
              color: isSelected ? const Color(0xFF333333) : null,
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                children: [
                  Text(
                    isSelected ? '> ' : '  ',
                    style: const TextStyle(color: Color(0xFF00E5FF)),
                  ),
                  Text(
                    prompt.name,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFAAAAAA),
                    ),
                  ),
                  if (prompt.description != null)
                    Expanded(
                      child: Text(
                        ' - ${prompt.description}',
                        style: const TextStyle(color: Color(0xFF666666)),
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
