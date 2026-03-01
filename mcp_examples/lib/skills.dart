// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:mcp_examples/buffered_logger.dart';
import 'package:yaml/yaml.dart';

class Skill {
  final String name;
  final String description;
  final String path;

  Skill({required this.name, required this.description, required this.path});
}

abstract interface class SkillLoader {
  Future<List<Skill>> load();
}

class FileSystemSkillLoader implements SkillLoader {
  final Set<String> _seenPaths = {};
  final List<Skill> _skills = [];
  final BufferedLogger _logger;
  final Directory _root;

  FileSystemSkillLoader({required BufferedLogger logger, Directory? root})
    : _logger = logger,
      _root = root ?? Directory.current;

  @override
  Future<List<Skill>> load() async {
    _skills.clear();
    _seenPaths.clear();

    // Phase 1: Search the current directory recursively for any SKILL.md under .agent or .agents
    final skillGlob = Glob(
      '{.agent,.agents,**/.agent,**/.agents}/skills/**/SKILL.md',
    );
    await for (final entity in skillGlob.list(
      root: _root.path,
      followLinks: false,
    )) {
      if (entity is File) {
        await _tryAddSkill(entity.path);
      }
    }

    // Phase 2: Walk up parent directories and look specifically in .agent or .agents
    var current = _root.parent;
    final parentGlob = Glob('{.agent,.agents}/skills/**/SKILL.md');
    while (true) {
      await for (final entity in parentGlob.list(
        root: current.path,
        followLinks: false,
      )) {
        if (entity is File) {
          await _tryAddSkill(entity.path);
        }
      }

      final parent = current.parent;
      if (parent.path == current.path) break; // Reached root
      current = parent;
    }

    return List.unmodifiable(_skills);
  }

  Future<void> _tryAddSkill(String path) async {
    if (_seenPaths.contains(path)) return;
    _seenPaths.add(path);

    try {
      final content = await File(path).readAsString();
      final skill = _parseSkill(content, path);
      if (skill != null) {
        // Avoid duplicates by name (preferring those found earlier)
        if (_skills.firstWhereOrNull((s) => s.name == skill.name)
            case final existingSkill?) {
          _logger.stdout(
            'Skill ${skill.name} already exists at ${existingSkill.path}, skipping $path',
          );
        } else {
          _logger.stdout('Loaded skill ${skill.name} at $path');
          _skills.add(skill);
        }
      }
    } catch (e, s) {
      _logger.stderr('Failed to load skill at $path: $e\n$s');
    }
  }

  Skill? _parseSkill(String content, String path) {
    final parts = content.split('---\n');
    if (parts.length < 3) {
      _logger.stderr(
        'Failed to parse skill at $path: Invalid format, requires a header '
        'section surrounded by lines with just "---".',
      );
      return null;
    }

    try {
      final yaml = loadYaml(parts[1]);
      if (yaml is! YamlMap) {
        _logger.stderr(
          'Failed to parse skill at $path: Invalid format, header section '
          'should be a YAML map.',
        );
        return null;
      }

      final name = yaml['name']?.toString();
      final description = yaml['description']?.toString();

      if (name != null && description != null) {
        return Skill(
          name: name,
          description: description
              .replaceAll('\n', ' ')
              .trim()
              .replaceAll(RegExp(r'\s+'), ' '),
          path: path,
        );
      }
    } catch (e, s) {
      _logger.stderr('Failed to parse skill at $path: $e\n$s');
    }
    return null;
  }
}
