import 'dart:convert';

import 'package:nocterm/nocterm.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;

import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/ui/draggable_scrollbar.dart';
import 'package:mcp_examples/ui/resource_view.dart';
import 'package:mcp_examples/ui/skill_view.dart';
import 'package:mcp_examples/ui/spinner.dart';

class ChatView extends StatefulComponent {
  final WorkflowClient client;
  final ScrollController controller;

  const ChatView({super.key, required this.client, required this.controller});

  @override
  State<ChatView> createState() => _ChatViewState();
}

sealed class _ChatDisplayItem {}

class _ContentItem extends _ChatDisplayItem {
  final gemini.Content content;
  _ContentItem(this.content);
}

class _FunctionGroupItem extends _ChatDisplayItem {
  final gemini.FunctionCall call;
  final gemini.FunctionResponse? response;
  _FunctionGroupItem(this.call, this.response);
}

class _ResourceItem extends _ChatDisplayItem {
  final String uri;
  final String? name;
  final String contents;
  _ResourceItem({required this.uri, this.name, required this.contents});
}
class _SkillItem extends _ChatDisplayItem {
  final String name;
  final String path;
  final String contents;
  _SkillItem({required this.name, required this.path, required this.contents});
}

class _ChatViewState extends State<ChatView> {
  bool _shouldScrollToBottom = false;
  final Set<int> _expandedFunctionGroups = {};

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

  List<_ChatDisplayItem> _buildDisplayItems() {
    final items = <_ChatDisplayItem>[];
    final history = component.client.uiChatHistory;

    for (var i = 0; i < history.length; i++) {
      final content = history[i];
      if (content.parts.length == 1 &&
          content.parts.first.functionCall != null) {
        final call = content.parts.first.functionCall!;
        gemini.FunctionResponse? response;

        // Look ahead for a matching response.
        if (i + 1 < history.length) {
          final nextContent = history[i + 1];
          if (nextContent.parts.length == 1 &&
              nextContent.parts.first.functionResponse != null &&
              nextContent.parts.first.functionResponse!.name == call.name) {
            response = nextContent.parts.first.functionResponse;
            i++; // Skip the response item in the next iteration.
          }
        }

        // Check if this is a read_resource call and handle it specially.
        if (call.name == 'read_resource' && response != null) {
          try {
            final output =
                response.response?.fields['output']?.stringValue ?? '';
            items.add(
              _ResourceItem(
                uri: call.args?.fields['uri']?.stringValue ?? '',
                name: call.args?.fields['name']?.stringValue,
                contents: output,
              ),
            );
            continue; // Skip adding the default function group item.
          } catch (e) {
            // Not a valid read_resource call, fall through to default handling.
          }
        }

        // Check if this is a read_skill call and handle it specially.
        if (call.name == 'read_skill' && response != null) {
          try {
            final output =
                response.response?.fields['output']?.stringValue ?? '';
            items.add(
              _SkillItem(
                name: call.args?.fields['name']?.stringValue ?? '',
                path: '', // Path isn't strictly needed for display but could be added if we return it in output
                contents: output,
              ),
            );
            continue; // Skip adding the default function group item.
          } catch (e) {
            // Not a valid read_skill call, fall through to default handling.
          }
        }

        items.add(_FunctionGroupItem(call, response));
      } else {
        items.add(_ContentItem(content));
      }
    }
    return items;
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
    final displayItems = _buildDisplayItems();

    return Column(
      children: [
        Expanded(
          child: DraggableScrollbar(
            controller: component.controller,
            thumbVisibility: true,
            trackColor: theme.surface,
            thumbColor: theme.outline,
            child: ListView.builder(
              controller: component.controller,
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                final item = displayItems[index];
                if (item is _ContentItem) {
                  final isLast = index == displayItems.length - 1;
                  return _buildContentWidget(context, item.content, isLast: isLast);
                } else if (item is _FunctionGroupItem) {
                  return _buildFunctionGroupWidget(context, index, item);
                } else if (item is _ResourceItem) {
                  return _buildResourceWidget(context, item);
                } else if (item is _SkillItem) {
                  return _buildSkillWidget(context, item);
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }

  Component _buildContentWidget(
    BuildContext context,
    gemini.Content content, {
    bool isLast = false,
  }) {
    final theme = TuiTheme.of(context);
    final isModel = content.role != 'user';
    final role = isModel ? 'Model' : 'You';
    final color = isModel ? theme.secondary : theme.primary;
    final isStreaming = isLast && isModel && component.client.isStreaming.value;
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$role: ',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              content.parts
                  .map((p) {
                    if (p.text != null) {
                      return p.text;
                    } else if (p.functionCall != null) {
                      return '[Function Call: ${p.functionCall!.name}'
                          '(${jsonEncode(p.functionCall!.args?.toJson())})]';
                    } else if (p.functionResponse != null) {
                      return '[Function Response: ${p.functionResponse!.name} -> '
                          '${jsonEncode(p.functionResponse!.response?.toJson())}]';
                    } else if (p.inlineData != null) {
                      return '[Data: ${p.inlineData!.mimeType}]';
                    }
                    return p.toString();
                  })
                  .join(''),
              softWrap: true,
              style: TextStyle(color: theme.onSurface),
            ),
          ),
          if (isStreaming) ...[
            const SizedBox(width: 1),
            Spinner(color: color),
          ],
        ],
      ),
    );
  }

  Component _buildFunctionGroupWidget(
    BuildContext context,
    int index,
    _FunctionGroupItem item,
  ) {
    final theme = TuiTheme.of(context);
    final isExpanded = _expandedFunctionGroups.contains(index);
    final call = item.call;
    final response = item.response;

    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedFunctionGroups.remove(index);
                } else {
                  _expandedFunctionGroups.add(index);
                }
              });
            },
            child: Row(
              children: [
                Text(
                  isExpanded ? '▼ ' : '▶ ',
                  style: TextStyle(color: theme.outline),
                ),
                Text(
                  'Tool Call: ${call.name}',
                  style: TextStyle(
                    color: theme.warning,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arguments: ${jsonEncode(call.args?.toJson())}',
                    style: TextStyle(color: theme.outline),
                  ),
                  if (response != null)
                    Text(
                      'Response: ${jsonEncode(response.response?.toJson())}',
                      style: TextStyle(color: theme.outline),
                    )
                  else
                    Text(
                      'Response: (pending...)',
                      style: TextStyle(
                        color: theme.outline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Component _buildResourceWidget(BuildContext context, _ResourceItem item) {
    return ResourceView(
      uri: item.uri,
      name: item.name,
      contents: item.contents,
    );
  }

  Component _buildSkillWidget(BuildContext context, _SkillItem item) {
    return SkillView(
      name: item.name,
      path: item.path,
      contents: item.contents,
    );
  }
}
