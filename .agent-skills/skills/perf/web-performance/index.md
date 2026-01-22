---
name: debug-performance-for-web-apps
description: Learn how to use Chrome DevTools to debug web performance issues.
metadata:
  url: https://docs.flutter.dev/perf/web-performance
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Debug performance for web apps

infoNote

Profiling Flutter web apps requires Flutter version 3.14 or later.

The Flutter framework emits timeline events as it works to build frames,
draw scenes, and track other activity such as garbage collections.
These events are exposed in the
[Chrome DevTools performance panel](https://developer.chrome.com/docs/devtools/performance)
for debugging.


infoNote

For information on how to optimize web loading speed,
check out the (free) article on Medium,
[Best practices for optimizing Flutter web loading speed](https://blog.flutter.dev/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c).


You can also emit your own timeline events using the `dart:developer` [Timeline](https://api.flutter.dev/flutter/dart-developer/Timeline-class.html)
and [TimelineTask](https://api.flutter.dev/flutter/dart-developer/TimelineTask-class.html)
APIs for further performance analysis.


![Screenshot of the Chrome DevTools performance panel](/assets/images/docs/tools/devtools/chrome-devtools-performance-panel.png)

## Optional flags to enhance tracing

[#](#optional-flags-to-enhance-tracing)

To configure which timeline events are tracked, set any of the following top-level properties to `true`

in your app's `main` method.


- [debugProfileBuildsEnabled](https://api.flutter.dev/flutter/widgets/debugProfileBuildsEnabled.html): Adds
   `Timeline` events for every `Widget` built.

- [debugProfileBuildsEnabledUserWidgets](https://api.flutter.dev/flutter/widgets/debugProfileBuildsEnabledUserWidgets.html): Adds
   `Timeline` events for every user-created `Widget` built.

- [debugProfileLayoutsEnabled](https://api.flutter.dev/flutter/rendering/debugProfileLayoutsEnabled.html): Adds
   `Timeline` events for every `RenderObject` layout.

- [debugProfilePaintsEnabled](https://api.flutter.dev/flutter/rendering/debugProfilePaintsEnabled.html): Adds
   `Timeline` events for every `RenderObject` painted.


## Instructions

[#](#instructions)

1. _\[Optional\]_ Set any desired tracing flags to true from your app's main method.
2. Run your Flutter web app in [profile mode](/testing/build-modes#profile).
3. Open up the [Chrome DevTools Performance panel](https://developer.chrome.com/docs/devtools/performance)
    for your application,
    and [start recording](https://developer.chrome.com/docs/devtools/performance/#record)
    to capture timeline events.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/perf/web-performance.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/perf/web-performance&page-source=https://github.com/flutter/website/blob/main/src/content/perf/web-performance.md "Report an issue with this page").