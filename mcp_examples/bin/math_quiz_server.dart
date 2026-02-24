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
    with LoggingSupport, ElicitationRequestSupport, ToolsSupport {
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
  }

  Future<CallToolResult> _handleMathQuiz(CallToolRequest request) async {
    int score = 0;
    int maxScore = 0;

    // 1. Elicit Name
    final nameResult = await elicit(
      ElicitRequest(
        message: 'Welcome to the Math Quiz! Please enter your name:',
        requestedSchema: Schema.object(
          properties: {'name': Schema.string(description: 'Your full name.')},
          required: ['name'],
        ),
      ),
    );

    if (nameResult.action != ElicitationAction.accept) {
      return CallToolResult(
        content: [TextContent(text: 'Quiz cancelled before starting.')],
      );
    }

    final name = (nameResult.content as Map<String, dynamic>)['name'] as String;

    // 2. Question 1
    maxScore++;
    final q1Result = await elicit(
      ElicitRequest(
        message: 'Question 1: What is 5 + 7?',
        requestedSchema: Schema.object(
          properties: {'answer': Schema.int()},
          required: ['answer'],
        ),
      ),
    );

    if (q1Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }

    if ((q1Result.content as Map<String, dynamic>)['answer'] == 12) {
      score++;
    }

    // 3. Question 2
    maxScore++;
    final q2Result = await elicit(
      ElicitRequest(
        message: 'Question 2: What is 12 * 12?',
        requestedSchema: Schema.object(
          properties: {'answer': Schema.int()},
          required: ['answer'],
        ),
      ),
    );

    if (q2Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }

    if ((q2Result.content as Map<String, dynamic>)['answer'] == 144) {
      score++;
    }

    // 4. Question 3 (Multiple Choice)
    maxScore++;
    final q3Result = await elicit(
      ElicitRequest(
        message: 'Question 3: Which of these is a prime number?',
        requestedSchema: Schema.object(
          properties: {
            'answer': Schema.string(enumValues: ['4', '6', '7', '9']),
          },
          required: ['answer'],
        ),
      ),
    );

    if (q3Result.action != ElicitationAction.accept) {
      return CallToolResult(content: [TextContent(text: 'Quiz cancelled.')]);
    }

    if ((q3Result.content as Map<String, dynamic>)['answer'] == '7') {
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
