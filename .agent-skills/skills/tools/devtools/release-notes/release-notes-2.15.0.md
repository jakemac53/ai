---
name: devtools-2-15-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.15.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.15.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.15.0 release notes

The 2.15.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## General updates

[#](#general-updates)

- The DevTools 2.15 release includes improvements to all tables in
   DevTools (logging view, network profiler, CPU profiler, and so on) -
   [#4175](https://github.com/flutter/devtools/pull/4175)

## Performance updates

[#](#performance-updates)

- Added outlines to each layer displayed in the Raster Metrics tool -
   [#4192](https://github.com/flutter/devtools/pull/4192)

  ![raster-metrics-layer-outlines](/assets/images/docs/tools/devtools/release-notes/images-2.15.0/image1.png)

- Fix a bug with loading offline data -
   [#4189](https://github.com/flutter/devtools/pull/4189)


## Network updates

[#](#network-updates)

- Added a Json viewer with syntax highlighting for network responses -
   [#4167](https://github.com/flutter/devtools/pull/4167)

  ![network-response-json-viewer](/assets/images/docs/tools/devtools/release-notes/images-2.15.0/image2.png)

- Added the ability to copy network responses -
   [#4190](https://github.com/flutter/devtools/pull/4190)


## Memory updates

[#](#memory-updates)

- Added the ability to select a different isolate from the DevTools footer -
   [#4173](https://github.com/flutter/devtools/pull/4173)
- Made the automatic snapshotting feature a configurable setting -
   [#4200](https://github.com/flutter/devtools/pull/4200)

## CPU profiler

[#](#cpu-profiler)

- Stop manually truncating source URIs in the profiler tables -
   [#4166](https://github.com/flutter/devtools/pull/4166)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.14.0...v2.15.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.15.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.15.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.15.0.md "Report an issue with this page").