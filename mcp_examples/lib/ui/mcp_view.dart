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
    final theme = TuiTheme.of(context);
    if (_isLoading) {
      return Center(
        child: Text(
          'Loading MCP server details...',
          style: TextStyle(color: theme.onSurface),
        ),
      );
    }

    if (component.client.serverConnections.isEmpty) {
      return Center(
        child: Text(
          'No active MCP server connections.',
          style: TextStyle(color: theme.onSurface),
        ),
      );
    }

    final children = <Component>[];
    for (var connection in component.client.serverConnections) {
      final serverName = connection.serverInfo?.name ?? 'Unknown Server';
      final version = connection.serverInfo?.version ?? '?.?.?';
      final isServerExpanded = _expandedServers.contains(connection);

      final supportsLogging = connection.serverCapabilities.logging != null;

      children.add(
        Row(
          children: [
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
              ),
            ),
            if (supportsLogging) ...[
              const Spacer(),
              const Text('Log Level: '),
              GestureDetector(
                onTap: () {
                  final levels = LoggingLevel.values;
                  final current =
                      component.client.serverLogLevels[connection]?.value ??
                      LoggingLevel.info;
                  final nextIndex = (current.index + 1) % levels.length;
                  final next = levels[nextIndex];
                  component.client.setServerLogLevel(connection, next);
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: theme.outline),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    component.client.serverLogLevels[connection]?.value.name ??
                        '?',
                    style: TextStyle(color: theme.warning),
                  ),
                ),
              ),
            ],
          ],
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
              style: TextStyle(color: theme.warning),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var tool in tools) {
            children.add(
              Text(
                '    - ${tool.name}: ${tool.description ?? "No description"}',
                style: TextStyle(color: theme.outline),
              ),
            );
          }
        }
      } else {
        children.add(
          Text('  ▶ Tools: 0', style: TextStyle(color: theme.outline)),
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
              style: TextStyle(color: theme.warning),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var resource in resources) {
            children.add(
              Text(
                '    - ${resource.name}: ${resource.description ?? "No description"}',
                style: TextStyle(color: theme.outline),
              ),
            );
          }
        }
      } else {
        children.add(
          Text('  ▶ Resources: 0', style: TextStyle(color: theme.outline)),
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
              style: TextStyle(color: theme.warning),
            ),
          ),
        );

        if (isSectionExpanded) {
          for (var prompt in prompts) {
            children.add(
              Text(
                '    - ${prompt.name}: ${prompt.description}',
                style: TextStyle(color: theme.outline),
              ),
            );
          }
        }
      } else {
        children.add(
          Text('  ▶ Prompts: 0', style: TextStyle(color: theme.outline)),
        );
      }

      children.add(const SizedBox(height: 1));
    }

    return ListView(children: children);
  }
}
