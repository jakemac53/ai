---
name: support-for-webassembly-wasm
description: Current status of Flutter's support for WebAssembly (Wasm).
metadata:
  url: https://docs.flutter.dev/platform-integration/web/wasm
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Support for WebAssembly (Wasm)

Flutter and Dart support
[WebAssembly](https://webassembly.org/)
as a compilation target when building
applications for the web.


## Get started

[#](#get-started)

To try a pre-built Flutter web app using Wasm, check out the
[Wonderous demo app](https://wonderous.app/web/).


To experiment with Wasm in your own apps, use the following steps.

### Switch to the latest version of Flutter

[#](#switch-to-the-latest-version-of-flutter)

Switch to Flutter version 3.24 or higher
to run and compile Flutter applications to WebAssembly.
To ensure you are running the latest version, run `flutter upgrade`.


### Ensure that your app's dependencies are compatible

[#](#ensure-that-your-apps-dependencies-are-compatible)

Try the default template [sample app](/reference/create-new-app),
or choose any Flutter application
that has been migrated to be
[compatible with Wasm](#js-interop-wasm).


### Modify the index page

[#](#modify-the-index-page)

Make sure your app's `web/index.html` is updated to the latest
[Flutter web app initialization](/platform-integration/web/initialization)
for Flutter 3.22 and later.


If you would like to use the default, delete the contents of the `web/`
directory and run the following command to regenerate them:


```
$ flutter create . --platforms web

```

content\_copy

### Run or build your app

[#](#run-or-build-your-app)

To run the app with Wasm for development or testing,
use the `--wasm` flag with the `flutter run` command.


```
$ flutter run -d chrome --wasm

```

content\_copy

To build a web application with Wasm, add the `--wasm` flag to
the existing `flutter build web` command.


```
$ flutter build web --wasm

```

content\_copy

The command produces output into the `build/web` directory relative to the
package root, just like `flutter build web`.


### Open the app in a compatible web browser

[#](#open-the-app-in-a-compatible-web-browser)

Even with the `--wasm` flag, Flutter will still compile the application to
JavaScript. If WasmGC support is not detected at runtime, the JavaScript output
is used so the application will continue to work in all major browsers.


You can verify whether the app is actually running with Wasm by checking for
the `dart2wasm` environment variable, set during compilation (preferred).


dart

```
const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');

```

content\_copy

Alternatively, you can use differences in number representations
to test whether the native (Wasm) number representation is used.


dart

```
final isRunningWithWasm = identical(double.nan, double.nan);

```

content\_copy

### Serve the built output with an HTTP server

[#](#serve-the-built-output-with-an-http-server)

Flutter web WebAssembly can use multiple threads to render your application
faster, with less jank. To do this, Flutter uses advanced browser features that
require specific HTTP response headers.


feedbackImportant

Flutter web applications compiled with WebAssembly won't run with multiple-threads
unless the server is configured to send specific HTTP headers.


NameValue`Cross-Origin-Embedder-Policy``credentialless`

or

`require-corp``Cross-Origin-Opener-Policy``same-origin`

To learn more about these headers, check out
[Load cross-origin resources without CORP headers using COEP: credentialless](https://developer.chrome.com/blog/coep-credentialless-origin-trial).


## Learn more about browser compatibility

[#](#learn-more-about-browser-compatibility)

To run a Flutter app that has been compiled to Wasm,
you need a browser that supports [WasmGC](https://github.com/WebAssembly/gc/tree/main/proposals/gc).


[Chromium and V8](https://chromestatus.com/feature/6062715726462976) support WasmGC since version 119.
Chrome on iOS uses WebKit, which doesn't yet [support WasmGC](https://bugs.webkit.org/show_bug.cgi?id=247394).
Firefox announced stable support for WasmGC in Firefox 120,
but currently doesn't work due to a known limitation (see details below).


- **Why not Firefox?**
   Firefox versions 120 and later were previously able to run Flutter/Wasm, but
   they're experiencing a bug that is blocking compatibility with Flutter's Wasm
   renderer. Follow [this bug](https://bugzilla.mozilla.org/show_bug.cgi?id=1788206)
   for details.

- **Why not Safari?**
   Safari now supports WasmGC, but is experiencing a similar bug that is
   blocking compatibility with Flutter's Wasm renderer.
   Follow [this bug](https://bugs.webkit.org/show_bug.cgi?id=267291) for details.


warningWarning

Flutter compiled to Wasm can't run on the iOS version of any browser.
All browsers on iOS are required to use WebKit,
and can't use their own browser engine.


## Using compatible JS interop libraries

[#](#js-interop-wasm)

To support compilation to Wasm, Dart has changed
how it enables interop with browser and JavaScript APIs.
This prevents Dart code that uses `dart:html` or `package:js`

from compiling to Wasm.


Instead, Dart now provides new, lightweight interop solutions built around
static JS interop:


- [`package:web`](https://pub.dev/packages/web), which replaces `dart:html`
   (and other web libraries)

- [`dart:js_interop`](https://api.dart.dev/dart-js_interop/dart-js_interop-library.html), which replaces
   `package:js` and `dart:js`

To learn more about JS interop in Dart,
see Dart's [JS interop](https://dart.dev/interop/js-interop) documentation page.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/wasm.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/wasm&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/wasm.md "Report an issue with this page").