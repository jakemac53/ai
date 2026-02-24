import 'package:nocterm/nocterm.dart';

import 'package:dart_mcp/client.dart';
import 'package:mcp_examples/workflow_client.dart';

class ElicitationOverlay extends StatefulComponent {
  final WorkflowClient client;
  final ElicitRequest request;

  const ElicitationOverlay({
    super.key,
    required this.client,
    required this.request,
  });

  @override
  State<ElicitationOverlay> createState() => _ElicitationOverlayState();
}

class _ElicitationOverlayState extends State<ElicitationOverlay> {
  final Map<String, _FieldState> _fields = {};
  bool _submitted = false;
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize state for each property requested by the schema
    final properties = component.request.requestedSchema.properties;
    if (properties != null) {
      for (final entry in properties.entries) {
        _fields[entry.key] = _FieldState(schema: entry.value);
      }
    }
  }

  void _submit() {
    if (_submitted) return;

    final arguments = <String, Object?>{};
    bool hasErrors = false;

    // Validate map
    for (final entry in _fields.entries) {
      final name = entry.key;
      final state = entry.value;

      try {
        final parsedValue = _parseStringValue(
          state.controller.text,
          state.schema.type,
        );
        final errors = state.schema.validate(parsedValue);

        if (errors.isNotEmpty) {
          setState(() {
            state.error = errors.first.toString();
          });
          hasErrors = true;
        } else {
          setState(() {
            state.error = null;
          });
          arguments[name] = parsedValue;
        }
      } catch (e) {
        setState(() {
          state.error = e.toString();
        });
        hasErrors = true;
      }
    }

    if (!hasErrors) {
      _submitted = true;
      component.client.submitElicitation(
        ElicitResult(action: ElicitationAction.accept, content: arguments),
      );
    }
  }

  Object? _parseStringValue(String value, JsonType? type) {
    if (value.isEmpty && type != JsonType.string) {
      // It might be an unset optional field. If we return null, schema validation checks it.
      return null;
    }
    switch (type) {
      case JsonType.string:
        return value;
      case JsonType.num:
        return num.parse(value);
      case JsonType.int:
        return int.parse(value);
      case JsonType.bool:
        return bool.parse(value);
      default:
        return value;
    }
  }

  void _decline() {
    if (_submitted) return;
    _submitted = true;
    component.client.submitElicitation(
      ElicitResult(action: ElicitationAction.decline),
    );
  }

  void _cancel() {
    if (_submitted) return;
    _submitted = true;
    component.client.submitElicitation(
      ElicitResult(action: ElicitationAction.cancel),
    );
  }

  @override
  Component build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: BoxBorder.all(color: const Color(0xFFFFD700)),
      ),
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚠️ Server Needs Information',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD700),
            ),
          ),
          const SizedBox(height: 1),
          Text(component.request.message),
          const SizedBox(height: 1),
          const Divider(),
          const SizedBox(height: 1),
          ..._buildFormFields(),
          const Spacer(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' [Enter] Submit ',
                style: const TextStyle(color: Color(0xFF00FF00)),
              ),
              Row(
                children: [
                  Text(
                    ' [Esc] Cancel ',
                    style: const TextStyle(color: Color(0xFF888888)),
                  ),
                  Text(
                    ' [Tab] Decline ',
                    style: const TextStyle(color: Color(0xFFFF0000)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Component> _buildFormFields() {
    final fieldsComponents = <Component>[];
    int i = 0;
    for (final entry in _fields.entries) {
      final name = entry.key;
      final state = entry.value;

      String typeHint = state.schema.type?.name ?? '';

      fieldsComponents.add(
        Padding(
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
                      _EnumSelector(
                        focused: _focusedIndex == i,
                        options:
                            (state.schema as StringSchema).enumValues!.toList(),
                        value:
                            state.enumValue ??
                            (state.schema as StringSchema).enumValues!.first,
                        onChanged: (newValue) {
                          setState(() {
                            state.enumValue = newValue;
                            state.controller.text = newValue.toString();
                          });
                        },
                        onKeyEvent: (event) {
                          if (event.logicalKey == LogicalKey.escape) {
                            _cancel();
                            return true;
                          } else if (event.logicalKey == LogicalKey.tab) {
                            if (event.isShiftPressed) {
                              if (_focusedIndex > 0) {
                                setState(() {
                                  _focusedIndex--;
                                });
                                return true;
                              }
                            } else {
                              if (_focusedIndex < _fields.length - 1) {
                                setState(() {
                                  _focusedIndex++;
                                });
                                return true;
                              } else {
                                _decline();
                                return true;
                              }
                            }
                          } else if (event.logicalKey == LogicalKey.enter) {
                            _submit();
                            return true;
                          }
                          return false;
                        },
                      )
                    else
                      TextField(
                        controller: state.controller,
                        focused: _focusedIndex == i,
                        placeholder: 'Enter $typeHint...',
                        onSubmitted: (_) => _submit(),
                        onKeyEvent: (event) {
                          if (event.logicalKey == LogicalKey.escape) {
                            _cancel();
                            return true;
                          } else if (event.logicalKey == LogicalKey.tab) {
                            if (event.isShiftPressed) {
                              if (_focusedIndex > 0) {
                                setState(() {
                                  _focusedIndex--;
                                });
                                return true;
                              }
                            } else {
                              if (_focusedIndex < _fields.length - 1) {
                                setState(() {
                                  _focusedIndex++;
                                });
                                return true;
                              } else {
                                _decline();
                                return true;
                              }
                            }
                          }
                          return false;
                        },
                        decoration: InputDecoration(
                          border: BoxBorder.all(
                            color:
                                state.error != null
                                    ? const Color(0xFFFF0000)
                                    : const Color(0xFF555555),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 1,
                          ),
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
        ),
      );
      i++;
    }

    return [Column(children: fieldsComponents)];
  }
}

class _FieldState {
  final Schema schema;
  final TextEditingController controller = TextEditingController();
  dynamic enumValue;
  String? error;

  _FieldState({required this.schema}) {
    if (schema is StringSchema &&
        (schema as StringSchema).enumValues != null &&
        (schema as StringSchema).enumValues!.isNotEmpty) {
      enumValue = (schema as StringSchema).enumValues!.first;
      controller.text = enumValue.toString();
    }
  }
}

class _EnumSelector extends StatefulComponent {
  const _EnumSelector({
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
  State<_EnumSelector> createState() => _EnumSelectorState();
}

class _EnumSelectorState extends State<_EnumSelector> {
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
