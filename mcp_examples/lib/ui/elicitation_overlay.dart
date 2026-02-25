import 'package:nocterm/nocterm.dart';

import 'package:dart_mcp/client.dart';
import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/ui/form_components.dart';

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
  final Map<String, FieldState> _fields = {};
  bool _submitted = false;
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize state for each property requested by the schema
    final properties = component.request.requestedSchema?.properties;
    if (properties != null) {
      for (final entry in properties.entries) {
        _fields[entry.key] = FieldState(
          name: entry.key,
          schema: entry.value,
          isRequired:
              component.request.requestedSchema?.required?.contains(
                entry.key,
              ) ??
              true,
        );
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
        final enumSchema = state.schema as EnumSchema?;
        final isEnum =
            enumSchema != null &&
            (enumSchema.isUntitledSingleSelect ||
                enumSchema.isTitledSingleSelect ||
                enumSchema.isUntitledMultiSelect ||
                enumSchema.isTitledMultiSelect);

        final parsedValue =
            isEnum
                ? state.enumValue
                : _parseStringValue(state.controller.text, state.schema?.type);
        final errors = state.schema?.validate(parsedValue) ?? [];

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

      fieldsComponents.add(
        buildFormField(
          name: name,
          state: state,
          focused: _focusedIndex == i,
          onSubmit: _submit,
          onChanged: () => setState(() {}),
          onKeyEvent: (event) {
            if (event.logicalKey == LogicalKey.escape) {
              _cancel();
              return true;
            } else if (event.logicalKey == LogicalKey.enter) {
              _submit();
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
        ),
      );
      i++;
    }

    return [Column(children: fieldsComponents)];
  }
}
