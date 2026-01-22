---
name: devtools-2-13-1-release-notes
description: Release notes for Dart and Flutter DevTools version 2.13.1.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.13.1
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.13.1 release notes

The 2.13.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## General updates

[#](#general-updates)

- This release included a lot of cleanup and reduction in technical debt.
   The most notable is the completion of our migration to sound null safety.

- Show release notes in IDE embedded versions of DevTools -
   [#4053](https://github.com/flutter/devtools/pull/4053)
- Polish to the DevTools footer -
   [#3989](https://github.com/flutter/devtools/pull/3989),
   [#4026](https://github.com/flutter/devtools/pull/4026),
   [#4041](https://github.com/flutter/devtools/pull/4041),
   [#4076](https://github.com/flutter/devtools/pull/4076)

## Performance updates

[#](#performance-updates)

- Added a new feature to help you debug raster jank in your Flutter app.
   This feature allows you to take a snapshot of the
   current screen shown in your app, and then
   break down rendering time for that scene by layer.
   This can help you identify parts of a scene that are expensive to rasterize -
   [#4046](https://github.com/flutter/devtools/pull/4046)

  ![raster-metrics-feature](/assets/images/docs/tools/devtools/release-notes/images-2.13.1/image1.png)

- Added a scope setting for "Track Widget Builds", allowing
   you to specify whether widget builds should be tracked in
   your code only or in all code -
   [#4010](https://github.com/flutter/devtools/pull/4010)

  ![track-widget-builds-scope-setting](/assets/images/docs/tools/devtools/release-notes/images-2.13.1/image2.png)


## CPU profiler updates

[#](#cpu-profiler-updates)

- Use package uris instead of file uris in the CPU profiler "Source" column -
   [#3932](https://github.com/flutter/devtools/pull/3932)

## Debugger updates

[#](#debugger-updates)

- Fix scrolling bug with debugger breakpoints -
   [#4074](https://github.com/flutter/devtools/pull/4074)

## Flutter inspector updates

[#](#flutter-inspector-updates)

- Add support for displaying flex values larger than 5 in the Layout Explorer -
   [#4055](https://github.com/flutter/devtools/pull/4055)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.12.2...v2.13.1).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.13.1.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.13.1&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.13.1.md "Report an issue with this page").