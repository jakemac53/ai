---
name: external-windows-in-flutter-windows-apps
description: Special considerations for adding external windows to Flutter apps
metadata:
  url: https://docs.flutter.dev/platform-integration/windows/extern_win
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# External windows in Flutter Windows apps

# Windows lifecycle

## Who is affected

[#](#who-is-affected)

Windows applications built against Flutter versions after 3.13 that open non-Flutter windows.

## Overview

[#](#overview)

When adding a non-Flutter window to a Flutter Windows app, it will not be part
of the logic for application lifecycle state updates by default. For example,
this means that when the external window is shown or hidden, the app lifecycle
state will not appropriately update to inactive or hidden. As a result, the app
might receive incorrect lifecycle state changes through
[WidgetsBindingObserver.didChangeAppLifecycle](https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver/didChangeAppLifecycleState.html).


# What do I need to do?

To add the external window to this application logic,
the window's `WndProc` procedure
must invoke `FlutterEngine::ProcessExternalWindowMessage`.


To achieve this, add the following code to a window message handler function:

cpp

```
LRESULT Window::Messagehandler(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam) {
    std::optional<LRESULT> result = flutter_controller_->engine()->ProcessExternalWindowMessage(hwnd, msg, wparam, lparam);
    if (result.has_value()) {
        return *result;
    }
    // Original contents of WndProc...
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2024-11-20. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/windows/extern_win.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/windows/extern_win&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/windows/extern_win.md "Report an issue with this page").