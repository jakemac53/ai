// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;
import 'package:mcp_examples/generative_service_wrapper.dart';
import 'package:mcp_examples/skills.dart';
import 'package:nocterm/nocterm.dart';

import 'package:mcp_examples/buffered_logger.dart';
import 'package:mcp_examples/workflow_client.dart';

import '../lib/ui/app.dart';

/// The list of Gemini models that are accepted as a "--model" argument.
/// Defaults to the first one in the list.
const List<String> allowedGeminiModels = WorkflowClient.allowedGeminiModels;

void main(List<String> args) {
  final geminiApiKey = Platform.environment['GEMINI_API_KEY'];
  if (geminiApiKey == null) {
    throw ArgumentError(
      'No environment variable GEMINI_API_KEY found, you must set one to your '
      'API key in order to run this client. You can get a key at '
      'https://aistudio.google.com/apikey.',
    );
  }

  final parsedArgs = argParser.parse(args);
  if (parsedArgs.wasParsed('help')) {
    print(argParser.usage);
    exit(0);
  }

  final serverCommands = parsedArgs['server'] as List<String>;
  final logger = BufferedLogger();
  final logFilePath = parsedArgs.option('log');

  final client = WorkflowClient(
    serverCommands,
    api: GenerativeServiceWrapper(
      gemini.GenerativeService.fromApiKey(geminiApiKey),
    ),
    verbose: parsedArgs.flag('verbose'),
    dtdUri: parsedArgs.option('dtd'),
    model: parsedArgs.option('model')!,
    logger: logger,
    logFile: logFilePath != null ? File(logFilePath) : null,
    skillLoader: FileSystemSkillLoader(logger: logger),
  );

  runApp(ClientApp(client: client));
}

final argParser =
    ArgParser()
      ..addMultiOption(
        'server',
        abbr: 's',
        help: 'A command to run to start an MCP server',
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        help: 'Enables verbose logging for logs from servers.',
      )
      ..addOption(
        'log',
        abbr: 'l',
        help:
            'If specified, will create the given log file and log server '
            'traffic and diagnostic messages.',
      )
      ..addFlag('dash', help: 'Use the Dash mascot persona.', defaultsTo: false)
      ..addOption(
        'dtd',
        help: 'Pass the DTD URI to use for this workflow session.',
      )
      ..addOption(
        'model',
        defaultsTo: allowedGeminiModels.first,
        allowed: allowedGeminiModels,
        help: 'Pass the name of the model to use to run inferences.',
      )
      ..addFlag('help', abbr: 'h', help: 'Print the usage for this command.');
