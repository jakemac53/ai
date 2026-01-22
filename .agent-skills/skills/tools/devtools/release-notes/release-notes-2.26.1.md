---
name: devtools-2-26-1-release-notes
description: Release notes for Dart and Flutter DevTools version 2.26.1.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.26.1
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.26.1 release notes

The 2.26.1 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## General updates

[#](#general-updates)

- Added a new "Home" screen in DevTools that either shows the "Connect" dialog
   or a summary of your connected app, depending on
   the connection status in DevTools.
   Keep an eye on this screen for cool new features in the future.
   This change also enables support for static tooling
   (tools that don't require a connected app) in DevTools -
   [#6010](https://github.com/flutter/devtools/pull/6010)

  ![home screen](/assets/images/docs/tools/devtools/release-notes/images-2.26.1/home_screen.png)

- Fixed overlay notifications so that they
   cover the area that their background blocks -
   [#5975](https://github.com/flutter/devtools/pull/5975)


## Memory updates

[#](#memory-updates)

- Added a context menu to rename or delete a heap snapshot from the list -
   [#5997](https://github.com/flutter/devtools/pull/5997)
- Warn users when HTTP logging may be affecting their app's memory consumption -
   [#5998](https://github.com/flutter/devtools/pull/5998)

## Debugger updates

[#](#debugger-updates)

- Improvements to text selection and copy behavior in
   the code view, console, and variables windows -
   [#6020](https://github.com/flutter/devtools/pull/6020)

## Network profiler updates

[#](#network-profiler-updates)

- Added a selector to customize the display type
   of text and json responses (thanks to @hhacker1999!) -
   [#5816](https://github.com/flutter/devtools/pull/5816)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.25.0...v2.26.1).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.26.1.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.26.1&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.26.1.md "Report an issue with this page").