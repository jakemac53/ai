---
name: bind-to-native-code-using-ffi
description: To use native code in your Flutter program, use the dart:ffi library with the package_ffi template.
metadata:
  url: https://docs.flutter.dev/platform-integration/bind-native-code
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Bind to native code using FFI

Flutter apps can use the [dart:ffi](https://api.dart.dev/dart-ffi/dart-ffi-library.html) library to call native APIs.
_FFI_ stands
for [_foreign function interface_](https://en.wikipedia.org/wiki/Foreign_function_interface). Other terms for similar functionality
include _native interface_ and _language bindings._

Since Flutter 3.38, the recommended way to bind to native code is to use the
`flutter create --template=package_ffi` command. This template uses
[build hooks](https://dart.dev/tools/hooks) to configure the native build in a
`build.dart` script, and no longer requires OS-specific build files. This
approach works for both Flutter and Dart standalone projects.


The legacy FFI plugins ( `flutter create --template=plugin_ffi`) are still useful
for some situations. For these cases, refer to the legacy FFI plugin
documentation:


- [Android](/platform-integration/android/c-interop)
- [iOS](/platform-integration/ios/c-interop)
- [macOS](/platform-integration/macos/c-interop)

## Create an FFI package

[#](#create-an-ffi-package)

To create an FFI package, run the following command:

```
$ flutter create --template=package_ffi native_add
$ cd native_add

```

content\_copy

This creates a package with the following specialized content:

- **`lib/native_add.dart`**: The Dart code that defines the API of the package.

- **`lib/src/native_add_bindings_generated.dart`**: The generated Dart bindings
   for the native code.

- **`src/native_add.c`**: The native C source code.
- **`src/native_add.h`**: The C header file for the native code.
- **`hook/build.dart`**: A script that is run by the Flutter SDK to compile the
   native code.

- **`ffigen.yaml`**: The configuration file for [`package:ffigen`](https://pub.dev/packages/ffigen)
   to generate
   the Dart bindings.

- **`pubspec.yaml`**: The package definition, which enables the `build.dart`

   hook.


## The native code

[#](#the-native-code)

The native code is located in `src/native_add.c` and `src/native_add.h`. The C
function `sum` is defined in the `.c` file and its signature is in the header
file. The function is marked to be exported so that it can be called from Dart.


## The build hook

[#](#the-build-hook)

The native code is compiled and bundled with your app automatically. This is
done by the `hook/build.dart` script, which is a [build hook](https://dart.dev/tools/hooks).


This means you no longer need to write OS-specific build files (like
`CMakeLists.txt` for Linux/Windows, `.podspec` for iOS/macOS, or
`build.gradle`
for Android) to compile your native code.


The build hook uses `package:native_toolchain_c` to compile the C code into a
dynamic library. You can customize this file to build other native languages or
to download pre-compiled binaries.


## The Dart code

[#](#the-dart-code)

The Dart code defines the public API of the package.

### Generating the bindings

[#](#generating-the-bindings)

To bind to the native code, the template uses [`package:ffigen`](https://pub.dev/packages/ffigen)
to generate
bindings from the header file ( `src/native_add.h`). The generation is configured
in `ffigen.yaml`.


This generates `lib/src/native_add_bindings_generated.dart`.

### Calling the native function

[#](#calling-the-native-function)

The generated bindings in `lib/src/native_add_bindings_generated.dart` contain
`@Native() external` functions. These functions are automatically resolved at
runtime against the code asset outputted by the build hook (which runs at build
time). This means there is no OS-specific logic required for `dlopen`-ing the
dynamic libraries, making the Dart code truly cross-platform.


The main library file `lib/native_add.dart` exposes these functions. Your app
can then call these functions by importing `package:native_add/native_add.dart`.


## Testing

[#](#testing)

The generated package includes a unit test in `test/native_add_test.dart` that
shows how to test the native function.


## Other use cases

[#](#other-use-cases)

### System libraries

[#](#system-libraries)

To link against a system library, you modify the `build.dart` hook to specify
the linking mode. Instead of compiling source code, you create a `CodeAsset`
and
set its `linkMode`.


For many system libraries on Android, iOS, Linux, and macOS, you can use
`LookupInProcess()` to find symbols in the main process.


For Windows, you often use `DynamicLoadingSystem()` and provide the name of the
DLL.


Here is an example `build.dart` that links against system libraries to get the
host name:


dart

```
// hook/build.dart
import 'package:hooks/hooks.dart';
import 'package:code_assets/code_assets.dart';
​
void main(List<String> args) async {
  await build(args, (input, output) async {
    final targetOS = input.target.os;
    switch (targetOS) {
      case OS.android || OS.iOS || OS.linux || OS.macOS:
        output.assets.code.add(
          CodeAsset(
            package: 'host_name',
            name: 'src/third_party/unix.dart',
            linkMode: LookupInProcess(),
          ),
        );
      case OS.windows:
        output.assets.code.add(
          CodeAsset(
            package: 'host_name',
            name: 'src/third_party/windows.dart',
            linkMode: DynamicLoadingSystem(Uri.file('ws2_32.dll')),
          ),
        );
      default:
        throw Exception('Unsupported target os: $targetOS');
    }
  });
}

```

content\_copy

The Dart files ( `unix.dart`, `windows.dart`) would then contain the `external`

functions that use the symbols from these system libraries.


### Closed-source libraries

[#](#closed-source-libraries)

You can also use build hooks to link against pre-compiled, closed-source
libraries. The recommended approach is to download the pre-compiled binaries at
build time and verify their integrity with a file hash.


In your `build.dart` hook, you would:

1. Download the library from a URL.
2. Verify the hash of the downloaded file.
3. Place the library in the build output directory.
4. Create a `CodeAsset` with `DynamicLoading` pointing to the library.

Here is a simplified example of the `CodeAsset` creation:

dart

```
// hook/build.dart
import 'package:hooks/hooks.dart';
import 'package:code_assets/code_assets.dart';
​
void main(List<String> args) async {
  await build(args, (input, output) async {
    // 1. Download the library from a URL.
    // 2. Verify the hash of the downloaded file.
    // 3. Place the library in the build output directory.
​
    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: 'src/my_lib.dart', // Dart file with bindings
        linkMode: DynamicLoadingBundled(),
        file: input.outputDirectory.resolve('my_lib.so'),
      ),
    );
  });
}

```

content\_copy

You would need to handle different architectures and platforms by having
different versions of your pre-compiled library.


For more examples, see the [code\_assets package\
examples](https://pub.dev/packages/code_assets/example).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-23. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/bind-native-code.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/bind-native-code&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/bind-native-code.md "Report an issue with this page").