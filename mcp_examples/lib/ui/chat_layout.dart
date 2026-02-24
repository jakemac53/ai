import 'package:nocterm/nocterm.dart';

import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/ui/chat_view.dart';
import 'package:mcp_examples/ui/log_view.dart';
import 'package:mcp_examples/ui/mcp_view.dart';
import 'package:mcp_examples/ui/elicitation_overlay.dart';

class ChatLayout extends StatefulComponent {
  final WorkflowClient client;
  final BufferedLogger logger;

  const ChatLayout({super.key, required this.client, required this.logger});

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  int _activeTabIndex = 0;
  final ScrollController _chatScrollController = ScrollController();

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
  }

  @override
  void dispose() {
    _chatScrollController.dispose();
    component.client.isThinking.removeListener(_onThinkingChanged);
    component.client.totalInputTokens.removeListener(_onTokensChanged);
    component.client.totalCachedInputTokens.removeListener(_onTokensChanged);
    component.client.totalOutputTokens.removeListener(_onTokensChanged);
    component.client.latestTotalTokens.removeListener(_onTokensChanged);
    component.client.activeElicitation.removeListener(_onElicitationChanged);
    super.dispose();
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

  @override
  Component build(BuildContext context) {
    final unreadCount = component.logger.unreadCount.value;
    final logTabTitle = 'Logs${unreadCount > 0 ? ' ($unreadCount)' : ''}';

    return Column(
      children: [
        // Tab Header
        Row(
          children: [
            _buildTab('Chat', 0),
            const SizedBox(width: 2),
            _buildTab(logTabTitle, 1),
            const SizedBox(width: 2),
            _buildTab('MCP Servers', 2),
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
            ],
          ),
        ),
        // Sticky Footer
        _buildFooter(),
      ],
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
      default:
        return const SizedBox();
    }
  }

  Component _buildTab(String title, int index) {
    final isActive = _activeTabIndex == index;
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
          color: isActive ? const Color(0xFF333333) : null,
          border: BoxBorder.all(
            color: isActive ? const Color(0xFF00E5FF) : const Color(0xFF555555),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF00E5FF) : const Color(0xFFAAAAAA),
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

    const contextLimit = 1000000;
    final contextUsage = latestTotal / contextLimit;

    return Column(
      children: [
        if (_activeTabIndex == 0) _buildInputBox(),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            border: BoxBorder(top: BorderSide(color: const Color(0xFF555555))),
          ),
          padding: const EdgeInsets.all(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' Tokens: ↑ $inputTokens ($cachedTokens cached) | ↓ $outputTokens ',
                style: const TextStyle(color: Color(0xFF888888)),
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
                    style: const TextStyle(color: Color(0xFF888888)),
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
    final filledWidth = (fraction * totalWidth).round().clamp(0, totalWidth);
    final emptyWidth = totalWidth - filledWidth;
    return Row(
      children: [
        const Text('[', style: TextStyle(color: Color(0xFF555555))),
        Text(
          '█' * filledWidth,
          style: const TextStyle(color: Color(0xFF00E5FF)),
        ),
        Text(
          ' ' * emptyWidth,
          style: const TextStyle(color: Color(0xFF555555)),
        ),
        const Text(']', style: TextStyle(color: Color(0xFF555555))),
      ],
    );
  }

  Component _buildInputBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        border: BoxBorder(top: BorderSide(color: const Color(0xFF555555))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child:
          component.client.isThinking.value
              ? const Center(
                child: Text(
                  'Please wait for the model to finish...',
                  style: TextStyle(color: Color(0xFFAAAAAA)),
                ),
              )
              : TextField(
                focused: true,
                decoration: const InputDecoration(prefixText: '> '),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    component.client.submitInput(value);
                  }
                },
              ),
    );
  }
}
