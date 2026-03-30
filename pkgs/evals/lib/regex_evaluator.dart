import 'package:genkit/genkit.dart';
import 'package:schemantic/schemantic.dart';

part 'regex_evaluator.g.dart';

@Schema()
abstract class $RegexEvalOptions {
  String get pattern;
}

/// A regex matching evaluator.
Action regexEvaluator(Genkit ai) {
  return ai.defineEvaluator(
    name: 'regex-evaluator',
    description: 'Matches the output against a regex pattern',
    fn: (input, context) async {
      final responses = <EvalFnResponse>[];
      final options = RegexEvalOptions.$schema.parse(input.options ?? {});
      final regex = RegExp(options.pattern);

      for (final dataPoint in input.dataset) {
        final text = dataPoint.output?['text'] as String? ?? '';
        final matches = regex.hasMatch(text);
        final score = matches ? 1.0 : 0.0;
        final reasoning = matches
            ? 'Output matches pattern: ${options.pattern}'
            : 'Output does not match pattern: ${options.pattern}. Found: $text';

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
