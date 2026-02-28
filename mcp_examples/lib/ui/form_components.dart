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
    if (schema != null) {
      final enumSchema = schema as EnumSchema;
      if (enumSchema.isUntitledSingleSelect) {
        final untitled = schema as UntitledSingleSelectEnumSchema;
        enumValue = untitled.values.first;
      } else if (enumSchema.isTitledSingleSelect) {
        final titled = schema as TitledSingleSelectEnumSchema;
        enumValue = titled.values.first.constValue;
      } else if (enumSchema.isUntitledMultiSelect) {
        enumValue = <String>[];
      } else if (enumSchema.isTitledMultiSelect) {
        enumValue = <String>[];
      }
    }
  }
}

class EnumSelector extends StatefulComponent {
  const EnumSelector({
    super.key,
    required this.focused,
    required this.options,
    required this.value,
    required this.isMultiSelect,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final bool focused;
  final List<dynamic> options;
  final dynamic value;
  final bool isMultiSelect;
  final ValueChanged<dynamic> onChanged;
  final bool Function(KeyboardEvent event) onKeyEvent;

  @override
  State<EnumSelector> createState() => _EnumSelectorState();
}

class _EnumSelectorState extends State<EnumSelector> {
  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    List<Component> optionComponents = [];
    for (int i = 0; i < component.options.length; i++) {
      final option = component.options[i];
      final String label;
      final String constValue;
      if (option is Map<String, Object?> && option.containsKey('const')) {
        final titled = EnumValueWithTitle.fromMap(option);
        label = titled.title;
        constValue = titled.constValue;
      } else {
        label = option.toString();
        constValue = option.toString();
      }

      final bool isFocused = component.focused && i == _currentIndex;
      final bool isSelected;
      if (component.isMultiSelect) {
        isSelected = (component.value as List).contains(constValue);
      } else {
        isSelected = constValue == component.value;
      }

      optionComponents.add(
        Row(
          children: [
            Text(
              isSelected
                  ? (component.isMultiSelect ? '[x] ' : '(*) ')
                  : (component.isMultiSelect ? '[ ] ' : '( ) '),
              style: TextStyle(
                color:
                    isSelected
                        ? const Color(
                          0xFF00FF00,
                        ) // Keep standard green for selected
                        : theme.outline,
              ),
            ),
            Text(
              isFocused ? '> $label' : '  $label',
              style: TextStyle(
                color: isFocused ? theme.onSurface : theme.outline,
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
          final index = _getSelectedIndex();
          if (index < component.options.length - 1) {
            _selectIndex(index + 1);
            return true;
          }
        } else if (event.logicalKey == LogicalKey.arrowUp ||
            event.logicalKey == LogicalKey.arrowLeft) {
          final index = _getSelectedIndex();
          if (index > 0) {
            _selectIndex(index - 1);
            return true;
          }
        } else if (event.logicalKey == LogicalKey.space &&
            component.isMultiSelect) {
          _toggleIndex(_getSelectedIndex());
          return true;
        }
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: component.focused ? theme.primary : theme.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: optionComponents,
        ),
      ),
    );
  }

  int _currentIndex = 0;

  int _getSelectedIndex() {
    if (component.isMultiSelect) return _currentIndex;
    final value = component.value;
    for (int i = 0; i < component.options.length; i++) {
      final option = component.options[i];
      final constValue = _getConstValue(option);
      if (constValue == value) return i;
    }
    return 0;
  }

  void _selectIndex(int index) {
    if (component.isMultiSelect) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      component.onChanged(_getConstValue(component.options[index]));
    }
  }

  void _toggleIndex(int index) {
    if (!component.isMultiSelect) return;
    final constValue = _getConstValue(component.options[index]);
    final list = List<String>.from(component.value as List);
    if (list.contains(constValue)) {
      list.remove(constValue);
    } else {
      list.add(constValue);
    }
    component.onChanged(list);
  }

  String _getConstValue(dynamic option) {
    if (option is Map<String, Object?> && option.containsKey('const')) {
      return EnumValueWithTitle.fromMap(option).constValue;
    }
    return option.toString();
  }
}

Component buildFormField({
  required BuildContext context,
  required String name,
  required FieldState state,
  required bool focused,
  required VoidCallback onSubmit,
  required bool Function(KeyboardEvent) onKeyEvent,
  VoidCallback? onChanged,
}) {
  final theme = TuiTheme.of(context);
  String typeHint = state.schema?.type?.name ?? '';
  if (state.description != null && state.description!.isNotEmpty) {
    typeHint = state.description!;
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (state.schema?.title ?? name).padRight(15),
          style: TextStyle(color: theme.primary),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              () {
                    if (state.schema == null) return null;
                    final enumSchema = state.schema as EnumSchema;
                    final isEnum =
                        enumSchema.isUntitledSingleSelect ||
                        enumSchema.isTitledSingleSelect ||
                        enumSchema.isUntitledMultiSelect ||
                        enumSchema.isTitledMultiSelect;
                    if (!isEnum) return null;

                    return EnumSelector(
                      focused: focused,
                      isMultiSelect:
                          enumSchema.isUntitledMultiSelect ||
                          enumSchema.isTitledMultiSelect,
                      options: _getEnumOptions(enumSchema),
                      value: state.enumValue,
                      onChanged: (newValue) {
                        state.enumValue = newValue;
                        onChanged?.call();
                      },
                      onKeyEvent: onKeyEvent,
                    );
                  }() ??
                  TextField(
                    controller: state.controller,
                    focused: focused,
                    placeholder: 'Enter $typeHint...',
                    onSubmitted: (_) => onSubmit(),
                    onKeyEvent: onKeyEvent,
                    decoration: InputDecoration(
                      border: BoxBorder.all(
                        color:
                            state.error != null ? theme.error : theme.outline,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 1),
                    ),
                  ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    '  * ${state.error}',
                    style: TextStyle(color: theme.error),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<dynamic> _getEnumOptions(EnumSchema schema) {
  if (schema.isUntitledSingleSelect) {
    return (schema as UntitledSingleSelectEnumSchema).values.toList();
  } else if (schema.isTitledSingleSelect) {
    return (schema as TitledSingleSelectEnumSchema).values.toList();
  } else if (schema.isUntitledMultiSelect) {
    return (schema as UntitledMultiSelectEnumSchema).values.toList();
  } else if (schema.isTitledMultiSelect) {
    return (schema as TitledMultiSelectEnumSchema).values.toList();
  }
  return [];
}
