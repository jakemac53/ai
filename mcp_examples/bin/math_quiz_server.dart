// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library;

import 'dart:io' as io;

import 'package:dart_mcp/server.dart';
import 'package:dart_mcp/stdio.dart';

void main() {
  MathQuizServer(stdioChannel(input: io.stdin, output: io.stdout));
}

base class MathQuizServer extends MCPServer
    with
        LoggingSupport,
        ElicitationRequestSupport,
        ToolsSupport,
        ResourcesSupport {
  MathQuizServer(super.channel)
    : super.fromStreamChannel(
        implementation: Implementation(
          name: 'math-quiz-server',
          version: '0.1.0',
        ),
        instructions: 'A server that tests elicitation via a math quiz.',
      ) {
    registerTool(
      Tool(
        name: 'take_math_quiz',
        description: 'Starts an interactive math quiz with the user.',
        inputSchema: Schema.object(properties: {}),
      ),
      _handleMathQuiz,
    );

    addResource(
      Resource(
        name: 'multiplication',
        description: 'A guide to multiplication.',
        uri: 'math://multiplication',
      ),
      (request) {
        return ReadResourceResult(
          contents: [
            TextResourceContents(
              uri: 'math://multiplication',
              text:
                  'Multiplication works by adding a number to itself a '
                  'specified number of times. For example, 3 * 4 means '
                  'adding 3 to itself 4 times, which equals 12. See also '
                  'math://addition.',
            ),
          ],
        );
      },
    );

    addResource(
      Resource(
        name: 'addition',
        description: 'A guide to addition.',
        uri: 'math://addition',
      ),
      (request) {
        return ReadResourceResult(
          contents: [
            TextResourceContents(
              uri: 'math://addition',
              text:
                  'Addition works by combining numbers to find their sum. '
                  'For example, 3 + 4 means combining 3 and 4, which equals 7.',
            ),
          ],
        );
      },
    );

    addResource(
      Resource(
        name: 'prime numbers',
        description: 'A guide to prime numbers.',
        uri: 'math://prime_numbers',
      ),
      (request) {
        return ReadResourceResult(
          contents: [
            TextResourceContents(
              uri: 'math://prime_numbers',
              text:
                  'Prime numbers are numbers that are only divisible by 1 and '
                  'themselves. For example, 7 is a prime number because it is '
                  'only divisible by 1 and 7.',
            ),
          ],
        );
      },
    );
  }

  Future<CallToolResult> _handleMathQuiz(CallToolRequest request) async {
    int score = 0;
    int maxScore = 0;

    // 1. Elicit Name
    final nameResult = await elicit(
      ElicitRequest.form(
        message: 'Welcome to the Math Quiz! Please enter your name:',
        requestedSchema: Schema.object(
          properties: {'name': Schema.string(title: 'Your full name')},
          required: ['name'],
        ),
        // Some clients require the progress token from a tool call
        // for elicitations.
        meta: request.meta,
      ),
    );

    if (nameResult.action != ElicitationAction.accept) {
      return CallToolResult(
        content: [TextContent(text: 'Quiz cancelled before starting.')],
      );
    }
    final name = nameResult.content!['name'] as String;

    maxScore += 3;
    final q1Result = await elicit(
      ElicitRequest.form(
        message: 'Addition questions',
        requestedSchema: Schema.object(
          properties: {
            'a1': Schema.int(title: 'What is 5 + 7?'),
            'a2': Schema.int(title: 'What is 10 + 15?'),
            'a3': Schema.int(title: 'What is 115 + 31?'),
          },
          required: ['a1', 'a2', 'a3'],
        ),
        // Some clients require the progress token from a tool call
        // for elicitations.
        meta: request.meta,
      ),
    );

    if (q1Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }
    final q1Answers = q1Result.content! as Map<String, dynamic>;
    if (q1Answers['a1'] == 12) {
      score++;
    }
    if (q1Answers['a2'] == 25) {
      score++;
    }
    if (q1Answers['a3'] == 146) {
      score++;
    }

    maxScore += 3;
    final q2Result = await elicit(
      ElicitRequest.form(
        message: 'Multiplication questions',
        requestedSchema: Schema.object(
          properties: {
            'a1': Schema.int(title: 'What is 3 * 2?'),
            'a2': Schema.int(title: 'What is 10 * 15?'),
            'a3': Schema.int(title: 'What is 115 * 31?'),
          },
          required: ['a1', 'a2', 'a3'],
        ),
        // Some clients require the progress token from a tool call
        // for elicitations.
        meta: request.meta,
      ),
    );

    if (q2Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }
    final q2Answers = q2Result.content! as Map<String, dynamic>;
    if (q2Answers['a1'] == 6) {
      score++;
    }
    if (q2Answers['a2'] == 150) {
      score++;
    }
    if (q2Answers['a3'] == 3565) {
      score++;
    }
    maxScore++;
    final q3Result = await elicit(
      ElicitRequest.form(
        message: 'General questions',
        requestedSchema: Schema.object(
          properties: {
            'answer': EnumSchema.untitledMultiSelect(
              title: 'Which of these is a prime number?',
              values: ['4', '7', '15', '23', '113', '121'],
            ),
          },
          required: ['answer'],
        ),
        // Some clients require the progress token from a tool call
        // for elicitations.
        meta: request.meta,
      ),
    );

    if (q3Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }

    final q3Answer = q3Result.content!['answer'] as List;
    if (q3Answer.length == 3 &&
        q3Answer.contains('7') &&
        q3Answer.contains('23') &&
        q3Answer.contains('113')) {
      score++;
    }

    return CallToolResult(
      content: [
        TextContent(
          text:
              '# Math Quiz Results\n\n**Candidate:** $name\n**Score:** $score / $maxScore\n\nThanks for participating!',
        ),
      ],
    );
  }
}
