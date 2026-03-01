// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:mcp_examples/workflow_client.dart';

extension Ready on WorkflowClient {
  Future<void> get ready async {
    if (isReady.value) return;
    final completer = Completer<void>();
    isReady.addListener(completer.complete);
    await completer.future;
    isReady.removeListener(completer.complete);
  }
}
