---
name: devtools-2-19-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.19.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.19.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.19.0 release notes

The 2.19.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## Performance updates

[#](#performance-updates)

- Added a button to toggle the visibility of the Flutter Frames chart -
   [#4577](https://github.com/flutter/devtools/pull/4577)

  ![diff](/assets/images/docs/tools/devtools/release-notes/images-2.19.0/4577.png)

- Polish the debug mode warning to better describe which data is
   accurate in debug mode and which data may be misleading -
   [#3537](https://github.com/flutter/devtools/pull/3537)

- Reorder performance tool tabs and only show the CPU profiler
   for the "Timeline Events" tab -
   [#4629](https://github.com/flutter/devtools/pull/4629)


## Memory updates

[#](#memory-updates)

- Improvements to the memory Profile tab -
   [#4583](https://github.com/flutter/devtools/pull/4583)

## Debugger updates

[#](#debugger-updates)

- Fix an issue with hover cards where they were appearing
   but never disappearing -
   [#4627](https://github.com/flutter/devtools/pull/4627)
- Fix a bug with the file search autocomplete dialog -
   [#4409](https://github.com/flutter/devtools/pull/4409)

## Network profiler updates

[#](#network-profiler-updates)

- Added a "Copy" button in the Network Request view
   (thanks to @netos23) -
   [#4509](https://github.com/flutter/devtools/pull/4509)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.18.0...v2.19.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.19.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.19.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.19.0.md "Report an issue with this page").