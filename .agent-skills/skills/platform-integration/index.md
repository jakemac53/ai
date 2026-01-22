---
name: build-for-and-integrate-with-multiple-platforms
description: Learn how to develop for different platforms and integrate with platform-specific features in Flutter apps.
metadata:
  url: https://docs.flutter.dev/platform-integration
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Build for and integrate with multiple platforms

Flutter enables you to build, test, and deploy beautiful, natively compiled,
multi-platform applications from a single codebase.


## Overview

[#](#overview)

Flutter and its core packages often automatically support and integrate
with Flutter's officially [supported platforms](/reference/supported-platforms).
Some platforms require you to [set up additional tooling](#setup),
but once your development environment is set up,
Flutter apps are usually functional across platforms out of the box.


Occasionally you need to integrate with platform-specific functionality.
For example, you might want to use a native library that's
only available on iOS and iPadOS.
For many use cases, you can find and use one of the many [Flutter plugins](/packages-and-plugins/using-packages)

provided by the Flutter team and the amazing Flutter community.
If none of them meet your needs, you can
[write platform-specific code](/platform-integration/platform-channels)
and even [create your own plugin](/packages-and-plugins/developing-packages).


lightbulbTip

If you're exploring building your app for multiple platforms,
also consider building your UI with [adaptive and responsive design](/ui/adaptive-responsive/)
in mind.


## Set up platform development

[#](#setup)

While Flutter apps can be built for a variety of [supported platforms](/reference/supported-platforms)

with little to no modifications to your code,
your development environment might require additional setup
when targeting a new platform.


To set up development for an additional platform,
select the platform from the following:


[Target AndroidOn any device\
\
Set up your development environment to build Flutter apps for Android.](/platform-integration/android/setup) [Target iOSOn macOS only\
\
Set up your development environment to build Flutter apps for iOS.](/platform-integration/ios/setup) [Target WebOn any device\
\
Set up your development environment to build Flutter apps for the web.](/platform-integration/web/setup) [Target WindowsOn Windows only\
\
Set up your development environment to build Flutter apps for Windows.](/platform-integration/windows/setup) [Target macOSOn macOS only\
\
Set up your development environment to build Flutter apps for macOS.](/platform-integration/macos/setup) [Target LinuxOn Linux only\
\
Set up your development environment to build Flutter apps for Linux.](/platform-integration/linux/setup)

## Integrate with each platform

[#](#integrate)

If the situation you're trying to solve is not
covered by an existing [Flutter plugin](/packages-and-plugins/using-packages#searching-for-packages),
check out the following guides to learn how to
integrate with each of the supported platforms.


### Integrate with Android

[#](#android)

Learn how to add custom integrations with Android to your Flutter app.

[Add a splash screen\
\
Learn how to add a splash screen to your app on Android.](/platform-integration/android/splash-screen) [Support predictive back\
\
Learn how to add the predictive back gesture to your app on Android.](/platform-integration/android/predictive-back) [Call JetPack APIs\
\
Learn how the latest Android APIs in your app from Dart.](/platform-integration/android/call-jetpack-apis) [Bind to native code\
\
Learn how to bind to native C code from your app on Android.](/platform-integration/android/c-interop) [Embed an Android view\
\
Learn how to host native Android views in your app.](/platform-integration/android/platform-views) [Launch a Compose activity\
\
Learn how to launch a Jetpack Compose activity from your app.](/platform-integration/android/compose-activity)

### Integrate with iOS

[#](#ios)

Learn how to add custom integrations with iOS to your Flutter app.

[Add a launch screen\
\
Learn how to add a launch screen to your app on iOS.](/platform-integration/ios/launch-screen) [Leverage system frameworks\
\
Learn about plugins that support functionality from native iOS frameworks.](/platform-integration/ios/apple-frameworks) [Bind to native code\
\
Learn how to bind to native C, Objective-C, and Swift code from your app.](/platform-integration/ios/c-interop) [Embed an iOS view\
\
Learn how to host native iOS views in your app.](/platform-integration/ios/platform-views) [Add an app extension\
\
Learn how to add an iOS app extension to your app.](/platform-integration/ios/app-extensions) [Support new iOS features\
\
Learn about Flutter's support for new or upcoming iOS features.](/platform-integration/ios/ios-latest)

### Integrate with the web

[#](#web)

Learn how to add custom integrations with the
web platform to your Flutter app.


[Customize app initialization\
\
Customize how your Flutter app is initialized on the web.](/platform-integration/web/initialization) [Bind to native code\
\
Learn how to bind to native C code from your app on Android.](/platform-integration/android/c-interop) [Embed web content\
\
Learn how to embed native web content in your app.](/platform-integration/web/web-content-in-flutter) [Embed your app\
\
Learn how to embed your Flutter app in another web app.](/platform-integration/web/embedding-flutter-web) [Compile to WebAssembly\
\
Learn how to take advantage of WebAssembly in your Flutter web app.](/platform-integration/web/wasm/) [Interop with JavaScriptopen\_in\_new\
\
Learn how to integrate with JavaScript from your Dart code.](https://dart.dev/interop/js-interop)

### Integrate with Windows

[#](#windows)

Learn how to add custom integrations with Windows to your Flutter app.

[Bind to native code\
\
Learn how to bind to native C code from your app on Windows.](/platform-integration/windows/building/#integrating-with-windows) [Distribute your app\
\
Learn about different options for distributing your app on Windows.](/platform-integration/windows/building/#distributing-windows-apps) [Follow Windows UI conventions\
\
Learn different techniques to integrate with the Windows look and feel.](platform-integration/windows/building#supporting-windows-ui-guidelines)

### Integrate with macOS

[#](#macos)

Learn how to add custom integrations with macOS to your Flutter app.

[Bind to native code\
\
Learn how to bind to native C, Objective-C, and Swift code from your app.](/platform-integration/macos/c-interop) [Embed a macOS view\
\
Learn how to host native macOS views in your app.](/platform-integration/macos/platform-views) [Set up macOS entitlements\
\
Learn how to enable specific capabilities and services for your app.](/platform-integration/macos/building#entitlements-and-the-app-sandbox) [Integrate with the macOS visual style\
\
Learn different techniques to integrate with the macOS look and feel.](/platform-integration/macos/building#integrating-with-macos-look-and-feel)

### Integrate with Linux

[#](#linux)

Learn how to add custom integrations with Linux to your Flutter app.

[Bind to native code\
\
Learn how to use and bind to native Linux libraries and code.](/platform-integration/linux/building#integrate-with-linux) [Prepare for distribution\
\
Prepare your Flutter app for distributing to Linux users.](/platform-integration/linux/building#prepare-linux-apps-for-distribution) [Deploy to the Snap Store\
\
Learn how to deploy your Linux desktop app to the Snap Store.](/deployment/linux/)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-8. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/index.md "Report an issue with this page").