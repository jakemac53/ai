---
name: devtools-2-30-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.30.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.30.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.30.0 release notes

The 2.30.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## Performance updates

[#](#performance-updates)

- Add an indicator of the rendering engine to the Flutter Frames chart. -
   [#6771](https://github.com/flutter/devtools/pull/6771)

  ![Flutter rendering engine text](/assets/images/docs/tools/devtools/release-notes/images-2.30.0/flutter_frames_engine_text.png)

- Improve messaging when we do not have analysis data available for a
   Flutter frame. - [#6768](https://github.com/flutter/devtools/pull/6768)


## VS Code Sidebar updates

[#](#vs-code-sidebar-updates)

- The Flutter Sidebar provided to VS Code now has the ability to enable new
   platforms if a device is available for a platform that is not enabled for
   the current project. This also requires a corresponding Dart extension for
   VS Code update to appear. - [#6688](https://github.com/flutter/devtools/pull/6688)

- The DevTools menu in the sidebar now has an entry "Open in Browser"
   that opens DevTools in an external browser window even when VS Code settings
   are set to usually use embedded DevTools. - [#6736](https://github.com/flutter/devtools/pull/6736)


## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.30.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.30.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.30.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.30.0.md "Report an issue with this page").