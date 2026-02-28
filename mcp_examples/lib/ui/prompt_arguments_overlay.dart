import 'package:nocterm/nocterm.dart';
import 'package:dart_mcp/client.dart';
import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/ui/form_components.dart';

class PromptArgumentsOverlay extends StatefulComponent {
  final WorkflowClient client;
  final Prompt prompt;

  const PromptArgumentsOverlay({
    super.key,
    required this.client,
    required this.prompt,
  });

  @override
  State<PromptArgumentsOverlay> createState() => _PromptArgumentsOverlayState();
}

class _PromptArgumentsOverlayState extends State<PromptArgumentsOverlay> {
  final Map<String, FieldState> _fields = {};
  bool _submitted = false;
  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    final arguments = component.prompt.arguments;
    if (arguments != null) {
      for (final arg in arguments) {
        _fields[arg.name] = FieldState(
          name: arg.name,
          description: arg.description,
          isRequired: arg.required ?? false,
        );
      }
    }
  }

  void _submit() {
    if (_submitted) return;

    final arguments = <String, String>{};
    bool hasErrors = false;

    for (final entry in _fields.entries) {
      final name = entry.key;
      final state = entry.value;
      final value = state.controller.text;

      if (state.isRequired && value.isEmpty) {
        setState(() {
          state.error = 'This argument is required';
        });
        hasErrors = true;
      } else {
        setState(() {
          state.error = null;
        });
        if (value.isNotEmpty) {
          arguments[name] = value;
        }
      }
    }

    if (!hasErrors) {
      _submitted = true;
      component.client.submitPromptElicitation(arguments);
    }
  }

  void _cancel() {
    if (_submitted) return;
    _submitted = true;
    component.client.submitPromptElicitation(null);
  }

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        border: BoxBorder.all(color: theme.primary),
      ),
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prompt Arguments: ${component.prompt.name}',
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.primary),
          ),
          if (component.prompt.description != null) ...[
            const SizedBox(height: 1),
            Text(
              component.prompt.description!,
              style: TextStyle(color: theme.onSurface),
            ),
          ],
          const SizedBox(height: 1),
          const Divider(),
          const SizedBox(height: 1),
          if (_fields.isEmpty)
            Text(
              'This prompt has no arguments.',
              style: TextStyle(color: theme.onSurface),
            )
          else
            ..._buildFormFields(context),
          const Spacer(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' [Enter] Submit ',
                style: const TextStyle(color: Color(0xFF00FF00)),
              ),
              Text(' [Esc] Cancel ', style: TextStyle(color: theme.outline)),
            ],
          ),
        ],
      ),
    );
  }

  List<Component> _buildFormFields(BuildContext context) {
    final fieldsComponents = <Component>[];
    int i = 0;
    for (final entry in _fields.entries) {
      final name = entry.key;
      final state = entry.value;

      fieldsComponents.add(
        buildFormField(
          context: context,
          name: name,
          state: state,
          focused: _focusedIndex == i,
          onSubmit: _submit,
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
