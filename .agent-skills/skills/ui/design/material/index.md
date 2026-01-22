---
name: material-design-for-flutter
description: Learn about Material Design for Flutter.
metadata:
  url: https://docs.flutter.dev/ui/design/material
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Material Design for Flutter

Material Design is an open-source design system built
and supported by Google designers and developers.


The latest version, Material 3, enables personal,
adaptive, and expressive experiences—from dynamic color
and enhanced accessibility, to foundations for
large screen layouts, and design tokens.


warningWarning

As of the Flutter 3.16 release, **Material 3 is**
**enabled by default**. For now, you can opt out
of Material 3 by setting the [`useMaterial3`](https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html)
property
to `false`. But be aware that the `useMaterial3`
property and support for Material 2
will eventually be deprecated according to
Flutter's [deprecation policy](/release/compatibility-policy#deprecation-policy).


For _most_ Flutter widgets, upgrading to Material 3
is seamless. But _some_ widgets couldn't be
updated—entirely new implementations were needed,
such as [`NavigationBar`](https://api.flutter.dev/flutter/material/NavigationBar-class.html).
You must make these changes to your code manually.
Until your app is entirely updated,
the UI might look or act a bit strange.
You can find the entirely new Material components by
visiting the [Affected widgets](https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html#affected-widgets)
page.


Explore the updated components, typography, color system,
and elevation support with the
[Material 3 demo](https://github.com/flutter/samples/blob/main/material_3_demo/).


## More information

[#](#more-information)

To learn more about Material Design and Flutter,
check out:


- [Material.io developer documentation](https://m3.material.io/develop/flutter)
- [Migrating a Flutter app to Material 3](https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/)
   blog post by Taha Tesser

- [Umbrella issue on GitHub](https://github.com/flutter/flutter/issues/91605)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-22. [View source](https://github.com/flutter/website/blob/main/src/content/ui/design/material/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/design/material&page-source=https://github.com/flutter/website/blob/main/src/content/ui/design/material/index.md "Report an issue with this page").