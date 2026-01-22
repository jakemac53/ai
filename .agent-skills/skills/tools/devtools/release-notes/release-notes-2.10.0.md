---
name: devtools-2-10-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.10.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.10.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.10.0 release notes

The 2.10.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## Flutter inspector updates

[#](#flutter-inspector-updates)

- Added search support to the Widget Tree, and
   added a breadcrumb navigator to the Widget Details Tree to
   allow for quickly navigating through the tree hierarchy -
   [#3525](https://github.com/flutter/devtools/pull/3525)

  ![inspector search](/assets/images/docs/tools/devtools/release-notes/images-2.10.0/image1.png)


## CPU profiler updates

[#](#cpu-profiler-updates)

- Fix a null reference in the CPU profiler
   when loading an offline snapshot -
   [#3596](https://github.com/flutter/devtools/pull/3596)

## Debugger updates

[#](#debugger-updates)

- Added support for multi-token file search, and
   improved search match prioritization to
   rank file name matches over full path matches -
   [#3582](https://github.com/flutter/devtools/pull/3582)
- Fix some focus-related issues -
   [#3602](https://github.com/flutter/devtools/pull/3602)

## Logging view updates

[#](#logging-view-updates)

- Fix a fatal error that occurred when
   filtering logs more than once -
   [#3588](https://github.com/flutter/devtools/pull/3588)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.9.2...v2.10.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.10.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.10.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.10.0.md "Report an issue with this page").