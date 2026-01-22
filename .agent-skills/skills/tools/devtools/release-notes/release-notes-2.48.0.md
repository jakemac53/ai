---
name: devtools-2-48-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.48.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.48.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.48.0 release notes

The 2.48.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools/overview).


## Network profiler updates

[#](#network-profiler-updates)

- Fixed network logging after a hot restart. -
   [#9271](https://github.com/flutter/devtools/pull/9271).


## Logging updates

[#](#logging-updates)

- Started displaying events related to timers in the Logging View. -
   [#9238](https://github.com/flutter/devtools/pull/9238).


## Advanced developer mode updates

[#](#advanced-developer-mode-updates)

- Added a Queued Microtasks tab to the VM Tools screen, which allows a user to
   see details about the microtasks scheduled in an isolate's microtask queue.
   This tab currently only appears when DevTools is connected to a Flutter or
   Dart app started with `--profile-microtasks`. -
   [#9239](https://github.com/flutter/devtools/pull/9239).


## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.48.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.48.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.48.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.48.0.md "Report an issue with this page").