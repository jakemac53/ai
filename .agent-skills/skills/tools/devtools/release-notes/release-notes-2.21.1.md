---
name: devtools-2-21-1-release-notes
description: Release notes for Dart and Flutter DevTools version 2.21.1.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.21.1
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.21.1 release notes

The 2.21.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## Performance updates

[#](#performance-updates)

- Replace the DevTools timeline trace viewer with
   the [Perfetto](https://perfetto.dev/) trace viewer -
   [#5142](https://github.com/flutter/devtools/pull/5142)

  ![perfetto trace viewer](/assets/images/docs/tools/devtools/release-notes/images-2.21.1/image1.png)

- Fix several issues with loading a Performance snapshot into DevTools -
   [#5048](https://github.com/flutter/devtools/pull/5048),
   [#4929](https://github.com/flutter/devtools/pull/4929)

- UI polish and cleanup - [#4889](https://github.com/flutter/devtools/pull/4889)


## Memory updates

[#](#memory-updates)

- Improve usability of snapshot diffing -
   [#5015](https://github.com/flutter/devtools/pull/5015)
- UI polish and cleanup -
   [#4855](https://github.com/flutter/devtools/pull/4855)
- Color code classes based on where they are defined
   (SDK, your package, dependencies, etc.) -
   [#5030](https://github.com/flutter/devtools/pull/5030)
- Fix state management issue for tracing -
   [#5062](https://github.com/flutter/devtools/pull/5062)
- Improve the performance of taking a heap snapshot -
   [#5134](https://github.com/flutter/devtools/pull/5134)
- Retire broken import/export feature -
   [#5135](https://github.com/flutter/devtools/pull/5135)

## Debugger updates

[#](#debugger-updates)

- Added support for viewing profiler hits in
   the debugger script viewer -
   [#4831](https://github.com/flutter/devtools/pull/4831)
- Added support for inspecting records -
   [#5084](https://github.com/flutter/devtools/pull/5084)

## General updates

[#](#general-updates)

- Fix several issues in syntax highlighting that would
   color variable names that contain reserved words incorrectly and
   leave `extends`/ `implements` clauses uncolored for some classes -
   [#4948](https://github.com/flutter/devtools/pull/4948)
- Fix an issue in Safari, and
   other browsers that do not support RegExp negative lookbehind,
   that prevented DevTools from loading -
   [#4938](https://github.com/flutter/devtools/pull/4938)
- Fix an issue that would prevent DevTools connecting to
   the backend server that would disable some functionality -
   [#5016](https://github.com/flutter/devtools/pull/5016)
- Add a link to the DevTools
   [contribution guide](https://github.com/flutter/devtools/blob/master/CONTRIBUTING.md)

   to the About menu, and fixed the Discord link -
   [#4926](https://github.com/flutter/devtools/pull/4926)
- Fix conflicting colors in light theme -
   [#5067](https://github.com/flutter/devtools/pull/5067)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.20.0...v2.21.1).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.21.1.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.21.1&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.21.1.md "Report an issue with this page").