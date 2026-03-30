import 'package:genkit/genkit.dart';

/// A sample evaluator that checks if an MCP tool was used correctly.
Action sampleEvaluator(Genkit ai) {
  return ai.defineEvaluator(
    name: 'sample-evaluator',
    description: 'A sample evaluator for MCP tools',
    fn: (input, context) async {
      // Input will typically be a Genkit trace or a direct tool invocation.
      // This is just a placeholder for logic that would verify MCP tools.
      return [
        EvalFnResponse(
          testCaseId: 'mock-test-case',
          evaluation: EvalFnResponseEvaluation.score(
            Score(
              score: ScoreScore.double(1.0),
              details: {'reasoning': 'The tool was found and executed.'},
            ),
          ),
        ),
      ];
    },
  );
}
