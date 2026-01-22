---
name: devtools-2-42-3-release-notes
description: Release notes for Dart and Flutter DevTools version 2.42.3.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.42.3
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.42.3 release notes

The 2.42.3 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).


## General updates

[#](#general-updates)

- Added "View licenses" shortcut to the About dialog. - [#8610](https://github.com/flutter/devtools/pull/8610)

- Lower the wasm optimization level to resolve crashes on the dart2wasm build. - [#8814](https://github.com/flutter/devtools/pull/8814)


## Inspector updates

[#](#inspector-updates)

- Enabled the new inspector by default. This can be disabled in the inspector settings. - [#8650](https://github.com/flutter/devtools/pull/8650)![Legacy inspector setting](/assets/images/docs/tools/devtools/release-notes/images-2.42.3/legacy_inspector_setting.png)
- Fixed an issue where selecting an implementation widget on the device while implementation widgets were hidden in the
   [new inspector](https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.40.1#inspector-updates)
   showed an error. - [#8625](https://github.com/flutter/devtools/pull/8625)
- Enabled auto-refreshes of the widget tree on hot-reloads and navigation events by default. This can be disabled in the inspector settings. -
   [#8646](https://github.com/flutter/devtools/pull/8646)![Auto-refresh setting](/assets/images/docs/tools/devtools/release-notes/images-2.42.3/inspector_auto_refresh_setting.png)

## Network profiler updates

[#](#network-profiler-updates)

- Fixed an issue where the HTTP requests would sometimes not be displayed properly, particularly when DevTools is communicating
   with an application over a slow network connection. - [#8860](https://github.com/flutter/devtools/pull/8860)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.42.3).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.42.3.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.42.3&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.42.3.md "Report an issue with this page").