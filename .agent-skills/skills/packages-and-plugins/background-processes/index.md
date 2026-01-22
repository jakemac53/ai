---
name: background-processes
description: Where to find more information on implementing background processes in Flutter.
metadata:
  url: https://docs.flutter.dev/packages-and-plugins/background-processes
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Background processes

Have you ever wanted to execute Dart code in the
background—even if your app wasn't the currently active app?
Perhaps you wanted to implement a process that watches the time,
or that catches camera movement.
In Flutter, you can execute Dart code in the background.


The mechanism for this feature involves setting up an isolate.
_Isolates_ are Dart's model for multithreading,
though an isolate differs from a conventional thread
in that it doesn't share memory with the main program.
You'll set up your isolate for background execution using
callbacks and a callback dispatcher.


Additionally, the [WorkManager](https://pub.dev/packages/workmanager) plugin enables persistent background processing
that keeps tasks scheduled through app restarts and system reboots.


For more information and a geofencing example that uses background
execution of Dart code, see the Medium article by Ben Konyi,
[Executing Dart in the Background with Flutter Plugins and\
Geofencing](https://blog.flutter.dev/executing-dart-in-the-background-with-flutter-plugins-and-geofencing-2b3e40a1a124). At the end of this article,
you'll find links to example code, and relevant documentation for Dart,
iOS, and Android.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/packages-and-plugins/background-processes.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/packages-and-plugins/background-processes&page-source=https://github.com/flutter/website/blob/main/src/content/packages-and-plugins/background-processes.md "Report an issue with this page").