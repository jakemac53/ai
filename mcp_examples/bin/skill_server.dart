// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// An MCP Server which loads "skill" files from a `.agent-skills` directory.
///
/// These are exposed as MCP Resources, using the `skill:` URI scheme, with the
/// name of the skill as the path.
///
/// Note that clients must support auto inclusion of MCP Resources in the
/// context, for these skills to function properly.
library;

import 'dart:async';
import 'dart:io';
import 'package:dart_mcp/server.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) {
  var path = '.agent-skills';
  if (args.isNotEmpty) {
    // Only one argument is allowed
    path = args.single;
  }
  final skillsDir = Directory(path);
  if (!Directory(path).existsSync()) {
    throw StateError(
      'Unable to load skills from directory ${skillsDir.absolute.path}',
    );
  }
  SkillServer.fromStreamChannel(
    stdioChannel(input: stdin, output: stdout),
    skillsDir,
  );
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
  final Directory skillsDir;

  SkillServer.fromStreamChannel(super.channel, this.skillsDir)
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
    final skills = await getSkills(this.log, skillsDir.absolute.path);
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

Future<List<Skill>> getSkills(Logger log, String path) async {
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
