---
name: devtools-2-9-2-release-notes
description: Release notes for Dart and Flutter DevTools version 2.9.2.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.9.2
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.9.2 release notes

The 2.9.2 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## General updates

[#](#general-updates)

- Take our 2022 DevTools survey! Provide your feedback and help us improve
   your development experience. This survey prompt will show up directly in
   DevTools sometime in mid-February.

  ![survey prompt](/assets/images/docs/tools/devtools/release-notes/images-2.9.2/image1.png)

  _Note_: If you are having issues launching the survey, please make
   sure you have upgraded to the latest Flutter stable branch 2.10.
   There was a bug in DevTools (fixed in
   [#3574](https://github.com/flutter/devtools/pull/3574)) that
   prevented the survey from being able to be opened, and unless you
   are on Flutter 2.10, this bug will still be present.\_

- General bug fixes and improvements -
   [#3528](https://github.com/flutter/devtools/pull/3528),
   [#3531](https://github.com/flutter/devtools/pull/3531),
   [#3532](https://github.com/flutter/devtools/pull/3532),
   [#3539](https://github.com/flutter/devtools/pull/3539)


## Performance updates

[#](#performance-updates)

- Added frame numbers to x-axis the Flutter frames chart -
   [#3526](https://github.com/flutter/devtools/pull/3526)

  ![frame numbers](/assets/images/docs/tools/devtools/release-notes/images-2.9.2/image2.png)


## Debugger updates

[#](#debugger-updates)

- Fix a bug where the File Explorer in the Debugger did not show contents
   after a hot restart -
   [#3527](https://github.com/flutter/devtools/pull/3527)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.9.1...v2.9.2).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.9.2.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.9.2&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.9.2.md "Report an issue with this page").