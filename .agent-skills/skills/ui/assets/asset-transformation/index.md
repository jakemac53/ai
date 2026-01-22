---
name: transforming-assets-at-build-time
description: How to set up automatic transformation of images (and other assets) in your Flutter app.
metadata:
  url: https://docs.flutter.dev/ui/assets/asset-transformation
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Transforming assets at build time

You can configure your project to automatically transform assets
at build time using compatible Dart packages.


## Specifying asset transformations

[#](#specifying-asset-transformations)

In the `pubspec.yaml` file, list the assets to be transformed and the associated
transformer package.


yaml

```
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler

```

content\_copy

With this configuration, `assets/logo.svg` is transformed by the
[`vector_graphics_compiler`](https://pub.dev/packages/vector_graphics_compiler)
package as it is copied to the build output. This
package precompiles SVG files into an optimized binary files that can be
displayed using the [`vector_graphics`](https://pub.dev/packages/vector_graphics)
package, like so:


dart

```
import 'package:vector_graphics/vector_graphics.dart';
​
const Widget logo = VectorGraphic(loader: AssetBytesLoader('assets/logo.svg'));

```

content\_copy

### Passing arguments to asset transformers

[#](#passing-arguments-to-asset-transformers)

To pass a string of arguments to an asset transformer,
also specify that in the pubspec:


yaml

```
flutter:
  assets:
    - path: assets/logo.svg
      transformers:
        - package: vector_graphics_compiler
          args: ['--tessellate', '--font-size=14']

```

content\_copy

### Chaining asset transformers

[#](#chaining-asset-transformers)

Asset transformers can be chained and are applied in
the order they are declared.
Consider the following example using imaginary packages:


yaml

```
flutter:
  assets:
    - path: assets/bird.png
      transformers:
        - package: grayscale_filter
        - package: png_optimizer

```

content\_copy

Here, `bird.png` is transformed by the `grayscale_filter` package.
The output is then transformed by the `png_optimizer` package before being
bundled into the built app.


## Writing asset transformer packages

[#](#writing-asset-transformer-packages)

An asset transformer is a Dart [command-line app](https://dart.dev/tutorials/server/cmdline)
that is invoked with
`dart run` with at least two arguments: `--input`, which contains the path to
the file to transform and `--output`, which is the location where the
transformer code must write its output to.


If the transformer finishes with a non-zero exit code, the application build
fails with error message explaining that transformation of the asset failed.
Anything written to the [`stderr`](https://api.flutter.dev/flutter/dart-io/Process/stderr.html)
stream of the process by the transformer is
included in the error message.


During the invocation of the transformer, the `FLUTTER_BUILD_MODE`
environment variable will be set to the CLI name of the build mode being used.
For example, if you run your app with `flutter run -d macos --release`, then
`FLUTTER_BUILD_MODE` will be set to `release`.


## Sample

[#](#sample)

For a sample Flutter project that uses asset transformation and includes a custom
Dart package that is used as a transformer, check out the
[asset\_transformers project in the Flutter samples repo](https://github.com/flutter/samples/tree/main/asset_transformation).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-22. [View source](https://github.com/flutter/website/blob/main/src/content/ui/assets/asset-transformation.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/assets/asset-transformation&page-source=https://github.com/flutter/website/blob/main/src/content/ui/assets/asset-transformation.md "Report an issue with this page").