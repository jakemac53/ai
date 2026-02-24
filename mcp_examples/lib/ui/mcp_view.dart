import 'package:nocterm/nocterm.dart';

import 'package:dart_mcp/client.dart';
import 'package:mcp_examples/workflow_client.dart';

class McpView extends StatefulComponent {
  final WorkflowClient client;

  const McpView({super.key, required this.client});

  @override
  State<McpView> createState() => _McpViewState();
}

class _McpViewState extends State<McpView> {
  // Store fetched tools and resources per connection to avoid refetching on every rebuild
  final Map<ServerConnection, List<Tool>> _tools = {};
  final Map<ServerConnection, List<Resource>> _resources = {};
  final Map<ServerConnection, List<Prompt>> _prompts = {};

  final Set<ServerConnection> _expandedServers = {};
  final Set<String> _expandedSections = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllServerData();
  }

  Future<void> _loadAllServerData() async {
    for (final connection in component.client.serverConnections) {
      if (connection.serverCapabilities.tools != null) {
        try {
          final result = await connection.listTools();
          _tools[connection] = result.tools;
        } catch (e) {
          // Ignore failures for now
        }
      }
      if (connection.serverCapabilities.resources != null) {
        try {
          final result = await connection.listResources();
          _resources[connection] = result.resources;
        } catch (e) {
          // Ignore failures for now
        }
      }
      if (connection.serverCapabilities.prompts != null) {
        try {
          final result = await connection.listPrompts();
          _prompts[connection] = result.prompts;
        } catch (e) {
          // Ignore failures for now
        }
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Component build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: Text('Loading MCP server details...'));
    }

    if (component.client.serverConnections.isEmpty) {
      return const Center(child: Text('No active MCP server connections.'));
    }

    final children = <Component>[];
    for (var connection in component.client.serverConnections) {
      final serverName = connection.serverInfo?.name ?? 'Unknown Server';
      final version = connection.serverInfo?.version ?? '?.?.?';
      final isServerExpanded = _expandedServers.contains(connection);

      children.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isServerExpanded) {
                _expandedServers.remove(connection);
              } else {
                _expandedServers.add(connection);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              '${isServerExpanded ? "▼" : "▶"} $serverName (v$version)',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00E5FF),
              ),
            ),
          ),
        ),
      );

      if (!isServerExpanded) continue;

      // Tools
      final tools = _tools[connection];
      if (tools != null && tools.isNotEmpty) {
        final sectionId = '${connection.hashCode}_tools';
        final isSectionExpanded = _expandedSections.contains(sectionId);

        children.add(
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSectionExpanded) {
                  _expandedSections.remove(sectionId);
                } else {
                  _expandedSections.add(sectionId);
                }
              });
            },
            child: Text(
              '  ${isSectionExpanded ? "▼" : "▶"} Tools (${tools.length})',
              style: const TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var tool in tools) {
            children.add(
              Text(
                '    - ${tool.name}: ${tool.description ?? "No description"}',
                style: const TextStyle(color: Color(0xFFAAAAAA)),
              ),
            );
          }
        }
      } else {
        children.add(
          const Text(
            '  ▶ Tools: 0',
            style: TextStyle(color: Color(0xFF888888)),
          ),
        );
      }

      // Resources
      final resources = _resources[connection];
      if (resources != null && resources.isNotEmpty) {
        final sectionId = '${connection.hashCode}_resources';
        final isSectionExpanded = _expandedSections.contains(sectionId);

        children.add(
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSectionExpanded) {
                  _expandedSections.remove(sectionId);
                } else {
                  _expandedSections.add(sectionId);
                }
              });
            },
            child: Text(
              '  ${isSectionExpanded ? "▼" : "▶"} Resources (${resources.length})',
              style: const TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var resource in resources) {
            children.add(
              Text(
                '    - ${resource.name}: ${resource.description ?? "No description"}',
                style: const TextStyle(color: Color(0xFFAAAAAA)),
              ),
            );
          }
        }
      } else {
        children.add(
          const Text(
            '  ▶ Resources: 0',
            style: TextStyle(color: Color(0xFF888888)),
          ),
        );
      }

      // Prompts
      final prompts = _prompts[connection];
      if (prompts != null && prompts.isNotEmpty) {
        final sectionId = '${connection.hashCode}_prompts';
        final isSectionExpanded = _expandedSections.contains(sectionId);

        children.add(
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSectionExpanded) {
                  _expandedSections.remove(sectionId);
                } else {
                  _expandedSections.add(sectionId);
                }
              });
            },
            child: Text(
              '  ${isSectionExpanded ? "▼" : "▶"} Prompts (${prompts.length})',
              style: const TextStyle(color: Color(0xFFFFD700)),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var prompt in prompts) {
            children.add(
              Text(
                '    - ${prompt.name}: ${prompt.description}',
                style: const TextStyle(color: Color(0xFFAAAAAA)),
              ),
            );
          }
        }
      } else {
        children.add(
          const Text(
            '  ▶ Prompts: 0',
            style: TextStyle(color: Color(0xFF888888)),
          ),
        );
      }

      children.add(const SizedBox(height: 1));
    }

    return ListView(children: children);
  }
}
