---
name: web-renderers
description: Choosing build modes and renderers for a Flutter web app.
metadata:
  url: https://docs.flutter.dev/platform-integration/web/renderers
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Web renderers

Flutter web offers two _build modes_, and two _renderers_.
The two build modes are the **default** and **WebAssembly**,
and the two renderers are **canvaskit** and **skwasm**.


Flutter chooses the build mode when building the app,
and determines which renderers are available at runtime.


For a default build,
Flutter chooses the `canvaskit` renderer at runtime.
For a WebAssembly build,
Flutter chooses the `skwasm` renderer at runtime,
and falls back to `canvaskit` if the browser doesn't support `skwasm`.


## Build modes

[#](#build-modes)

### Default build mode

[#](#default-build-mode)

Flutter chooses the default mode when the
`flutter run` or `flutter build web` commands are
used without passing `--wasm`, or when passing `--no-wasm`.


This build mode only uses the `canvaskit` renderer.

To run in a Chrome using the default build mode:

```
flutter run -d chrome

```

content\_copy

To build your app for release using the default build mode:

```
flutter build web

```

content\_copy

### WebAssembly build mode

[#](#webassembly-build-mode)

This mode is enabled by passing `--wasm` to `flutter run` and
`flutter build web` commands.


This mode makes both `skwasm` and `canvaskit` available. `skwasm` requires
[WasmGC](https://developer.chrome.com/blog/wasmgc), which is not yet supported by all modern browsers.
Therefore, at runtime Flutter chooses `skwasm` if garbage collection is
supported, and falls back to `canvaskit` if not. This allows apps compiled in the
WebAssembly mode to still run in all modern browsers.


The `--wasm` flag is not supported by non-web platforms.

To run in Chrome using the WebAssembly mode:

```
flutter run -d chrome --wasm

```

content\_copy

To build your app for release using the WebAssembly mode:

```
flutter build web --wasm

```

content\_copy

## Renderers

[#](#renderers)

Flutter has two renderers ( `canvaskit` and `skwasm`)
that re-implement the Flutter engine to run the browser.
The renderer converts UI primitives (stored as `Scene` objects) into
pixels.


### canvaskit

[#](#canvaskit)

The `canvaskit` renderer is compatible with all modern browsers, and is the
renderer that is used in the _default_ build mode.


It includes a copy of Skia compiled to WebAssembly, which adds
about 1.5MB in download size.


### skwasm

[#](#skwasm)

The `skwasm` renderer is a more compact version of Skia
that is compiled to WebAssembly and supports rendering on a separate thread.


This renderer must be used with the _WebAssembly_ build mode,
which compiles the Dart code to WebAssembly.


To take advantage of multiple threads,
the web server must meet the [SharedArrayBuffer security requirements](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#security_requirements).
In this mode,
Flutter uses a dedicated [web worker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API)
to offload part of the rendering
workload to a separate thread,
taking advantage of multiple CPU cores.
If the browser does not meet these requirements,
the `skwasm` renderer runs in a single-threaded configuration.


This renderer includes a more compact version of Skia compiled to WebAssembly,
adding about 1.1MB in download size.


## Choosing a renderer at runtime

[#](#choosing-a-renderer-at-runtime)

By default, when building in WebAssembly mode, Flutter will decide when to
use `skwasm`, and when to fallback to `canvaskit`. This can be overridden by
passing a configuration object to the loader, as follows:


1. Build the app with the `--wasm` flag to make both `skwasm` and `canvaskit`

    renderers available to the app.

2. Set up custom web app initialization as described in
    [Write a custom `flutter_bootstrap.js`](/platform-integration/web/initialization#custom-bootstrap-js).

3. Prepare a configuration object with the `renderer` property set to
    `"canvaskit"` or `"skwasm"`.

4. Pass your prepared config object as the `config` property of
    a new object to the `_flutter.loader.load` method that is
    provided by the earlier injected code.


Example:

html

```
<body>
  <script>
    {{flutter_js}}
    {{flutter_build_config}}
​
    // TODO: Replace this with your own code to determine which renderer to use.
    const useCanvasKit = true;
​
    const config = {
      renderer: useCanvasKit ? "canvaskit" : "skwasm",
    };
    _flutter.loader.load({
      config: config,
    });
  </script>
</body>

```

content\_copy

The web renderer can't be changed after calling the `load` method. Therefore,
any decisions about which renderer to use, must be made prior to calling
`_flutter.loader.load`.


## Choosing which build mode to use

[#](#choosing-which-build-mode-to-use)

To compile Dart to WebAssembly,
your app and its plugins / packages must meet the following requirements:


- **Use new JS Interop** -
   The code must only use the new JS interop library `dart:js_interop`. Old-style
   `dart:js`, `dart:js_util`, and `package:js` are no longer supported.

- **Use new Web APIs** -
   Code using Web APIs must use the new `package:web` instead of `dart:html`.

- **Number compatibility** -
   WebAssembly implements Dart's numeric types `int` and `double`
   exactly the
   same as the Dart VM. In JavaScript these types are emulated using the JS
   `Number` type. It is possible that your code accidentally or purposefully
   relies on the JS behavior for numbers. If so, such code needs to be updated to
   behave correctly with the Dart VM behavior.


Use these tips to decide which mode to use:

- **Package support** \- Choose the default mode if your app relies on plugins and packages that do
   not yet support WebAssembly.

- **Performance** -
   Choose the WebAssembly mode if your app's code and packages are compatible
   with WebAssembly and app performance is important. `skwasm` has noticeably
   better app start-up time and frame performance compared to `canvaskit`.
   `skwasm` is particularly effective in multi-threaded mode, so consider
   configuring the server such that it meets the
   [SharedArrayBuffer security requirements](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#security_requirements).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/renderers.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/renderers&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/renderers.md "Report an issue with this page").