---
name: ios-debugging
description: iOS-specific debugging techniques for Flutter apps
metadata:
  url: https://docs.flutter.dev/platform-integration/ios/ios-debugging
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# iOS debugging

Due to security around
[local network permissions in iOS 14 or later](https://developer.apple.com/news/?id=0oi77447),
you must accept a permission dialog box to enable
Flutter debugging functionalities such as hot-reload
and DevTools.


![Screenshot of &quot;allow network connections&quot; dialog](/assets/images/docs/development/device-connect.png)

This affects debug and profile builds only and won't
appear in release builds. You can also allow this
permission by enabling
**Settings > Privacy > Local Network > Your App**.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/ios-debugging.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/ios/ios-debugging&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/ios-debugging.md "Report an issue with this page").