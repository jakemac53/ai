---
name: restore-state-on-ios
description: How to restore the state of your iOS app after it's been killed by the OS.
metadata:
  url: https://docs.flutter.dev/platform-integration/ios/restore-state-ios
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Restore state on iOS

When a user runs a mobile app and then selects another
app to run, the first app is moved to the background,
or _backgrounded_. The operating system (both iOS and Android)
often kills the backgrounded app to release memory or
improve performance for the app running in the foreground.


You can use the [`RestorationManager`](https://api.flutter.dev/flutter/services/RestorationManager-class.html)
(and related)
classes to handle state restoration.
An iOS app requires [a bit of extra setup](https://api.flutter.dev/flutter/services/RestorationManager-class.html#state-restoration-on-ios)
in Xcode,
but the restoration classes otherwise work the same on
both iOS and Android.


For more information, check out [State restoration on Android](/platform-integration/android/restore-state-android).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/restore-state-ios.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/ios/restore-state-ios&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/restore-state-ios.md "Report an issue with this page").