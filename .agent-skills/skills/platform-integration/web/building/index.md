---
name: building-a-web-application-with-flutter
description: Instructions for creating a Flutter app for the web.
metadata:
  url: https://docs.flutter.dev/platform-integration/web/building
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Building a web application with Flutter

This page provides an overview of how to configure, run, and build a web
application using Flutter.


## Requirements

[#](#requirements)

Before you can build a web application with Flutter,
make sure that you have the [Flutter SDK](/get-started) and a web browser installed.
See the [Set up web development for Flutter](https://docs.flutter.dev/platform-integration/web/setup)
instructions
for details.


## Set up a Flutter project

[#](#set-up-a-flutter-project)

To set up your project, you can create a
new Flutter project or add web support
to an existing project.


### Create a new project

[#](#create-a-new-project)

To create a new app that includes web support, run the following command:

```
$ flutter create my_app

```

content\_copy

### Add web support to an existing project

[#](#add-web-support-to-an-existing-project)

If you already have a project,
run the `flutter create` command in your project directory:


```
$ flutter create . --platforms web

```

content\_copy

This creates a `web/` directory containing the web assets used to bootstrap
and run your Flutter app.


## Run your app

[#](#run-your-app)

See the following sections to run your app.

### Run your app from the command line

[#](#run-your-app-from-the-command-line)

Select [Chrome](https://www.google.com/chrome/) as your app's target device to run and debug
a Flutter web app:


```
$ flutter run -d chrome

```

content\_copy

You can also choose Chrome as a target device in your IDE.

If you prefer, you can use the `edge` device type on Windows,
or use `web-server` to
navigate to a local URL in the browser of your choice.


infoHot reload on the web

As of the Flutter 3.35 release,
hot reload is enabled by default on the web.
[Hot restart](/tools/hot-reload) is still available as well.


If you discover any issues we ask that you file a bug
using our [Web Hot Reload issue template](https://github.com/dart-lang/sdk/issues/new?template=5_web_hot_reload.yml).
Note this is in the Dart SDK repository where it's easier
for us to track issues. Known issues can be seen in the
associated [GitHub project](https://github.com/orgs/dart-lang/projects/107/views/1).


### Run your app using WebAssembly

[#](#run-your-app-using-webassembly)

You can pass the `--wasm` flag to run your app using WebAssembly:

```
$ flutter run -d chrome --wasm

```

content\_copy

Flutter web offers multiple build modes and renderers.
For more information, see [Web renderers](/platform-integration/web/renderers).


### Disable hot reload in VS Code

[#](#disable-hot-reload-in-vs-code)

To temporarily disable hot reload support from VS Code,
update your [`launch.json` file](https://code.visualstudio.com/docs/debugtest/debugging-configuration)
file with
the flag `--no-web-experimental-hot-reload`.


```
"configurations": [
    ...
    {
      "name": "Flutter for web (hot reload disabled)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": [
        "-d",
        "chrome",
        "--no-web-experimental-hot-reload",
      ]
    }
  ]

```

content\_copy

### Disable hot reload from the command line

[#](#disable-hot-reload-from-the-command-line)

If you use `flutter run` from the command line,
you can temporarily disable hot reload on the web with the
following command:


```
flutter run -d chrome --no-web-experimental-hot-reload

```

content\_copy

### Use hot reload in DartPad

[#](#use-hot-reload-in-dartpad)

Hot reload is also enabled in DartPad with a new "Reload" button.
The feature is only available if Flutter is detected
in the running application. You can begin a hot reloadable
session by selecting a sample app provided by DartPad.


## Build your app

[#](#build-your-app)

See the following sections to build your app.

### Build your app from the command line

[#](#build-your-app-from-the-command-line)

Run the following command to generate a release build:

```
$ flutter build web

```

content\_copy

### Build your app using WebAssembly

[#](#build-your-app-using-webassembly)

You can also pass the `--wasm` flag to build your app using WebAssembly:

```
$ flutter build web --wasm

```

content\_copy

This populates a `build/web` directory
with built files, including an `assets` directory,
which need to be served together.


To learn more about how to deploy these assets to the web, see
[Build and release a web app](/deployment/web).
For answers to other common questions, see the [Web FAQ](/platform-integration/web/faq).


## Debugging

[#](#debugging)

Use [Flutter DevTools](/tools/devtools) for the following tasks:

- [Debugging](/tools/devtools/debugger)
- [Logging](/tools/devtools/logging)
- [Running Flutter inspector](/tools/devtools/inspector)

Use [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools) for the following tasks:


- [Generating event timeline](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference)
- [Analyzing performance](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance)—make sure to use a
   profile build


## Testing

[#](#testing)

Use [widget tests](/testing/overview#widget-tests) or integration tests. To learn more about
running integration tests in a browser, see the [Integration testing](/testing/integration-tests#test-in-a-web-browser)
page.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/building.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/building&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/building.md "Report an issue with this page").