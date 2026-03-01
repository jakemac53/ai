// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_mcp/server.dart';

base class TestMcpServer extends MCPServer
    with
        PromptsSupport,
        ResourcesSupport,
        ToolsSupport,
        LoggingSupport,
        ElicitationRequestSupport {
  TestMcpServer(super.channel)
    : super.fromStreamChannel(
        implementation: Implementation(name: 'test-server', version: '1.0.0'),
      );
}
