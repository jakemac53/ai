// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/buffered_logger.dart';

import 'fake_generative_service.dart';
import 'fake_skill_loader.dart';

/// A version of [WorkflowClient] that uses fake services and
/// records certain interactions for testing purposes.
base class TestWorkflowClient extends WorkflowClient {
  TestWorkflowClient()
    : super(
        [],
        api: FakeGenerativeService(),
        model: '',
        logger: BufferedLogger(name: 'fake'),
        autoStart: false,
        skillLoader: FakeSkillLoader(),
      );

  final List<String> submittedInputs = [];

  @override
  void submitInput(String value) {
    submittedInputs.add(value);
    super.submitInput(value);
  }
}
