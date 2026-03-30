import 'package:genkit/genkit.dart';
import 'package:schemantic/schemantic.dart';

part 'tool_use_evaluator.g.dart';

@Schema()
abstract class $ToolUseEvalOptions {
  List<String> get expectedTools;
}

/// An evaluator that checks if MCP tools were used as expected.
Action toolUseEvaluator(Genkit ai) {
  return ai.defineEvaluator(
    name: 'tool-use-evaluator',
    description: 'An evaluator for MCP tools usage',
    fn: (input, context) async {
      final responses = <EvalFnResponse>[];
      final options = ToolUseEvalOptions.$schema.parse(input.options ?? {});
      final expectedTools = options.expectedTools;

      for (final dataPoint in input.dataset) {
        // Extract tool requests from context
        final actualTools = <String>[];
        final contextList = dataPoint.context ?? [];

        for (final item in contextList.cast<Map<String, dynamic>>()) {
          // If context is list of messages
          final content = item['content'] as List?;
          if (content != null) {
            for (final part in content.cast<Map<String, dynamic>>()) {
              final toolRequest = part['toolRequest'] as Map?;
              if (toolRequest != null) {
                actualTools.add(toolRequest['name'] as String);
              }
            }
          }
        }

        // Assert tool names (flexible matching to handle potential Genkit
        // provider prefixes)
        final missingTools = expectedTools.where((expected) {
          return !actualTools.any(
            (actual) =>
                actual == expected ||
                actual.endsWith(':$expected') ||
                actual.endsWith('/$expected'),
          );
        }).toList();

        final score = missingTools.isEmpty ? 1.0 : 0.0;
        final reasoning = missingTools.isEmpty
            ? 'All expected tools were called: ${expectedTools.join(', ')}. '
                'Actual tools found: ${actualTools.join(', ')}'
            : 'Missing tool calls: ${missingTools.join(', ')}. '
                'Found: ${actualTools.join(', ')}';

        responses.add(
          EvalFnResponse(
            testCaseId: dataPoint.testCaseId ?? 'unknown',
            evaluation: EvalFnResponseEvaluation.score(
              Score(
                score: ScoreScore.double(score),
                details: {'reasoning': reasoning},
              ),
            ),
          ),
        );
      }
      return responses;
    },
  );
}
