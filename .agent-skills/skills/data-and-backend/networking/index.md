---
name: networking
description: Internet network calls in Flutter.
metadata:
  url: https://docs.flutter.dev/data-and-backend/networking#macos
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Networking

## Cross-platform http networking

[#](#cross-platform-http-networking)

The [`http`](https://pub.dev/packages/http) package provides the simplest way to issue http requests. This
package is supported on Android, iOS, macOS, Windows, Linux and the web.


## Platform notes

[#](#platform-notes)

Some platforms require additional steps, as detailed below.

### Android

[#](#android)

Android apps must [declare their use of the internet](https://developer.android.com/training/basics/network-ops/connecting)
in the Android
manifest ( `AndroidManifest.xml`):


xml

```
<manifest xmlns:android...>
 ...
 <uses-permission android:name="android.permission.INTERNET" />
 <application ...
</manifest>

```

content\_copy

### macOS

[#](#macos)

macOS apps must allow network access in the relevant `*.entitlements` files.

xml

```
<key>com.apple.security.network.client</key>
<true/>

```

content\_copy

Learn more about [setting up entitlements](/platform-integration/macos/building#setting-up-entitlements).


## Samples

[#](#samples)

For a practical sample of various networking tasks (incl. fetching data,
WebSockets, and parsing data in the background) see the
[networking cookbook recipes](/cookbook/networking).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/data-and-backend/networking.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/data-and-backend/networking&page-source=https://github.com/flutter/website/blob/main/src/content/data-and-backend/networking.md "Report an issue with this page").