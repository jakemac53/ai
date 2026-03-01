// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/skills.dart';
import 'package:test/test.dart';
import 'package:test_descriptor/test_descriptor.dart' as d;

void main() {
  late BufferedLogger logger;

  setUp(() {
    logger = BufferedLogger();
  });

  group('RealSkillLoader', () {
    test('loads skills from .agent and .agents in the root', () async {
      await d.dir('project', [
        d.dir('.agent', [
          d.dir('skills', [
            d.dir('skill1', [
              d.file(
                'SKILL.md',
                '---\nname: skill1\ndescription: desc1\n---\ncontent',
              ),
            ]),
          ]),
        ]),
        d.dir('.agents', [
          d.dir('skills', [
            d.dir('skill2', [
              d.file(
                'SKILL.md',
                '---\nname: skill2\ndescription: desc2\n---\ncontent',
              ),
            ]),
          ]),
        ]),
      ]).create();

      final loader = FileSystemSkillLoader(
        logger: logger,
        root: Directory(d.path('project')),
      );

      final skills = await loader.load();

      expect(skills, hasLength(2));
      expect(skills.map((s) => s.name), containsAll(['skill1', 'skill2']));
    });

    test('loads skills from parent directories', () async {
      await d.dir('parent', [
        d.dir('left', [
          d.dir('.agent', [
            d.dir('skills', [
              d.dir('parent_skill', [
                d.file(
                  'SKILL.md',
                  '---\nname: parent_skill\ndescription: parent_desc\n---\ncontent',
                ),
              ]),
            ]),
          ]),
          d.dir('child', []),
        ]),
        // Not in immediate hierarchy, should not be found
        d.dir('right', [
          d.dir('.agent', [
            d.dir('skills', [
              d.dir('other_skill', [
                d.file(
                  'SKILL.md',
                  '---\nname: other_skill\ndescription: other_desc\n---\ncontent',
                ),
              ]),
            ]),
          ]),
        ]),
      ]).create();

      final loader = FileSystemSkillLoader(
        logger: logger,
        root: Directory(d.path('parent/left/child')),
      );

      final skills = await loader.load();
      expect(skills.single.name, 'parent_skill');
    });

    test('loads skills from child directories', () async {
      await d.dir('parent', [
        d.dir('child', [
          d.dir('.agent', [
            d.dir('skills', [
              d.dir('child_skill', [
                d.file(
                  'SKILL.md',
                  '---\nname: child_skill\ndescription: child_desc\n---\ncontent',
                ),
              ]),
            ]),
          ]),
        ]),
      ]).create();

      final loader = FileSystemSkillLoader(
        logger: logger,
        root: Directory(d.path('parent')),
      );

      final skills = await loader.load();

      expect(skills, hasLength(1));
      expect(skills.first.name, 'child_skill');
    });

    test('ignores skills with invalid format', () async {
      await d.dir('project', [
        d.dir('.agent', [
          d.dir('skills', [
            d.dir('invalid_skill', [d.file('SKILL.md', 'invalid format')]),
          ]),
        ]),
      ]).create();

      final loader = FileSystemSkillLoader(
        logger: logger,
        root: Directory(d.path('project')),
      );

      final skills = await loader.load();

      expect(skills, isEmpty);
      expect(
        logger.logEntries.any(
          (e) =>
              e.level == LogLevel.stderr &&
              e.message.contains('Invalid format'),
        ),
        isTrue,
      );
    });

    test('handles duplicate skills by preferring earlier found ones', () async {
      await d.dir('project', [
        d.dir('.agent', [
          d.dir('skills', [
            d.dir('duplicate', [
              d.file(
                'SKILL.md',
                '---\nname: duplicate\ndescription: first\n---\ncontent',
              ),
            ]),
          ]),
        ]),
        d.dir('subdir', [
          d.dir('.agent', [
            d.dir('skills', [
              d.dir('duplicate', [
                d.file(
                  'SKILL.md',
                  '---\nname: duplicate\ndescription: second\n---\ncontent',
                ),
              ]),
            ]),
          ]),
        ]),
      ]).create();

      final loader = FileSystemSkillLoader(
        logger: logger,
        root: Directory(d.path('project')),
      );

      final skills = await loader.load();

      expect(skills, hasLength(1));
      expect(skills.first.name, 'duplicate');
      expect(
        logger.logEntries.any((e) => e.message.contains('already exists')),
        isTrue,
      );
    });
  });
}
