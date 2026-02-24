import 'package:google_generative_ai/google_generative_ai.dart' as gemini;
import 'package:nocterm/nocterm.dart';

import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/ui/draggable_scrollbar.dart';

class ChatView extends StatefulComponent {
  final WorkflowClient client;
  final ScrollController controller;

  const ChatView({super.key, required this.client, required this.controller});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _shouldScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    component.client.onChatUpdate.listen(_handleChatUpdate);
  }

  void _handleChatUpdate(_) {
    if (!mounted) return;

    // If we are already at the bottom, we should scroll to bottom after the
    // next build.
    final controller = component.controller;
    if (controller.offset >= controller.maxScrollExtent - 1) {
      _shouldScrollToBottom = true;
    }
  }

  @override
  Component build(BuildContext context) {
    if (_shouldScrollToBottom) {
      _shouldScrollToBottom = false;
      TerminalBinding.instance.addPostFrameCallback((_) {
        component.controller.scrollToEnd();
      });
    }

    final theme = TuiTheme.of(context);

    return Column(
      children: [
        Expanded(
          child: DraggableScrollbar(
            controller: component.controller,
            thumbVisibility: true,
            trackColor: theme.surface,
            thumbColor: const Color(0xFF666666),
            child: ListView.builder(
              controller: component.controller,
              itemCount: component.client.uiChatHistory.length,
              itemBuilder: (context, index) {
                final content = component.client.uiChatHistory[index];
                final role = content.role == 'user' ? 'You' : 'Model';
                final color =
                    content.role == 'user'
                        ? const Color(0xFF00E5FF)
                        : const Color(0xFFFF00FF);
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$role: ',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          content.parts
                              .map((p) {
                                if (p is gemini.TextPart) {
                                  return p.text;
                                } else if (p is gemini.FunctionCall) {
                                  return '[Function Call: ${p.name}(${p.args})]';
                                } else if (p is gemini.FunctionResponse) {
                                  return '[Function Response: ${p.name} -> ${p.response}]';
                                } else if (p is gemini.DataPart) {
                                  return '[Data: ${p.mimeType}]';
                                }
                                return p.toString();
                              })
                              .join(''),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
