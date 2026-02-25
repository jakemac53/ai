import 'package:nocterm/nocterm.dart';
import 'package:dart_mcp/client.dart';

class FieldState {
  final String name;
  final String? description;
  final bool isRequired;
  final Schema? schema;
  final TextEditingController controller = TextEditingController();
  dynamic enumValue;
  String? error;

  FieldState({
    required this.name,
    this.description,
    this.isRequired = true,
    this.schema,
  }) {
    if (schema is StringSchema &&
        (schema as StringSchema).enumValues != null &&
        (schema as StringSchema).enumValues!.isNotEmpty) {
      enumValue = (schema as StringSchema).enumValues!.first;
      controller.text = enumValue.toString();
    }
  }
}

class EnumSelector extends StatefulComponent {
  const EnumSelector({
    super.key,
    required this.focused,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final bool focused;
  final List<dynamic> options;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final bool Function(KeyboardEvent event) onKeyEvent;

  @override
  State<EnumSelector> createState() => _EnumSelectorState();
}

class _EnumSelectorState extends State<EnumSelector> {
  @override
  Component build(BuildContext context) {
    List<Component> optionComponents = [];
    for (int i = 0; i < component.options.length; i++) {
      final option = component.options[i];
      final isSelected = option == component.value;

      optionComponents.add(
        Row(
          children: [
            Text(
              isSelected ? '(*) ' : '( ) ',
              style: TextStyle(
                color:
                    isSelected
                        ? const Color(0xFF00FF00)
                        : const Color(0xFF888888),
              ),
            ),
            Text(
              option.toString(),
              style: TextStyle(
                color:
                    component.focused
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      );
    }

    return Focusable(
      focused: component.focused,
      onKeyEvent: (event) {
        if (component.onKeyEvent(event)) return true;

        if (event.logicalKey == LogicalKey.arrowDown ||
            event.logicalKey == LogicalKey.arrowRight) {
          final index = component.options.indexOf(component.value);
          if (index < component.options.length - 1) {
            component.onChanged(component.options[index + 1]);
            return true;
          }
        } else if (event.logicalKey == LogicalKey.arrowUp ||
            event.logicalKey == LogicalKey.arrowLeft) {
          final index = component.options.indexOf(component.value);
          if (index > 0) {
            component.onChanged(component.options[index - 1]);
            return true;
          }
        }
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color:
                component.focused
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF555555),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: optionComponents,
        ),
      ),
    );
  }
}

Component buildFormField({
  required String name,
  required FieldState state,
  required bool focused,
  required VoidCallback onSubmit,
  required bool Function(KeyboardEvent) onKeyEvent,
  VoidCallback? onChanged,
}) {
  String typeHint = state.schema?.type?.name ?? '';
  if (state.description != null && state.description!.isNotEmpty) {
    typeHint = state.description!;
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 1),
    child: Row(
      children: [
        Text(
          name.padRight(15),
          style: const TextStyle(color: Color(0xFF00E5FF)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.schema is StringSchema &&
                  (state.schema as StringSchema).enumValues != null &&
                  (state.schema as StringSchema).enumValues!.isNotEmpty)
                EnumSelector(
                  focused: focused,
                  options: (state.schema as StringSchema).enumValues!.toList(),
                  value:
                      state.enumValue ??
                      (state.schema as StringSchema).enumValues!.first,
                  onChanged: (newValue) {
                    state.enumValue = newValue;
                    state.controller.text = newValue.toString();
                    onChanged?.call();
                  },
                  onKeyEvent: onKeyEvent,
                )
              else
                TextField(
                  controller: state.controller,
                  focused: focused,
                  placeholder: 'Enter $typeHint...',
                  onSubmitted: (_) => onSubmit(),
                  onKeyEvent: onKeyEvent,
                  decoration: InputDecoration(
                    border: BoxBorder.all(
                      color:
                          state.error != null
                              ? const Color(0xFFFF0000)
                              : const Color(0xFF555555),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 1),
                  ),
                ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    '  * ${state.error}',
                    style: const TextStyle(color: Color(0xFFFF0000)),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
