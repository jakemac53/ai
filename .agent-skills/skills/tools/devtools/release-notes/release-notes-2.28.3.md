---
name: devtools-2-28-3-release-notes
description: Release notes for Dart and Flutter DevTools version 2.28.3.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.28.3
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.28.3 release notes

The 2.28.3 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


This was a cherry-pick release on top of DevTools 2.28.2.
To learn about the improvements included in DevTools 2.28.2, please read the
[release notes](/tools/devtools/release-notes/release-notes-2.28.2).


## General updates

[#](#general-updates)

- Added a link to the new "Dive in to DevTools" YouTube
   [video](https://www.youtube.com/watch?v=_EYk-E29edo) in the bottom status bar.
   This video provides a brief tutorial for each DevTools screen.
   [#6554](https://github.com/flutter/devtools/pull/6554)

  ![Link to watch a DevTools tutorial video](/assets/images/docs/tools/devtools/release-notes/images-2.28.3/watch_tutorial_link.png)

- Added a workaround to fix copy button functionality in VSCode. - [#6598](https://github.com/flutter/devtools/pull/6598)


## Performance updates

[#](#performance-updates)

- Disable the Raster Stats tool for the Impeller backend
   since it is not supported. - [#6616](https://github.com/flutter/devtools/pull/6616)

## VS Code Sidebar updates

[#](#vs-code-sidebar-updates)

- When using VS Code with a light theme, the embedded sidebar provided by
   DevTools will now also show in the light theme. - [#6581](https://github.com/flutter/devtools/pull/6581)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.28.3).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.28.3.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.28.3&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.28.3.md "Report an issue with this page").