---
name: flutter-pubspec-options
description: Describes the Flutter-only fields in the pubspec file.
metadata:
  url: https://docs.flutter.dev/tools/pubspec#default-flavor-field
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter pubspec options

This page is primarily aimed at folks who write
Flutter apps. If you write packages or plugins,
(perhaps you want to create a federated plugin),
you should check out the
[Developing packages and plugins](/packages-and-plugins/developing-packages)
page.


## Overview

[#](#overview)

Every Flutter project includes a `pubspec.yaml` file,
often referred to as _the pubspec_.
A basic pubspec is generated when you create
a new Flutter project. It's located at the top
of the project tree and contains metadata about
the project that the Dart and Flutter tooling
needs to know. The pubspec is written in
[YAML](https://yaml.org/), which is human readable, but be aware
that _white space (tabs v spaces) matters_.


The pubspec specifies dependencies
that the project requires, such as:


- Particular packages and their versions
- Fonts
- Images
- Developer packages (like testing or mocking packages)
- Particular constraints on the version of the Flutter SDK

Fields common to both Dart and Flutter projects
are described in [the pubspec file](https://dart.dev/tools/pub/pubspec)
on [dart.dev](https://dart.dev).
This page lists _Flutter-specific_ fields and packages
that are only valid for a Flutter project.


## Example

[#](#example)

When you create a new project with the
`flutter create` command (or by using the
equivalent button in your IDE), it creates
a pubspec for a basic Flutter app.


The first time you build your project, it
also creates a `pubspec.lock` file that contains
specific versions of the included packages.
This ensures that you get the same version
the next time the project is built.


Here is an example of a Flutter project pubspec file.
The Flutter-only fields and packages are highlighted.


pubspec.yaml

yaml

```
name: <project name>
description: A new Flutter project.
​
publish_to: none
version: 1.0.0+1
​
environment:
  sdk: ^3.10.0
​
dependencies:
  flutter:       # Required for every Flutter project
    sdk: flutter # Required for every Flutter project
  flutter_localizations: # Required to enable localization
    sdk: flutter         # Required to enable localization
​
  cupertino_icons: ^1.0.8 # Only required if you use Cupertino (iOS style) icons
​
dev_dependencies:
  flutter_test:
    sdk: flutter # Required for a Flutter project that includes tests
​
  flutter_lints: ^6.0.0 # Contains a set of recommended lints for Flutter code
​
flutter:
​
  uses-material-design: true # Required if you use the Material icon font
​
  generate: true # Enables generation of localized strings from arb files
​
  config: # App-specific configuration flags that mirror `flutter config`
    enable-swift-package-manager: true
​
  assets:  # Lists assets, such as image files
    - images/a_dot_burr.png
    - images/a_dot_ham.png
​
  licenses: # Lists additional license files to be bundled with the app
    - assets/my_license.txt
​
  fonts:              # Required if your app uses custom fonts
    - family: Schyler
      fonts:
        - asset: fonts/Schyler-Regular.ttf
        - asset: fonts/Schyler-Italic.ttf
          style: italic
    - family: Trajan Pro
      fonts:
        - asset: fonts/TrajanPro.ttf
        - asset: fonts/TrajanPro_Bold.ttf
          weight: 700

```

content\_copy

## Fields

[#](#fields)

Flutter-specific and Dart-specific fields can be added to
the Flutter pubspec. To learn more about Flutter-specific
fields, see the following sections. To learn more about
Dart-specific fields, see [Dart's pubspec supported fields](https://dart.dev/tools/pub/pubspec#supported-fields).


infoNote

The pubspec can have additional auto-generated Flutter
fields that are not listed here.


### assets field

[#](#assets)

A list of asset paths that your app uses. These assets are
bundled with your application. Common types of assets
include static data (for example, `JSON`),
configuration files, icons, and images ( `JPEG`, `WebP`,
`GIF`, animated `WebP/GIF`, `PNG`, `BMP`, and
`WBMP`).


Besides listing the images that are included in the
app package, an image asset can also refer to one or more
resolution-specific "variants". For more information,
see the [resolution aware](/ui/assets/assets-and-images#resolution-aware)
section of the
[Assets and images](/ui/assets/assets-and-images) page.
For information on adding assets from package
dependencies, see the
[asset images in package dependencies](/ui/assets/assets-and-images#from-packages)

section in the same page.


The `asset` field has this structure:

pubspec.yaml

yaml

```
flutter:
  assets:
    - [ path_to_file | path_to_directory ]
      [ flavor_path_field ]
    [...]

```

content\_copy

yaml

```
# path_to_file structure
- path/to/directory/file

```

content\_copy

yaml

```
# path_to_directory structure
- path/to/directory/

```

content\_copy

yaml

```
# flavor_path_field strucure
- path: path/to/directory
  flavors:
  - flavor_name

```

content\_copy

Subfields of `assets`:

- `path_to_file`: A string that represents the path to
   a file.

- `path_to_directory`: A string that represents the path to
   a directory.

- `flavor_path_field`: A path field and its flavor
   subfields.

- `path`: The path to a directory.
- `flavors`: A list of flutter flavors to use with assets
   at a specific path. To learn more about
   flavors, see [Set up flavors for iOS and macOS](/deployment/flavors-ios)
   and
   [Set up flavors for Android](/deployment/flavors).


You can pass in a path to a file:

pubspec.yaml

yaml

```
flutter:
  assets:
    - assets/images/my_image_a.png
    - assets/images/my_image_b.png

```

content\_copy

You can pass in a path to a directory:

pubspec.yaml

yaml

```
flutter:
  assets:
    - assets/images/
    - assets/icons/

```

content\_copy

You can pass in a path to a directory for specific
flavors:


pubspec.yaml

yaml

```
flutter:
  assets:
    - path: assets/flavor_a_and_b/images
      flavors:
      - flavor_a
      - flavor_b
    - path: assets/flavor_c/images
      flavors:
      - flavor_c

```

content\_copy

### config field

[#](#config)

A map of keys to flags ( `true` or `false`) that influences how the `flutter`
CLI
is executed.


> NOTE: This feature is only available as of
> [#167953](https://github.com/flutter/flutter/pull/167953) on the `main`
>
> channel.

The available keys mirror those available in `flutter config --list`.

pubspec.yaml

yaml

```
flutter:
  config:
    cli-animations: false
    enable-swift-package-manager: true

```

content\_copy

Use `flutter config --help` for a description of each flag.

Flags are only read from the current _application_ package, and have no effect
in the context of a package or dependency.


### default-flavor field

[#](#default-flavor-field)

Assign a default Flutter flavor for an app.
When used, you don't need to include the name of this
flavor in Flutter launch command.


pubspec.yaml

yaml

```
flutter:
  default-flavor: flavor_name

```

content\_copy

In the following example, an Android Flutter app has a
flavor called `staging` and `production`. The `production`

flavor is the default flavor. When that flavor is run,
you don't need to include it in the launch command.


pubspec.yaml

yaml

```
flutter:
  default-flavor: production

```

content\_copy

console

```
// Use this command to run the default flavor (production).
flutter run

// Use this command to run non-default flavors (staging).
flutter run --flavor staging

```

content\_copy

To learn how to create Flutter flavors,
see [Set up Flutter flavors for Android](/deployment/flavors) and
[Set up Flutter flavors for iOS and macOS](/deployment/flavors-ios).


### deferred-components field

[#](#deferred-components-field)

Defer initial the download size of an Android app. Most
often used with large applications, modularized applications,
and applications with on-demand features.


The `deferred-components` field has this structure:

pubspec.yaml

yaml

```
flutter:
  deferred-components:
    name: component_name
      libraries:
        - string_expression
        [...]
      assets:
        - string_expression
        [...]
    [...]

```

content\_copy

Deferred component subfields:

- `name`: The unique identifier for a specific deferred
   component.

- `libraries`: A list of Dart libraries that are part of
   the deferred component.

- `assets`: A list of asset paths that are associated with
   the deferred component.


Example:

pubspec.yaml

yaml

```
flutter:
  deferred-components:
    - name: box_component
      libraries:
        - package:testdeferredcomponents/box.dart
    - name: gallery_feature
      libraries:
        - package:testdeferredcomponents/gallery_feature.dart
      assets:
        - assets/gallery_images/gallery_feature.png

```

content\_copy

To learn more about how you can use deferred components with
a Flutter Android app, see
[Deferred components for Android](/perf/deferred-components).


### disable-swift-package-manager field

[#](#disable-swift-package-manager-field)

Disable the use of the Swift Package Manager (SPM) so that
it no longer manages dependencies in your iOS and macOS
Flutter projects.


pubspec.yaml

yaml

```
flutter:
  disable-swift-package-manager: true

```

content\_copy

> NOTE: As of [#168433](https://github.com/flutter/flutter/pull/168433) on the
> `main` channel, this property has moved to the [`config`](#config)
> section:
>
>
> pubspec.yaml
>
> yaml
>
> ```
> flutter:
>   config:
>     enable-swift-package-manager: false
>
> ```
>
> content\_copy

### flutter field

[#](#flutter-field)

A field that contains Flutter-specific settings for your
app.


pubspec.yaml

yaml

```
flutter:
  [flutter_field]
  [...]

```

content\_copy

### fonts field

[#](#fonts)

Configure and include custom fonts in your Flutter
application.


For examples of using fonts
see the [Use a custom font](/cookbook/design/fonts) and
[Export fonts from a package](/cookbook/design/package-fonts) recipes in the
Flutter cookbook.


The `fonts` field has this structure:

pubspec.yaml

yaml

```
flutter:
  fonts:
    -  { font_family_field | font_asset_field }
    [...]

```

content\_copy

yaml

```
# font_family_field structure
- family: font_name
      fonts:
        - font_asset_field
        [...]

```

content\_copy

yaml

```
# font_asset_field structure
- asset: path/to/directory/font_name
  weight: int_expression # Optional
  style: string_expression # Optional

```

content\_copy

Subfields of `fonts`:

- `family`: Optional. The font family name. Can have
   multiple font assets.

- `asset`: The font to use.
- `weight`: Optional. The weight of the font. This can be
   `100`, `200`, `300`, `400`, `500`,
   `600`, `700`, `800` or
   `900`.

- `style`: Optional. The style of the font. This can be
   `italic`.


Use a font that is not part of a font family:

pubspec.yaml

yaml

```
flutter:
  fonts:
    - asset: fonts/Roboto-Regular.ttf
      weight: 900 # Optional
      style: italic # Optional

```

content\_copy

Use a font family:

pubspec.yaml

yaml

```
flutter:
  fonts:
  - family: Roboto # Optional
        fonts:
          - asset: fonts/Roboto-Regular.ttf
          - asset: fonts/Roboto-Bold.ttf
            weight: 700 # Optional
            style: italic # Optional

```

content\_copy

Alternatively, if you have a font that requires no family,
weight or style requirements, you can declare it as a simple
asset:


pubspec.yaml

yaml

```
flutter:
  assets:
    - fonts/Roboto-Regular.ttf

```

content\_copy

### generate field

[#](#generate-field)

Handles localization tasks. This field can appear as a
subfield of `flutter` and `material`.


Enable general localization:

pubspec.yaml

yaml

```
flutter:
  generate: true

```

content\_copy

### licenses field

[#](#licenses)

A list of additional license file paths that should be bundled with your
application. These files are typically found within your project's `assets`

directory.


The `licenses` field has this structure:

pubspec.yaml

yaml

```
flutter:
  licenses:
    - [path_to_file]

```

content\_copy

### plugin field

[#](#plugin-field)

Configure settings specifically for Flutter plugins.

The `plugin` field has this structure:

pubspec.yaml

yaml

```
flutter:
  plugin:
    platforms:
      android: # Optional
        package: com.example.my_plugin
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      ios: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
        sharedDarwinSource: true
      macos: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
        sharedDarwinSource: true
      windows: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      linux: # Optional
        pluginClass: MyPlugin
        dartPluginClass: MyPluginClassName
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
      web: # Optional
        ffiPlugin: true
        default_package: my_plugin_name
        fileName: my_file.dart
    implements: # Optional
      - example_platform_interface

```

content\_copy

Subfields of `plugin`:

- `platforms`: A list of platforms that will have
   configuration settings.

- `package`: The Android package name of the plugin. This
   can be used with the Android platform and is required.

- `pluginClass`: The name of the plugin class. Optional if
   `dartPluginClass` is used for the same platform. This
   can be used with the Android, iOS, Linux macOS, and
   Windows platforms.

- `default_package`: Optional. The package that should be
   used as the default implementation of a platform
   interface. Only applicable to federated plugins, where the
   plugin's implementation is split into multiple
   platform-specific packages.

- `dartPluginClass`: Optional. The Dart class that serves
   as the entry point for a Flutter plugin. This
   can be used with the Android, iOS, Linux macOS, and
   Windows platforms.

- `sharedDarwinSource`: Optional. Indicates that the plugin
   shares native code between iOS and macOS. This
   can be used with the iOS and macOS platforms.

- `fileName`: Optional. The file that contains the plugin
   class.

- `ffiPlugin`: Optional. True if the plugin uses a
   Foreign Function Interface (FFI).

- `implements`: Optional. The platform interfaces that a
   Flutter plugin implements.


To learn more about plugins, see
[Developing packages & plugins](/packages-and-plugins/developing-packages).


### shaders field

[#](#shaders-field)

GLSL Shaders with the `FRAG` extension, must be declared in
the shaders section of your project's `pubspec.yaml` file.
The Flutter command-line tool compiles the shader to its
appropriate backend format, and generates its necessary
runtime metadata. The compiled shader is then included in
the application just like an asset.


The `shaders` field has this structure:

pubspec.yaml

yaml

```
flutter:
  shaders:
    -  { path_to_file | path_to_directory }
    [...]

```

content\_copy

yaml

```
# path_to_file structure
- assets/shaders/file

```

content\_copy

yaml

```
# path_to_directory structure
- assets/shaders/

```

content\_copy

Add specific shaders:

pubspec.yaml

yaml

```
flutter:
  shaders:
    - assets/shaders/shader_a.frag
    - assets/shaders/shader_b.frag

```

content\_copy

Add a directory of shaders:

pubspec.yaml

yaml

```
flutter:
  shaders:
    - assets/shaders/

```

content\_copy

Alternatively, you can add your shader directory to the
`assets` field:


pubspec.yaml

yaml

```
flutter:
  assets:
    - assets/shaders/my_shader.frag

```

content\_copy

### uses-material-design field

[#](#uses-material-design-field)

Use Material Design components in your Flutter app.

pubspec.yaml

yaml

```
flutter:
  uses-material-design: true

```

content\_copy

## Packages

[#](#packages)

The following Flutter-specific packages can be added to the
pubspec. If you add a package, run `flutter pub get` in your
terminal to install the package.


### flutter package

[#](#flutter-package)

A package that represents the Flutter SDK itself and
can be added to the `dependencies` field. Use this if
your project relies on the Flutter SDK, not a regular
package from pub.dev.


pubspec.yaml

yaml

```
dependencies:
  flutter:
    sdk: flutter

```

content\_copy

### flutter\_localizations package

[#](#flutter-localizations-package)

A package that represents the Flutter SDK itself and
can be added to the `dependencies` field. Use this to
enable the localization of `ARB` files. Often used with
the `intl` package.


pubspec.yaml

yaml

```
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

```

content\_copy

### flutter\_test package

[#](#flutter-test-package)

A package that represents the Flutter SDK itself and
can be added to the `dependencies` field. Use this if you
have unit, widget, or integration tests for your Flutter
app.


pubspec.yaml

yaml

```
dependencies:
  flutter_test:
    sdk: flutter

```

content\_copy

### flutter\_lints package

[#](#flutter-lints-package)

A package that that provides a set of recommended lints for
Flutter projects. This package can be added to the
`dev_dependency` field in the pubspec.


pubspec.yaml

yaml

```
dev_dependencies:
  flutter_lints: ^6.0.0

```

content\_copy

### cupertino\_icons

[#](#cupertino-icons)

A package that provides a set of Apple's Cupertino icons
for use in Flutter applications. This package can be added
to the `dependency` field in the pubspec.


pubspec.yaml

yaml

```
dependencies:
  cupertino_icons: ^1.0.0

```

content\_copy

## More information

[#](#more-information)

For more information on packages, plugins,
and pubspec files, see the following:


- [Creating packages](https://dart.dev/guides/libraries/create-library-packages) on dart.dev

- [Glossary of package terms](https://dart.dev/tools/pub/glossary) on dart.dev
- [Package dependencies](https://dart.dev/tools/pub/dependencies) on dart.dev
- [Using packages](/packages-and-plugins/using-packages)
- [What not to commit](https://dart.dev/guides/libraries/private-files#pubspeclock) on dart.dev


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-11-12. [View source](https://github.com/flutter/website/blob/main/src/content/tools/pubspec.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/pubspec&page-source=https://github.com/flutter/website/blob/main/src/content/tools/pubspec.md "Report an issue with this page").