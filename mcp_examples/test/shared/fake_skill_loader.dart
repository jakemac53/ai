// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mcp_examples/skills.dart';

/// A fake implementation of [SkillLoader] for tests.
class FakeSkillLoader implements SkillLoader {
  List<Skill> skills = [];

  @override
  Future<List<Skill>> load() async => skills;
}
