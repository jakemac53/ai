---
name: binding-to-native-android-code-using-dart-ffi
description: To use C code in your Flutter program, use the dart:ffi library.
metadata:
  url: https://docs.flutter.dev/platform-integration/android/c-interop
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Binding to native Android code using dart:ffi

warningWarning

This page documents a legacy approach to C interop on Android.

Since Flutter 3.38, we recommend using a `package_ffi` template with
[build hooks](/platform-integration/bind-native-code) for C interop.


However, the legacy FFI plugin template ( `plugin_ffi`) documented here is
still useful if you need to:


- Access the Flutter Plugin API.
- Configure a Google Play services runtime on Android.

Flutter mobile and desktop apps can use the
[dart:ffi](https://api.dart.dev/dart-ffi/dart-ffi-library.html) library to call native C APIs.
_FFI_ stands for [_foreign function interface._](https://en.wikipedia.org/wiki/Foreign_function_interface)

Other terms for similar functionality include
_native interface_ and _language bindings._

infoNote

This page describes using the `dart:ffi` library
in Android apps. For information on iOS, see
[Binding to native iOS code using dart:ffi](/platform-integration/ios/c-interop).
For information in macOS, see
[Binding to native macOS code using dart:ffi](/platform-integration/macos/c-interop).
This feature is not yet supported for web plugins.


Before your library or program can use the FFI library
to bind to native code, you must ensure that the
native code is loaded and its symbols are visible to Dart.
This page focuses on compiling, packaging,
and loading Android native code within a Flutter plugin or app.


This tutorial demonstrates how to bundle C/C++
sources in a Flutter plugin and bind to them using
the Dart FFI library on both Android and iOS.
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
loaded using [`DynamicLibrary.executable`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html)
or
[`DynamicLibrary.process`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html).


A dynamically linked library, by contrast, is distributed
in a separate file or folder within the app,
and loaded on-demand. On Android, a dynamically
linked library is distributed as a set of `.so` (ELF)
files, one for each architecture.


A dynamically linked library can be loaded into
Dart via [`DynamicLibrary.open`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html).


API documentation is available from the
[Dart API reference documentation](https://api.dart.dev).


On Android, only dynamic libraries are supported
(because the main executable is the JVM,
which we don't link to statically).


## Create an FFI plugin

[#](#create-an-ffi-plugin)

To create an FFI plugin called "native\_add",
do the following:


```
$ flutter create --platforms=android,ios,macos,windows,linux --template=plugin_ffi native_add
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


On Android, the `native_add/android/build.gradle` links the code.

The native code is invoked from dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [package:ffigen](https://pub.dev/packages/ffigen).

## Other use cases

[#](#other-use-cases)

### Platform library

[#](#platform-library)

To link against a platform library,
use the following instructions:


1. Find the desired library in the [Android NDK Native APIs](https://developer.android.com/ndk/guides/stable_apis)

    list in the Android docs. This lists stable native APIs.

2. Load the library using [`DynamicLibrary.open`](https://api.dart.dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html).
    For example, to load OpenGL ES (v3):



   dart

   ```
   DynamicLibrary.open('libGLES_v3.so');

   ```

   content\_copy


You might need to update the Android manifest
file of the app or plugin if indicated by
the documentation.


#### First-party library

[#](#first-party-library)

The process for including native code in source
code or binary form is the same for an app or
plugin.


#### Open-source third-party

[#](#open-source-third-party)

Follow the [Add C and C++ code to your project](https://developer.android.com/studio/projects/add-native-code)

instructions in the Android docs to
add native code and support for the native
code toolchain (either CMake or `ndk-build`).


#### Closed-source third-party library

[#](#closed-source-third-party-library)

To create a Flutter plugin that includes Dart
source code, but distribute the C/C++ library
in binary form, use the following instructions:


1. Open the `android/build.gradle` file for your
    project.

2. Add the AAR artifact as a dependency.
    **Don't** include the artifact in your
    Flutter package. Instead, it should be
    downloaded from a repository, such as
    JCenter.


## Android APK size (shared object compression)

[#](#android-apk-size-shared-object-compression)

[Android guidelines](https://developer.android.com/topic/performance/reduce-apk-size#extract-false)
in general recommend
distributing native shared objects uncompressed
because that actually saves on device space.
Shared objects can be directly loaded from the APK
instead of unpacking them on device into a
temporary location and then loading.
APKs are additionally packed in transit—that's
why you should be looking at download size.


Flutter APKs by default don't follow these guidelines
and compress `libflutter.so` and `libapp.so`&mdash;this
leads to smaller APK size but larger on device size.


Shared objects from third parties can change this default
setting with `android:extractNativeLibs="true"` in their
`AndroidManifest.xml` and stop the compression of `libflutter.so`,
`libapp.so`, and any user-added shared objects.
To re-enable compression, override the setting in
`your_app_name/android/app/src/main/AndroidManifest.xml`
in the following way.


xml

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.your_app_name">
    xmlns:tools="http://schemas.android.com/tools"
    package="com.example.your_app_name" >
    <!-- io.flutter.app.FlutterApplication is an android.app.Application that
         calls FlutterMain.startInitialization(this); in its onCreate method.
         In most cases you can leave this as-is, but you if you want to provide
         additional functionality it is fine to subclass or reimplement
         FlutterApplication and put your custom class here. -->
​
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="your_app_name"
        android:icon="@mipmap/ic_launcher">
        android:icon="@mipmap/ic_launcher"
        android:extractNativeLibs="true"
        tools:replace="android:extractNativeLibs">

```

content\_copy

## Other Resources

[#](#other-resources)

To learn more about C interoperability, check out these videos:

- [C interoperability with Dart FFI](https://www.youtube.com/watch?v=2MMK7YoFgaA)
- [How to Use Dart FFI to Build a Retro Audio Player](https://www.youtube.com/watch?v=05Wn2oM_nWw)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-23. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/android/c-interop.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/android/c-interop&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/android/c-interop.md "Report an issue with this page").