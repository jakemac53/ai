---
name: flutter-the-flutter-command-line-tool
description: The reference page for using 'flutter' in a terminal window.
metadata:
  url: https://docs.flutter.dev/reference/flutter-cli
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# flutter: The Flutter command-line tool

The `flutter` command-line tool is how developers (or IDEs on behalf of
developers) interact with Flutter. For Dart related commands,
you can use the [`dart`](https://dart.dev/tools/dart-tool) command-line tool.


Here's how you might use the `flutter` tool to create, analyze, test, and run an
app:


```
$ flutter create my_app
$ cd my_app
$ flutter analyze
$ flutter test
$ flutter run lib/main.dart

```

content\_copy

To run [`pub`](https://dart.dev/tools/dart-pub) commands using the `flutter`
tool:


```
$ flutter pub get
$ flutter pub outdated
$ flutter pub upgrade

```

content\_copy

To view all commands that `flutter` supports:

```
$ flutter --help --verbose

```

content\_copy

To get the current version of the Flutter SDK, including its framework, engine,
and tools:


```
$ flutter --version

```

content\_copy

## `flutter` commands

[#](#flutter-commands)

The following table shows which commands you can use with the `flutter` tool:

CommandExample of useMore informationanalyze`flutter analyze -d <DEVICE_ID>`
Analyzes the project's Dart source code.


Use instead of
[`dart analyze`](https://dart.dev/tools/dart-analyze)
.
assemble`flutter assemble -o <DIRECTORY>`Assemble and build flutter resources.attach`flutter attach -d <DEVICE_ID>`Attach to a running application.bash-completion`flutter bash-completion`Output command line shell completion setup scripts.build`flutter build <DIRECTORY>`Flutter build commands.channel`flutter channel <CHANNEL_NAME>`List or switch flutter channels.clean`flutter clean`Delete the `build/` and `.dart_tool/` directories.config`flutter config --build-dir=<DIRECTORY>`Configure Flutter settings. To remove a setting, configure it to an empty string.create`flutter create <DIRECTORY>`Creates a new project.custom-devices`flutter custom-devices list`Add, delete, list, and reset custom devices.devices`flutter devices -d <DEVICE_ID>`List all connected devices.doctor`flutter doctor`Show information about the installed tooling.downgrade`flutter downgrade`Downgrade Flutter to the last active version for the current channel.drive`flutter drive`Runs Flutter Driver tests for the current project.emulators`flutter emulators`List, launch and create emulators.gen-l10n`flutter gen-l10n <DIRECTORY>`Generate localizations for the Flutter project.install`flutter install -d <DEVICE_ID>`Install a Flutter app on an attached device.logs`flutter logs`Show log output for running Flutter apps.precache`flutter precache <ARGUMENTS>`Populates the Flutter tool's cache of binary artifacts.pub`flutter pub <PUB_COMMAND>`
Works with packages.


Use instead of
[`dart pub`](https://dart.dev/tools/dart-pub)
.
run`flutter run <DART_FILE>`Runs a Flutter program.screenshot`flutter screenshot`Take a screenshot of a Flutter app from a connected device.symbolize`flutter symbolize --input=<STACK_TRACK_FILE>`Symbolize a stack trace from the AOT compiled flutter application.test`flutter test [<DIRECTORYDART_FILE>]`
Runs tests in this package.


Use instead of
[`dart test`](https://dart.dev/tools/dart-test)
.
upgrade`flutter upgrade`Upgrade your copy of Flutter.

For additional help on any of the commands, enter `flutter help <command>`
or follow the links in the **More information** column.
You can also get details on `pub` commands — for example,
`flutter help pub outdated`.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/reference/flutter-cli.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/reference/flutter-cli&page-source=https://github.com/flutter/website/blob/main/src/content/reference/flutter-cli.md "Report an issue with this page").