import 'package:nocterm/nocterm.dart';
import 'package:dart_mcp/client.dart';
import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/ui/chat_view.dart';
import 'package:mcp_examples/ui/log_view.dart';
import 'package:mcp_examples/ui/mcp_view.dart';
import 'package:mcp_examples/ui/elicitation_overlay.dart';
import 'package:mcp_examples/ui/prompt_autocomplete_overlay.dart';
import 'package:mcp_examples/ui/prompt_arguments_overlay.dart';
import 'package:mcp_examples/ui/resource_autocomplete_overlay.dart';
import 'package:mcp_examples/ui/settings_view.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;

import 'package:google_cloud_protobuf/protobuf.dart' as pb;

class ChatLayout extends StatefulComponent {
  final WorkflowClient client;
  final BufferedLogger logger;
  final bool isDark;
  final VoidCallback onThemeToggle;

  const ChatLayout({
    super.key,
    required this.client,
    required this.logger,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  int _activeTabIndex = 0;
  final ScrollController _chatScrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  // Prompt autocomplete state
  bool _isPromptMode = false;
  int _promptSelectedIndex = 0;
  String _promptQuery = '';

  // Resource autocomplete state
  List<Resource> _resourceSuggestions = [];
  int _resourceSelectedIndex = 0;
  bool _isResourceAutocompleteActive = false;
  String _resourceAutocompletePrefix = '';

  @override
  void initState() {
    super.initState();
    component.logger.onUpdate.listen((_) {
      if (mounted) setState(() {});
    });
    component.client.onChatUpdate.listen((_) {
      if (mounted) setState(() {});
    });
    component.client.isThinking.addListener(_onThinkingChanged);
    component.client.totalInputTokens.addListener(_onTokensChanged);
    component.client.totalCachedInputTokens.addListener(_onTokensChanged);
    component.client.totalOutputTokens.addListener(_onTokensChanged);
    component.client.latestTotalTokens.addListener(_onTokensChanged);
    component.client.activeElicitation.addListener(_onElicitationChanged);
    component.client.activePromptElicitation.addListener(_onElicitationChanged);
    component.client.showThoughts.addListener(_onSettingsChanged);
    component.client.modelName.addListener(_onSettingsChanged);

    _inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _chatScrollController.dispose();
    _inputController.dispose();
    component.client.isThinking.removeListener(_onThinkingChanged);
    component.client.totalInputTokens.removeListener(_onTokensChanged);
    component.client.totalCachedInputTokens.removeListener(_onTokensChanged);
    component.client.totalOutputTokens.removeListener(_onTokensChanged);
    component.client.latestTotalTokens.removeListener(_onTokensChanged);
    component.client.activeElicitation.removeListener(_onElicitationChanged);
    component.client.activePromptElicitation.removeListener(
      _onElicitationChanged,
    );
    component.client.showThoughts.removeListener(_onSettingsChanged);
    component.client.modelName.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onInputChanged() {
    final text = _inputController.text;
    final cursorPosition = _inputController.selection.baseOffset;

    // Prompt mode
    if (text.startsWith('/')) {
      if (!_isPromptMode) {
        setState(() {
          _isPromptMode = true;
          _isResourceAutocompleteActive = false;
          _promptSelectedIndex = 0;
        });
      }
      setState(() {
        _promptQuery = text.substring(1);
      });
    } else {
      if (_isPromptMode) {
        setState(() {
          _isPromptMode = false;
        });
      }
    }

    // Resource autocomplete mode
    final atIndex = text.substring(0, cursorPosition).lastIndexOf('@');
    if (atIndex != -1) {
      final prefix = text.substring(atIndex + 1, cursorPosition);
      if (!_isResourceAutocompleteActive ||
          prefix != _resourceAutocompletePrefix) {
        setState(() {
          _isResourceAutocompleteActive = true;
          _isPromptMode = false;
          _resourceAutocompletePrefix = prefix;
          _updateResourceSuggestions();
        });
      }
    } else {
      if (_isResourceAutocompleteActive) {
        setState(() {
          _isResourceAutocompleteActive = false;
        });
      }
    }
  }

  void _updateResourceSuggestions() {
    final allResources = component.client.availableResources.value;
    if (_resourceAutocompletePrefix.isEmpty) {
      _resourceSuggestions = allResources;
    } else {
      final query = _resourceAutocompletePrefix.toLowerCase();
      _resourceSuggestions =
          allResources
              .where((r) => r.name.toLowerCase().contains(query))
              .toList();
    }
    _resourceSelectedIndex = 0;
  }

  void _onElicitationChanged() {
    if (mounted) setState(() {});
  }

  void _onThinkingChanged() {
    if (mounted) setState(() {});
  }

  void _onTokensChanged() {
    if (mounted) setState(() {});
  }

  void _onSettingsChanged() {
    if (mounted) setState(() {});
  }

  List<Prompt> get _filteredPrompts {
    final allPrompts = component.client.availablePrompts.value;
    if (_promptQuery.isEmpty) return allPrompts;
    final query = _promptQuery.toLowerCase();
    return allPrompts
        .where((p) => p.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Component build(BuildContext context) {
    final unreadCount = component.logger.unreadCount.value;
    final logTabTitle = 'Logs${unreadCount > 0 ? ' ($unreadCount)' : ''}';
    final theme = TuiTheme.of(context);

    return SelectionArea(
      onSelectionCompleted: (text) {
        if (text.isNotEmpty) {
          ClipboardManager.copy(text);
          component.client.logger.stdout(
            'Copied to clipboard: ${text.length} chars',
          );
        }
      },
      child: Column(
        children: [
          // Tab Header
          Row(
            children: [
              _buildTab('Chat', 0),
              const SizedBox(width: 2),
              _buildTab(logTabTitle, 1),
              const SizedBox(width: 2),
              _buildTab('MCP Servers', 2),
              const SizedBox(width: 2),
              _buildTab('Settings', 3),
              const Spacer(),
              GestureDetector(
                onTap: component.onThemeToggle,
                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: theme.outline),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    component.isDark ? '☀️ Light' : '🌙 Dark',
                    style: TextStyle(color: theme.primary),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          // Main Content Area
          Expanded(
            child: Stack(
              children: [
                _buildMainContent(),
                if (component.client.activeElicitation.value != null)
                  Center(
                    child: Container(
                      width: 60,
                      height: 20,
                      child: ElicitationOverlay(
                        client: component.client,
                        request: component.client.activeElicitation.value!,
                      ),
                    ),
                  ),
                if (component.client.activePromptElicitation.value != null)
                  Center(
                    child: Container(
                      width: 60,
                      height: 20,
                      child: PromptArgumentsOverlay(
                        client: component.client,
                        prompt: component.client.activePromptElicitation.value!,
                      ),
                    ),
                  ),
                if (_isPromptMode)
                  Positioned(
                    bottom: 0,
                    left: 2,
                    right: 2,
                    child: PromptAutocompleteOverlay(
                      prompts: _filteredPrompts,
                      selectedIndex: _promptSelectedIndex,
                    ),
                  ),
                if (_isResourceAutocompleteActive)
                  Positioned(
                    bottom: 0,
                    left: 2,
                    right: 2,
                    child: ResourceAutocompleteOverlay(
                      resources: _resourceSuggestions,
                      selectedIndex: _resourceSelectedIndex,
                    ),
                  ),
              ],
            ),
          ),
          // Sticky Footer
          _buildFooter(),
        ],
      ),
    );
  }

  Component _buildMainContent() {
    switch (_activeTabIndex) {
      case 0:
        return ChatView(
          client: component.client,
          controller: _chatScrollController,
        );
      case 1:
        return LogView(
          logger: component.logger,
          onActivated: () {
            component.logger.markLogsRead();
          },
        );
      case 2:
        return McpView(client: component.client);
      case 3:
        return SettingsView(client: component.client);
      default:
        return const SizedBox();
    }
  }

  Component _buildTab(String title, int index) {
    final isActive = _activeTabIndex == index;
    final theme = TuiTheme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTabIndex = index;
          if (index == 1) {
            component.logger.markLogsRead();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? theme.outlineVariant : null,
          border: BoxBorder.all(
            color: isActive ? theme.primary : theme.outline,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? theme.primary : theme.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Component _buildFooter() {
    final inputTokens = component.client.totalInputTokens.value;
    final cachedTokens = component.client.totalCachedInputTokens.value;
    final outputTokens = component.client.totalOutputTokens.value;
    final latestTotal = component.client.latestTotalTokens.value;
    final theme = TuiTheme.of(context);

    const contextLimit = 1000000;
    final contextUsage = latestTotal / contextLimit;

    return Column(
      children: [
        if (_activeTabIndex == 0) _buildInputBox(),
        Container(
          decoration: BoxDecoration(color: theme.surface),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' Tokens: ↑ $inputTokens ($cachedTokens cached) | ↓ $outputTokens | Model: ${component.client.modelName.value.replaceFirst('models/', '')} ',
                style: TextStyle(color: theme.onSurface),
              ),
              Row(
                children: [
                  if (component.client.isThinking.value)
                    const Text(
                      '🤔 Thinking... ',
                      style: TextStyle(color: Color(0xFFFFD700)),
                    ),
                  Text(
                    ' Context: ${(contextUsage * 100).toStringAsFixed(1)}% ',
                    style: TextStyle(color: theme.onSurface),
                  ),
                  _buildProgressBar(contextUsage, 20),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Component _buildProgressBar(double fraction, int totalWidth) {
    final theme = TuiTheme.of(context);
    final filledWidth = (fraction * totalWidth).round().clamp(0, totalWidth);
    final emptyWidth = totalWidth - filledWidth;
    return Row(
      children: [
        Text('[', style: TextStyle(color: theme.outline)),
        Text('█' * filledWidth, style: TextStyle(color: theme.primary)),
        Text(' ' * emptyWidth, style: TextStyle(color: theme.outline)),
        Text(']', style: TextStyle(color: theme.outline)),
      ],
    );
  }

  Component _buildInputBox() {
    final theme = TuiTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        border: BoxBorder(
          top: BorderSide(color: theme.outline),
          bottom: BorderSide(color: theme.outline),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child:
          component.client.isThinking.value
              ? Center(
                child: Text(
                  'Please wait for the model to finish...',
                  style: TextStyle(color: theme.onSurface),
                ),
              )
              : TextField(
                controller: _inputController,
                focused: true,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(prefixText: '> '),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    if (_isPromptMode) {
                      _selectPrompt();
                    } else if (_isResourceAutocompleteActive) {
                      _selectResource();
                    } else {
                      component.client.submitInput(value);
                      _inputController.clear();
                    }
                  }
                },
                onKeyEvent: (event) {
                  if (_isPromptMode) {
                    final filtered = _filteredPrompts;
                    if (event.logicalKey == LogicalKey.arrowDown) {
                      setState(() {
                        _promptSelectedIndex =
                            (_promptSelectedIndex + 1) % filtered.length;
                      });
                      return true;
                    } else if (event.logicalKey == LogicalKey.arrowUp) {
                      setState(() {
                        _promptSelectedIndex =
                            (_promptSelectedIndex - 1 + filtered.length) %
                            filtered.length;
                      });
                      return true;
                    } else if (event.logicalKey == LogicalKey.escape) {
                      setState(() {
                        _isPromptMode = false;
                      });
                      return true;
                    }
                  } else if (_isResourceAutocompleteActive) {
                    if (event.logicalKey == LogicalKey.arrowDown) {
                      setState(() {
                        _resourceSelectedIndex =
                            (_resourceSelectedIndex + 1) %
                            _resourceSuggestions.length;
                      });
                      return true;
                    } else if (event.logicalKey == LogicalKey.arrowUp) {
                      setState(() {
                        _resourceSelectedIndex =
                            (_resourceSelectedIndex -
                                1 +
                                _resourceSuggestions.length) %
                            _resourceSuggestions.length;
                      });
                      return true;
                    } else if (event.logicalKey == LogicalKey.escape) {
                      setState(() {
                        _isResourceAutocompleteActive = false;
                      });
                      return true;
                    }
                  }
                  // If you hit ctrl+c in the chat box, just clear it and don't exit.
                  if (event.isControlPressed &&
                      event.logicalKey == LogicalKey.keyC &&
                      _inputController.text.isNotEmpty) {
                    _inputController.clear();
                    return true;
                  }
                  return false;
                },
              ),
    );
  }

  void _selectPrompt() async {
    final filtered = _filteredPrompts;
    if (filtered.isNotEmpty && _promptSelectedIndex < filtered.length) {
      final prompt = filtered[_promptSelectedIndex];
      setState(() {
        _isPromptMode = false;
        _inputController.clear();
      });

      Map<String, String>? arguments;
      if (prompt.arguments != null && prompt.arguments!.isNotEmpty) {
        arguments = await component.client.elicitPromptArguments(prompt);
        if (arguments == null) return; // Cancelled
      }

      component.client.usePrompt(prompt, arguments);
    }
  }

  void _selectResource() {
    if (_resourceSuggestions.isNotEmpty &&
        _resourceSelectedIndex < _resourceSuggestions.length) {
      final resource = _resourceSuggestions[_resourceSelectedIndex];
      final functionCall = gemini.FunctionCall(
        name: 'read_resource',
        args: pb.Struct.fromJson({'uri': resource.uri}),
      );
      component.client.handleFunctionCall(functionCall);
      _inputController.clear();

      setState(() {
        _isResourceAutocompleteActive = false;
      });
    }
  }
}
