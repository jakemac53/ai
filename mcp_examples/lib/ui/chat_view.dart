import 'package:google_generative_ai/google_generative_ai.dart' as gemini;
import 'package:nocterm/nocterm.dart';

import 'package:mcp_examples/workflow_client.dart';

class ChatView extends StatelessComponent {
  final WorkflowClient client;

  const ChatView({super.key, required this.client});

  @override
  Component build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: client.chatHistory.length,
            itemBuilder: (context, index) {
              final content = client.chatHistory[index];
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
      ],
    );
  }
}
