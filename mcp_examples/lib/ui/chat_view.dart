import 'dart:convert';

import 'package:nocterm/nocterm.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;
import 'package:collection/collection.dart';

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
  final int historyIndex;
  _ContentItem(this.content, this.historyIndex);
}

class _FunctionGroupItem extends _ChatDisplayItem {
  final gemini.FunctionCall call;
  final gemini.FunctionResponse? response;
  final int historyIndex;
  _FunctionGroupItem(this.call, this.response, this.historyIndex);
}

class _ResourceItem extends _ChatDisplayItem {
  final String uri;
  final String? name;
  final String contents;
  final int historyIndex;
  _ResourceItem({
    required this.uri,
    this.name,
    required this.contents,
    required this.historyIndex,
  });
}

class _SkillItem extends _ChatDisplayItem {
  final String name;
  final String path;
  final String contents;
  final int historyIndex;
  _SkillItem({
    required this.name,
    required this.path,
    required this.contents,
    required this.historyIndex,
  });
}

class _ChatViewState extends State<ChatView> {
  bool _shouldScrollToBottom = false;
  final Set<int> _expandedFunctionGroups = {};
  final Set<int> _expandedThoughts = {};

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
    setState(() {});
  }

  List<_ChatDisplayItem> _buildDisplayItems() {
    final items = <_ChatDisplayItem>[];
    final history = component.client.uiChatHistory;
    final consumedIndices = <int>{};

    for (var i = 0; i < history.length; i++) {
      if (consumedIndices.contains(i)) continue;

      final content = history[i];

      // If the content has thoughts or regular text parts, add a content item.
      if (content.parts.any((p) => p.thought || p.text != null)) {
        items.add(
          _ContentItem(
            gemini.Content(
              role: content.role,
              parts:
                  content.parts
                      .where((p) => p.thought || p.text != null)
                      .toList(),
            ),
            i,
          ),
        );
      }

      // Handle function calls within this content.
      for (final part in content.parts) {
        if (part.functionCall == null) continue;

        final call = part.functionCall!;
        gemini.FunctionResponse? response;
        int? responseIndex;

        // Look for the matching response.
        for (var j = i + 1; j < history.length; j++) {
          final nextContent = history[j];
          final resPart = nextContent.parts.firstWhereOrNull(
            (p) => p.functionResponse?.name == call.name,
          );
          if (resPart != null) {
            response = resPart.functionResponse;
            responseIndex = j;
            break;
          }
        }

        if (responseIndex != null) {
          // If the response message ONLY contains this function response,
          // mark the whole message as consumed so it's not shown as separate text.
          final resContent = history[responseIndex];
          if (resContent.parts.length == 1) {
            consumedIndices.add(responseIndex);
          }
        }

        // Add specialized widgets or the generic function group.
        if (call.name == 'read_resource' && response != null) {
          final output = response.response?.fields['output']?.stringValue ?? '';
          items.add(
            _ResourceItem(
              uri: call.args?.fields['uri']?.stringValue ?? '',
              name: call.args?.fields['name']?.stringValue,
              contents: output,
              historyIndex: i,
            ),
          );
        } else if (call.name == 'read_skill' && response != null) {
          final output = response.response?.fields['output']?.stringValue ?? '';
          items.add(
            _SkillItem(
              name: call.args?.fields['name']?.stringValue ?? '',
              path: '',
              contents: output,
              historyIndex: i,
            ),
          );
        } else {
          items.add(_FunctionGroupItem(call, response, i));
        }
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
                  return _buildContentWidget(
                    context,
                    item.content,
                    isLast: isLast,
                    id: item.historyIndex,
                  );
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
    required int id,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isModel) ...[
                  if (content.parts.any((p) => p.thought)) ...[
                    Builder(
                      builder: (context) {
                        final isActivelyThinking =
                            isStreaming &&
                            content.parts.any(
                              (p) => p.thought && p.text != null,
                            );
                        final isExpanded =
                            _expandedThoughts.contains(id) ||
                            isActivelyThinking;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isExpanded) {
                                    _expandedThoughts.remove(id);
                                  } else {
                                    _expandedThoughts.add(id);
                                  }
                                });
                              },
                              child: Text(
                                isExpanded ? ' [Thought ▽]' : ' [Thought ▷]',
                                style: TextStyle(
                                  color: theme.outline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isExpanded)
                              for (final thoughtPart in content.parts.where(
                                (p) => p.thought,
                              ))
                                Container(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    thoughtPart.text ?? '',
                                    softWrap: true,
                                    style: TextStyle(
                                      color: theme.outline,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ],
                ],
                Text(
                  content.parts
                      .where((p) => !p.thought)
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
              ],
            ),
          ),
          if (isStreaming) ...[const SizedBox(width: 1), Spinner(color: color)],
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
    return SkillView(name: item.name, path: item.path, contents: item.contents);
  }
}
