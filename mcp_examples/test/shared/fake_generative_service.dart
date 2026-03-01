// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;
import 'package:google_cloud_protobuf/protobuf.dart' as pb;
import 'package:mcp_examples/generative_service_wrapper.dart';

/// A fake implementation of [GenerativeServiceWrapper] for tests.
class FakeGenerativeService implements GenerativeServiceWrapper {
  /// The list of requests that have been made to this fake.
  final _requests = <gemini.GenerateContentRequest>[];

  /// Public getter for the list of requests as an iterable.
  Iterable<gemini.GenerateContentRequest> get requests => _requests;

  /// The [StreamController] for the active request.
  StreamController<gemini.GenerateContentResponse>? _responseController;

  Completer<gemini.GenerateContentRequest> _nextRequestCompleter = Completer();
  Future<gemini.GenerateContentRequest> get nextRequest =>
      _nextRequestCompleter.future;

  @override
  Stream<gemini.GenerateContentResponse> streamGenerateContent(
    gemini.GenerateContentRequest request,
  ) {
    assert(_responseController == null);
    _nextRequestCompleter.complete(request);
    _nextRequestCompleter = Completer();
    _requests.add(request);
    final controller =
        _responseController =
            StreamController<gemini.GenerateContentResponse>();
    return controller.stream;
  }

  /// Sends a response to active response stream.
  void sendResponse(gemini.GenerateContentResponse response) {
    _responseController!.add(response);
  }

  /// Closes the active response stream.
  void closeRequest() {
    _responseController!.close();
    _responseController = null;
  }

  /// Helper to send a simple text response candidate.
  void sendTextResponse(String text) {
    sendResponse(
      gemini.GenerateContentResponse(
        candidates: [
          gemini.Candidate(
            content: gemini.Content(
              parts: [gemini.Part(text: text)],
              role: 'model',
            ),
          ),
        ],
        usageMetadata: gemini.GenerateContentResponse_UsageMetadata(
          promptTokenCount: 10,
          candidatesTokenCount: text.length,
          totalTokenCount: 10 + text.length,
        ),
      ),
    );
  }

  /// Helper to send a function call from the model.
  void sendFunctionCall(String name, Map<String, Object?> args) {
    sendResponse(
      gemini.GenerateContentResponse(
        candidates: [
          gemini.Candidate(
            content: gemini.Content(
              parts: [
                gemini.Part(
                  functionCall: gemini.FunctionCall(
                    name: name,
                    args: pb.Struct.fromJson(args),
                  ),
                ),
              ],
              role: 'model',
            ),
          ),
        ],
        usageMetadata: gemini.GenerateContentResponse_UsageMetadata(
          promptTokenCount: 10,
          candidatesTokenCount: 10,
          totalTokenCount: 20,
        ),
      ),
    );
  }
}
