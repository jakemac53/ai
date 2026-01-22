import 'dart:async';
import 'dart:io';
import 'package:dart_mcp/server.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:yaml/yaml.dart';

void main() {
  SkillServer.fromStreamChannel(stdioChannel(input: stdin, output: stdout));
}

typedef Logger =
    void Function(
      LoggingLevel level,
      Object data, {
      String? logger,
      Meta? meta,
    });

final class SkillServer extends MCPServer
    with ResourcesSupport, ToolsSupport, LoggingSupport {
  SkillServer.fromStreamChannel(super.channel)
    : super.fromStreamChannel(
        implementation: Implementation(name: 'skills-server', version: '0.1.0'),
      );

  @override
  FutureOr<InitializeResult> initialize(InitializeRequest request) async {
    // AGY requires MCP servers to expose at least one tool
    registerTool(Tool(name: 'fake', inputSchema: Schema.object()), (
      request,
    ) async {
      return CallToolResult(
        isError: true,
        content: [TextContent(text: 'Do not call this tool it does nothing')],
      );
    });

    // Add the skills as resources
    final skills = await getSkills(this.log);
    for (final skill in skills) {
      try {
        var uri = 'skill:///${skill.name}';
        addResource(
          Resource(name: skill.name, uri: uri, description: skill.description),
          (request) async {
            return ReadResourceResult(
              contents: [TextResourceContents(uri: uri, text: skill.content)],
            );
          },
        );
      } catch (e) {
        log(LoggingLevel.error, e.toString());
      }
    }
    return super.initialize(request);
  }
}

const path = '/usr/local/google/home/jakemac/ai/.agent-skills';

Future<List<Skill>> getSkills(Logger log) async {
  final glob = Glob('**/*.md');
  final files = glob.listSync(root: path);
  return files
      .map((file) => Skill.fromFile(file as File, log))
      .nonNulls
      .toList();
}

class Skill {
  final String name;
  final String description;
  final String content;

  Skill({required this.name, required this.description, required this.content});

  static Skill? fromFile(File file, Logger log) {
    try {
      final content = file.readAsStringSync();
      final [header, body] = content.split('---\n').skip(1).toList();
      final headerYaml = loadYaml(header) as YamlMap;
      final name = headerYaml['name'] as String;
      final description = headerYaml['description'] as String;
      return Skill(name: name, description: description, content: body);
    } catch (e) {
      log(LoggingLevel.error, e.toString());
      return null;
    }
  }
}
