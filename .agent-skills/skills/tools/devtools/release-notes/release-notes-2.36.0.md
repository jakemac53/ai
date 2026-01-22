---
name: devtools-2-36-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.36.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.36.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.36.0 release notes

The 2.36.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](/tools/devtools).


## Performance updates

[#](#performance-updates)

- Added a feature for showing widget build counts.
   Enable this setting to see widget build counts for
   each Flutter frame in the "Frame Analysis" tool, or to see
   an aggregate summary of these counts in the new "Rebuild Stats" tool. -
   [#7838](https://github.com/flutter/devtools/pull/7838), [#7847](https://github.com/flutter/devtools/pull/7847)

  ![Track widget build counts setting](/assets/images/docs/tools/devtools/release-notes/images-2.36.0/track_build_counts_setting.png)

  ![Widget rebuild counts in the Frame Analysis view](/assets/images/docs/tools/devtools/release-notes/images-2.36.0/rebuild_counts_frame_analysis.png)

  ![Widget rebuild counts in the Rebuild Stats view](/assets/images/docs/tools/devtools/release-notes/images-2.36.0/rebuild_stats.png)


## Network profiler updates

[#](#network-profiler-updates)

- Added better support for narrow viewing windows, like when
   this screen is embedded in an IDE. - [#7726](https://github.com/flutter/devtools/pull/7726)

## Deep links tool updates

[#](#deep-links-tool-updates)

- Adds an error page to explain the issue when
   the tool fails to parse the project. - [#7767](https://github.com/flutter/devtools/pull/7767)

## DevTools Extension updates

[#](#devtools-extension-updates)

- Fixed an issue with detecting extensions for
   Dart or Flutter tests. - [#7717](https://github.com/flutter/devtools/pull/7717)
- Fixed an issue with detecting extensions for
   nested Dart or Flutter projects. - [#7742](https://github.com/flutter/devtools/pull/7742)
- Added an example to `package:devtools_extensions` that shows
   how to interact with the Dart Tooling Daemon from
   a DevTools extension. - [#7752](https://github.com/flutter/devtools/pull/7752)
- Fixed a DevTools routing bug related to
   disabling an extension. - [#7791](https://github.com/flutter/devtools/pull/7791)
- Fixed a bug causing a "Page Not Found" error when
   refreshing DevTools from an extension screen. - [#7822](https://github.com/flutter/devtools/pull/7822)
- Fixed a theming issue when extensions are
   embedded in an IDE - [#7824](https://github.com/flutter/devtools/pull/7824)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes in this release, check out the
[DevTools git log](https://github.com/flutter/devtools/tree/v2.36.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.36.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.36.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.36.0.md "Report an issue with this page").