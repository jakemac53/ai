---
name: devtools-2-17-0-release-notes
description: Release notes for Dart and Flutter DevTools version 2.17.0.
metadata:
  url: https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.17.0
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools 2.17.0 release notes

The 2.17.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).


## Inspector updates

[#](#inspector-updates)

- Added support for manually setting the package directories for your app.
   If you've ever loaded the Inspector and noticed that
   some of your widgets aren't present in the widget tree, this might
   indicate that the package directories for your app
   haven't been set or detected properly.
   Your package directories determine which widgets
   the Inspector considers to be from _your_ application.
   If you see an empty Inspector widget tree,
   or if you develop widgets across multiple packages,
   and want widgets from all these locations to show up in your tree,
   check the **Inspector Settings** dialog to ensure that your package
   directories are properly configured -
   [#4306](https://github.com/flutter/devtools/pull/4306)

  ![frame_analysis](/assets/images/docs/tools/devtools/release-notes/images-2.17.0/package_directories.png)


## Performance updates

[#](#performance-updates)

- Added a **Frame Analysis** tab to the Performance page.
   When analyzing a janky Flutter frame,
   this view provides hints for how to diagnose the jank and
   detects expensive operations that might have
   contributed to the slow frame time.
   This view also shows a breakdown of your Flutter frame time
   per phase ( **Build**, **Layout**, **Paint**, and
   **Raster**)
   to try to guide you in the right direction -
   [#4339](https://github.com/flutter/devtools/pull/4339)

  ![frame_analysis](/assets/images/docs/tools/devtools/release-notes/images-2.17.0/frame_analysis.png)


## Full commit history

[#](#full-commit-history)

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.16.0...v2.17.0).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.17.0.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/release-notes/release-notes-2.17.0&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/release-notes/release-notes-2.17.0.md "Report an issue with this page").