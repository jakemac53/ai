---
name: binding-to-native-macos-code-using-dart-ffi
description: To use C code in your Flutter program, use the dart:ffi library.
metadata:
  url: https://docs.flutter.dev/platform-integration/macos/c-interop
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Binding to native macOS code using dart:ffi

warningWarning

This page documents a legacy approach to C interop on macOS.

Since Flutter 3.38, we recommend using a `package_ffi` template with
[build hooks](/platform-integration/bind-native-code) for C interop.


However, the legacy FFI plugin template ( `plugin_ffi`) documented here is
still useful if you need to:


- Access the Flutter Plugin API.
- Use static linking.

Flutter mobile and desktop apps can use the
[dart:ffi](https://api.dart.dev/dart-ffi/dart-ffi-library.html) library to call native C APIs.
_FFI_ stands for [_foreign function interface._](https://en.wikipedia.org/wiki/Foreign_function_interface)

Other terms for similar functionality include
_native interface_ and _language bindings._

infoNote

This page describes using the `dart:ffi` library
in macOS desktop apps.
For information on Android, see
[Binding to native Android code using dart:ffi](/platform-integration/android/c-interop).
For information on iOS, see
[Binding to native iOS code using dart:ffi](/platform-integration/ios/c-interop).
This feature is not yet supported for web plugins.


Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading macOS native code within a Flutter plugin or app.


This tutorial demonstrates how to bundle C/C++
sources in a Flutter plugin and bind to them using
the Dart FFI library on macOS.
In this walkthrough, you'll create a C function
that implements 32-bit addition and then
exposes it through a Dart plugin named "native\_add".


## Dynamic vs static linking

[#](#dynamic-vs-static-linking)

A native library can be linked into an app either
dynamically or statically. A statically linked library
is embedded into the app's executable image,
and is loaded when the app starts.


Symbols from a statically linked library can be
loaded using `DynamicLibrary.executable` or
`DynamicLibrary.process`.


A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. On macOS, the dynamically linked
library is distributed as a `.framework` folder.


A dynamically linked library can be loaded into
Dart using `DynamicLibrary.open`.


API documentation is available from the
[Dart API reference documentation](https://api.dart.dev).


## Create an FFI plugin

[#](#create-an-ffi-plugin)

If you already have a plugin, skip this step.

To create a plugin called "native\_add",
do the following:


```
$ flutter create --platforms=macos --template=plugin_ffi native_add
$ cd native_add

```

content\_copy

infoNote

You can exclude platforms from `--platforms` that you don't want
to build to. However, you need to include the platform of
the device you are testing on.


This will create a plugin with C/C++ sources in `native_add/src`.
These sources are built by the native build files in the various
os build folders.


The FFI library can only bind against C symbols,
so in C++ these symbols are marked `extern "C"`.


You should also add attributes to indicate that the
symbols are referenced from Dart,
to prevent the linker from discarding the symbols
during link-time optimization.
`__attribute__((visibility("default"))) __attribute__((used))`.


On iOS, the `native_add/macos/native_add.podspec` links the code.

The native code is invoked from dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [package:ffigen](https://pub.dev/packages/ffigen).

## Other use cases

[#](#other-use-cases)

### iOS and macOS

[#](#ios-and-macos)

Dynamically linked libraries are automatically loaded by
the dynamic linker when the app starts. Their constituent
symbols can be resolved using [`DynamicLibrary.process`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html).
You can also get a handle to the library with
[`DynamicLibrary.open`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html)
to restrict the scope of
symbol resolution, but it's unclear how Apple's
review process handles this.


Symbols statically linked into the application binary
can be resolved using [`DynamicLibrary.executable`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html)
or
[`DynamicLibrary.process`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html).


#### Platform library

[#](#platform-library)

To link against a platform library,
use the following instructions:


1. In Xcode, open `Runner.xcworkspace`.
2. Select the target platform.
3. Click **+** in the **Linked Frameworks and Libraries**
    section.

4. Select the system library to link against.

#### First-party library

[#](#first-party-library)

A first-party native library can be included either
as source or as a (signed) `.framework` file.
It's probably possible to include statically linked
archives as well, but it requires testing.


#### Source code

[#](#source-code)

To link directly to source code,
use the following instructions:


1. In Xcode, open `Runner.xcworkspace`.

2. Add the C/C++/Objective-C/Swift
    source files to the Xcode project.

3. Add the following prefix to the
    exported symbol declarations to ensure they
    are visible to Dart:

   **C/C++/Objective-C**



   objc

   ```
   extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))

   ```

   content\_copy



   **Swift**



   swift

   ```
   @_cdecl("myFunctionName")

   ```

   content\_copy


#### Compiled (dynamic) library

[#](#compiled-dynamic-library)

To link to a compiled dynamic library,
use the following instructions:


1. If a properly signed `Framework` file is present,
    open `Runner.xcworkspace`.

2. Add the framework file to the **Embedded Binaries**
    section.

3. Also add it to the **Linked Frameworks & Libraries**
    section of the target in Xcode.


#### Compiled (dynamic) library (macOS)

[#](#compiled-dynamic-library-macos)

To add a closed source library to a
[Flutter macOS Desktop](/platform-integration/macos/building) app,
use the following instructions:


1. Follow the instructions for Flutter desktop to create
    a Flutter desktop app.

2. Open the `yourapp/macos/Runner.xcworkspace` in Xcode.
   1. Drag your precompiled library ( `libyourlibrary.dylib`)
       into `Runner/Frameworks`.
   2. Click `Runner` and go to the `Build Phases` tab.
      1. Drag `libyourlibrary.dylib` into the
          `Copy Bundle Resources` list.
      2. Under `Embed Libraries`, check `Code Sign on Copy`.
      3. Under `Link Binary With Libraries`,
          set status to `Optional`. (We use dynamic linking,
          no need to statically link.)
   3. Click `Runner` and go to the `General` tab.
      1. Drag `libyourlibrary.dylib` into the **Frameworks,**
         **Libraries and Embedded Content** list.
      2. Select **Embed & Sign**.
   4. Click **Runner** and go to the **Build Settings** tab.
      1. In the **Search Paths** section configure the
          **Library Search Paths** to include the path
          where `libyourlibrary.dylib` is located.
3. Edit `lib/main.dart`.
   1. Use `DynamicLibrary.open('libyourlibrary.dylib')`
       to dynamically link to the symbols.
   2. Call your native function somewhere in a widget.
4. Run `flutter run` and check that your native function gets called.
5. Run `flutter build macos` to build a self-contained release
    version of your app.


## Other Resources

[#](#other-resources)

To learn more about C interoperability, check out these videos:

- [C interoperability with Dart FFI](https://www.youtube.com/watch?v=2MMK7YoFgaA)
- [How to Use Dart FFI to Build a Retro Audio Player](https://www.youtube.com/watch?v=05Wn2oM_nWw)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-23. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/macos/c-interop.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/macos/c-interop&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/macos/c-interop.md "Report an issue with this page").