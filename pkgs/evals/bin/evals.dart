import 'package:evals/sample_eval.dart';
import 'package:genkit/genkit.dart';
import 'package:genkit_google_genai/genkit_google_genai.dart';
import 'package:genkit_mcp/genkit_mcp.dart';

void main() async {
  // Initialize Genkit with Google GenAI.
  final ai = Genkit(plugins: [googleAI()]);

  // Connect to the local Dart MCP server.
  // This assumes we are running from pkgs/evals.
  final mcpHost = defineMcpHost(
    ai,
    const McpHostOptionsWithCache(
      name: 'dart-mcp-host',
      mcpServers: {
        'dart-mcp-server': McpServerConfig(
          command: 'dart',
          args: ['run', 'dart_mcp_server:main'],
        ),
      },
    ),
  );

  print('Connecting to MCP host...');
  await mcpHost.ready().timeout(
    const Duration(seconds: 10),
    onTimeout: () {
      print('MCP Host timed out waiting to be ready.');
    },
  );
  print('MCP Host is ready.');

  // Wait a bit for tool discovery.
  await Future<void>.delayed(const Duration(seconds: 2));

  // Load sample evaluator.
  final evaluator = sampleEvaluator(ai);

  print('\nTesting tool invocation via MCP Host...');
  try {
    final response = await ai.generate<dynamic, String>(
      model: googleAI.gemini('gemini-3.1-flash-lite-preview'),
      prompt:
          'Search pub.dev for "mcp" and tell me the name of the top 2 results. '
          'Strictly only give the name of the package and nothing else.',
      toolNames: ['dart-mcp-host:*'],
    );
    print('\nResponse from Gemini:');
    print(response.text);

    print('\nTesting evaluator invocation...');
    final evalResult =
        await evaluator(
              EvalRequest(
                evalRunId: 'test-run',
                dataset: [
                  BaseDataPoint(
                    testCaseId: 'test-1',
                    input: {'prompt': 'Search for mcp'},
                    output: {'text': response.text},
                  ),
                ],
              ),
            )
            as List<EvalFnResponse>;

    print('\nEvaluation Result:');
    for (final response in evalResult) {
      final score = Score.fromJson(response.evaluation as Map<String, dynamic>);
      print('Score: ${score.score}');
      print('Reasoning: ${score.details?['reasoning']}');
    }
  } catch (e, s) {
    print('Error during operation: $e\n$s');
  }

  print('\nEvals project initialized and connected to Dart MCP server.');
  await mcpHost.close();
}
