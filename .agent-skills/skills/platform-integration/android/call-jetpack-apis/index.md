---
name: calling-jetpack-apis
description: Use the latest Android APIs from your Dart code
metadata:
  url: https://docs.flutter.dev/platform-integration/android/call-jetpack-apis
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Calling JetPack APIs

Flutter apps running on Android can always make use of the
latest APIs on the first day they are released on Android, no
matter what. This page outlines available ways to invoke
Android-specific APIs.


## Use an existing solution

[#](#use-an-existing-solution)

In most scenarios, you can use a plugin (as shown in the next section)
to invoke native APIs without writing any custom boilerplate or
glue code yourself.


### Use a plugin

[#](#use-a-plugin)

Using a plugin is often the easiest way to access native
APIs, regardless of where your Flutter app is running. To
use plugins, visit [pub.dev](https://pub.dev) and search for
the topic you need. Most native features, including accessing
common hardware like GPS, the camera, or step counters are
supported by robust plugins.


For complete guidance on adding plugins to your Flutter app,
see the [Using packages documentation](/packages-and-plugins/using-packages).


Not all native features are supported by plugins, especially
immediately after their release. In any scenario where
your desired native feature is not covered by a package on
[pub.dev](https://pub.dev), continue on to the following sections.


## Creating a custom solution

[#](#creating-a-custom-solution)

Not all scenarios and APIs will be supported by
existing solutions; but luckily, you can always add whatever
support you need. The next sections describe two different
ways to call native code from Dart.


infoNote

Neither solution below is inherently better or worse than
existing plugins, because all plugins use one of the following
two options.


### Call native code directly via FFI

[#](#call-native-code-directly-via-ffi)

The most direct and efficient way to invoke native APIs is by
calling the API directly, via FFI. This links your Dart executable
to any specified native code at compile-time, allowing you to
call it directly from the UI thread through a small amount of glue
code. In most cases, [ffigen](https://pub.dev/packages/ffigen) or [jnigen](https://pub.dev/packages/jnigen)
are
helpful in writing this glue code.


For complete guidance on directly calling native code from
your Flutter app, see the [FFI documentation](https://dart.dev/interop/c-interop).


In the coming months, the Dart team hopes to make this process
easier with direct support for calling native APIs using the
FFI approach, but without any need for the developer to write
glue code.


### Add a MethodChannel

[#](#add-a-methodchannel)

[`MethodChannel`](https://api.flutter.dev/flutter/services/MethodChannel-class.html) s are an alternate
way Flutter apps can invoke arbitrary native code.
Unlike the FFI solution described in the previous step,
MethodChannels are always asynchronous, which
might or might not matter to you, depending on your use case. As
with FFI and direct calls to native code, using a `MethodChannel`
requires a small amount of glue code to translate your Dart objects
into native objects, and then back again. In most cases,
[`pkg:pigeon`](https://pub.dev/packages/pigeon) is helpful in writing this glue code.


For complete guidance on adding MethodChannels to your Flutter
app, see the [`MethodChannel` s documentation](/platform-integration/platform-channels).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/android/call-jetpack-apis.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/android/call-jetpack-apis&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/android/call-jetpack-apis.md "Report an issue with this page").