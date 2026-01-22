---
name: devtools-2-38-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.38.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.38.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.38.0 release notes

The 2.38.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).


## Performance updates

[#](#performance-updates)

- Renamed the "Track" builds, paints, and layouts settings to "Trace"
   builds, paints, and layouts. - [#8084](https://github.com/flutter/devtools/pull/8084)
- Renamed the "Track widget build counts" setting to "Count widget builds". - [#8084](https://github.com/flutter/devtools/pull/8084)

## Debugger updates

[#](#debugger-updates)

- Added recommendation to debug code from an IDE, with links to IDE instructions. - [#8085](https://github.com/flutter/devtools/pull/8085)

## Network profiler updates

[#](#network-profiler-updates)

- Added support to export network requests as a HAR file (thanks to @hrajwade96!). - [#7970](https://github.com/flutter/devtools/pull/7970)

## DevTools Extension updates

[#](#devtools-extension-updates)

- Fixed an issue where extensions did not load with the proper theme when
   embedded in an IDE. - [#8034](https://github.com/flutter/devtools/pull/8034)
- Added an API for copying text to clipboard by proxy of the parent DevTools web app, which has
   workarounds for copy issues when embedded inside an IDE. - [#8130](https://github.com/flutter/devtools/pull/8130)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.38.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.38.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.38.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.38.0.md "Report an issue with this page").