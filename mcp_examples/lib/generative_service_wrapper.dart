// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:google_cloud_ai_generativelanguage_v1beta/generativelanguage.dart'
    as gemini;

/// A wrapper around [gemini.GenerativeService] that is not a `final class`, so
/// it can be implemented with a fake for tests.
interface class GenerativeServiceWrapper {
  final gemini.GenerativeService _service;

  GenerativeServiceWrapper(this._service);

  Stream<gemini.GenerateContentResponse> streamGenerateContent(
    gemini.GenerateContentRequest request,
  ) {
    return _service.streamGenerateContent(request);
  }
}
