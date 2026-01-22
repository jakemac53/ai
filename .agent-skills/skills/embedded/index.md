---
name: embedded-support-for-flutter
description: Details of how Flutter supports the creation of embedded experiences.
metadata:
  url: https://docs.flutter.dev/embedded
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Embedded support for Flutter

If you would like to embed Flutter engine into a car,
a refrigerator, a thermostat... you CAN! For example,
you might embed Flutter in the following situations:


- Using Flutter on an "embedded device",
   typically a low-powered hardware device
   such as a smart-display, a thermostat, or similar.

- Embedding Flutter into a new operating system or
   environment, for example a new mobile platform
   or a new operating system.


The ability to embed Flutter, while stable,
uses low-level API and is _not_ for beginners.
In addition to the resources listed below, you
might consider joining [Discord](https://discord.com/invite/N7Yshp4), where Flutter
developers (including Google engineers) discuss
various aspects of Flutter. The Flutter
[community](https://flutter.dev/community) page has info on more community
resources.


- [Custom Flutter Engine Embedders](https://github.com/flutter/flutter/blob/main/docs/engine/Custom-Flutter-Engine-Embedders.md), on the Flutter wiki.

- The doc comments in the
   [Flutter engine `embedder.h` file](https://github.com/flutter/flutter/blob/main/engine/src/flutter/shell/platform/embedder/embedder.h)
   on GitHub.

- The [Flutter architectural overview](/resources/architectural-overview) on docs.flutter.dev.

- A small, self-contained [Flutter Embedder Engine GLFW example](https://github.com/flutter/flutter/tree/main/engine/src/flutter/examples/glfw#flutter-embedder-engine-glfw-example)

   in the Flutter engine GitHub repo.

- An exploration into [embedding Flutter in a terminal](https://github.com/jiahaog/flt) by
   implementing Flutter's custom embedder API.

- [Issue 31043](https://github.com/flutter/flutter/issues/31043): _Questions for porting flutter engine to_
  _a new os_ might also be helpful.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/embedded/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/embedded&page-source=https://github.com/flutter/website/blob/main/src/content/embedded/index.md "Report an issue with this page").