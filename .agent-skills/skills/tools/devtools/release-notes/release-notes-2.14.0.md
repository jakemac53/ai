---
name: devtools-2-14-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.14.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.14.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.14.0 release notes

The 2.14.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## General updates

[#](#general-updates)

- Added a link to the new DevTools
   [Discord channel](https://discord.com/channels/608014603317936148/958862085297672282)

   in the About DevTools dialog -
   [#4102](https://github.com/flutter/devtools/pull/4102)

  ![about-devtools](/assets/images/docs/tools/devtools/release-notes/images-2.14.0/image1.png)


## Network updates

[#](#network-updates)

- Added "Copy as URL" and "Copy as cURL" actions for
   selected requests in the network profiler
   (special thanks to [@jankuss](https://github.com/jankuss)!) -
   [#4113](https://github.com/flutter/devtools/pull/4113)

  ![network-request-copy-actions](/assets/images/docs/tools/devtools/release-notes/images-2.14.0/image2.png)


## Flutter inspector updates

[#](#flutter-inspector-updates)

- Added a setting to control whether hovering over a widget
   in the inspector displays its properties and values in a hover card -
   [#4090](https://github.com/flutter/devtools/pull/4090)

## Debugger updates

[#](#debugger-updates)

- Added auto complete suggestions in the console
   (special thanks to [@jankuss](https://github.com/jankuss)!) -
   [#4062](https://github.com/flutter/devtools/pull/4062)

  ![auto-complete-suggestions](/assets/images/docs/tools/devtools/release-notes/images-2.14.0/image3.png)

- Added the option to copy the full file path for a selected library -
   [#4147](https://github.com/flutter/devtools/pull/4147)

- Fixed formatting in the debugger exception menu -
   [#4066](https://github.com/flutter/devtools/pull/4066)


## Memory updates

[#](#memory-updates)

- Fixed formatting for memory values in the heap tree view -
   [#4153](https://github.com/flutter/devtools/pull/4153)
- Fixed a bug that was preventing GC events from
   showing up in the memory chart -
   [#4131](https://github.com/flutter/devtools/pull/4131)

## Performance updates

[#](#performance-updates)

- Warn users that the rendering layer toggles in the
   "More Debugging Options" menu are not available for profile mode apps -
   [#4075](https://github.com/flutter/devtools/pull/4075)

## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.13.1...v2.14.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.14.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.14.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.14.0.md "Report an issue with this page").