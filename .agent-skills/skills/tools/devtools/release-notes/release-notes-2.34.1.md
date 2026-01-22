---
name: devtools-2-34-1-release-notes
description: Release notes for Dart and Flutter DevTools version 2.34.1.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.34.1
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.34.1 release notes

The 2.34.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).


## General updates

[#](#general-updates)

- Fixed an issue preventing DevTools from connecting to Flutter apps that
   are not launched from Flutter Tools. - [#6848](https://github.com/flutter/devtools/issues/6848)
- Improved performance of the FlatTable. -
   [#7391](https://github.com/flutter/devtools/pull/7391)

## Inspector updates

[#](#inspector-updates)

- Fixes an edge case where widgets from other packages could
   show up in the inspector tree. - [#7353](https://github.com/flutter/devtools/pull/7353)

## Performance updates

[#](#performance-updates)

- Add a setting to include CPU samples in the Timeline. -
   [#7333](https://github.com/flutter/devtools/pull/7333), [#7369](https://github.com/flutter/devtools/pull/7369)

  ![Timeline settings](/assets/images/docs/tools/devtools/release-notes/images-2.34.1/7369-timeline-settings.png)

- Removed the legacy trace viewer.
   The legacy trace viewer was replaced with the
   embedded Perfetto trace viewer in DevTools version 2.21.1, but was
   available behind a setting to ensure a smooth rollout.
   This release of DevTools removes the legacy trace viewer entirely. - [#7316](https://github.com/flutter/devtools/pull/7316)

- Updated the Perfetto trace viewer build. -
   [#7445](https://github.com/flutter/devtools/pull/7445),
   [#7456](https://github.com/flutter/devtools/pull/7456),
   [#7480](https://github.com/flutter/devtools/pull/7480)

- Added a loading message to show when refreshing the timeline. - [#7463](https://github.com/flutter/devtools/pull/7463)

  ![Loading message](/assets/images/docs/tools/devtools/release-notes/images-2.34.1/7463-overlay.png)


## Memory updates

[#](#memory-updates)

- Enabled export of snapshots and improved snapshotting performance. -
   [#7197](https://github.com/flutter/devtools/pull/7197),
   [#7439](https://github.com/flutter/devtools/pull/7439),
   [#7449](https://github.com/flutter/devtools/pull/7449)

  ![Export snapshot](/assets/images/docs/tools/devtools/release-notes/images-2.34.1/7197-export.png)

- Fixed failures during disconnect in tracing. - [#7440](https://github.com/flutter/devtools/pull/7440)

- Made class filter shared between
   the panes `Profile Memory` and `Diff Snapshots`. \- [#7462](https://github.com/flutter/devtools/pull/7462)


## Network profiler updates

[#](#network-profiler-updates)

- Improved Network profiler performance. - [#7266](https://github.com/flutter/devtools/pull/7266)
- Fixed a bug where selected pending requests weren't
   refreshing the tab once updated. - [#7266](https://github.com/flutter/devtools/pull/7266)
- Fixed the JSON viewer so multiline strings are visible in their row, and
   through a tooltip. - [#7389](https://github.com/flutter/devtools/pull/7389)
- Fixed JsonViewer where all of the
   expanded sections would snap closed. [#7367](https://github.com/flutter/devtools/pull/7367)

## Deep Links tool updates

[#](#deep-links-tool-updates)

- Automatically populate a list of Flutter projects from
   the connected IDE. - [#7415](https://github.com/flutter/devtools/pull/7415),
   [#7431](https://github.com/flutter/devtools/pull/7431)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.34.1).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.34.1.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.34.1&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.34.1.md "Report an issue with this page").