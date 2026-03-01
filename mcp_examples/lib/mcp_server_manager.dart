// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:dart_mcp/client.dart';
import 'package:dart_mcp/server.dart';
import 'package:dart_mcp/stdio.dart';
import 'package:stream_channel/stream_channel.dart';

import 'buffered_logger.dart';

/// Abstract class to manage the lifecycle and connection of MCP servers.
abstract class McpServerManager {
  /// Starts all servers and returns a stream of their connections.
  Stream<ServerConnection> startServers(
    MCPClient client, {
    Sink<String>? protocolLogSink,
  });
}

/// A [McpServerManager] that starts MCP servers as separate processes using stdio.
class StdioMcpServerManager implements McpServerManager {
  final List<String> serverCommands;
  final BufferedLogger logger;

  StdioMcpServerManager(this.serverCommands, {required this.logger});

  @override
  Stream<ServerConnection> startServers(
    MCPClient client, {
    Sink<String>? protocolLogSink,
  }) async* {
    for (var server in serverCommands) {
      final parts = server.split(' ');
      try {
        final process = await Process.start(
          parts.first,
          parts.skip(1).toList(),
        );
        yield client.connectServer(
          stdioChannel(input: process.stdout, output: process.stdin),
          protocolLogSink: protocolLogSink,
        )..done.then((_) => process.kill());
      } catch (e) {
        logger.stderr('Failed to connect to server $server: $e');
      }
    }
  }
}

typedef MCPServerFactory =
    Future<MCPServer> Function(StreamChannel<String> channel);

/// A [McpServerManager] that yields a predefined list of [ServerConnection]s.
class FakeMcpServerManager implements McpServerManager {
  final List<MCPServerFactory> serverFactories = [];

  FakeMcpServerManager();

  @override
  Stream<ServerConnection> startServers(
    MCPClient client, {
    Sink<String>? protocolLogSink,
  }) async* {
    for (var factory in serverFactories) {
      final clientToServer = StreamController<String>();
      final serverToClient = StreamController<String>();

      final clientChannel = StreamChannel<String>(
        serverToClient.stream,
        clientToServer.sink,
      );
      final serverChannel = StreamChannel<String>(
        clientToServer.stream,
        serverToClient.sink,
      );

      await factory(serverChannel);
      yield await client.connectServer(
        clientChannel,
        protocolLogSink: protocolLogSink,
      );
    }
  }
}
