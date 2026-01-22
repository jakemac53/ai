---
name: glossary
description: A glossary reference for terminology used across docs.flutter.dev.
metadata:
  url: https://docs.flutter.dev/resources/glossary#widget
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Glossary

The following are definitions of terms used across the Flutter documentation.

search

## Adaptive

[tag](#adaptive "Link to card") keyboard\_arrow\_up

A design concept where the UI adapts to be usable in the available space,
often changing layout or input methods based on device capabilities.


Adaptive design is about the UI being _usable_ in the space,
as opposed to responsive design which is about fitting the UI _into_
the space.
An adaptive app selects the appropriate layout
(such as having a bottom nav instead of a side panel)
and input devices (for example, mouse versus touch)
to feel natural on the current device.


### Related docs and resources

- [articleAdaptive vs responsive design](/ui/adaptive-responsive#what-is-responsive-vs-adaptive)
- [articleBuilding adaptive apps](/ui/adaptive-responsive)

## Dart

[tag](#dart "Link to card") keyboard\_arrow\_up

A programming language for fast apps on any platform.

Dart is an approachable, portable, and performant language designed
for full-stack app development. It offers sound null safety,
a strong type system, and compiles to native machine code
for mobile, desktop, and backend, as well as JavaScript or WebAssembly
for the web. While Dart is the foundation of Flutter,
it is also used for building command-line tools, servers,
and other applications.


### Related docs and resources

- [open\_in\_newDart language site](https://dart.dev)

## Embedder

[tag](#embedder "Link to card") keyboard\_arrow\_up

The platform-specific component that supports Flutter
on a native platform.


Each native platform supported by Flutter has an _embedder_
for platform-specific logic. The embedder is the bridge
that coordinates with the underlying operating system.
It provides access to services like input, accessibility,
message event loops, and more.
The embedder also launches and manages the Flutter engine.


Each embedder is written in the platform's native language:
Java and Kotlin for Android, Swift and Objective-C for iOS and macOS,
and C++ for Windows and Linux.


Each embedder enables plugin packages to add additional
platform-specific functionality to the app.


The embedder is launched and managed by the runner app.

### Related docs and resources

- [articleArchitectural overview: The Embedder](/resources/architectural-overview#platform-embedding)
- [articleFlutter on embedded devices](/embedded)

## Engine

[tag](#engine "Link to card") keyboard\_arrow\_up

The portable runtime for Flutter apps.

The engine is Flutter's platform-agnostic logic that's written
in native code, mostly C++.


The main responsibilities of the engine are as follows:

1. Exposes the `dart:ui` API, which are the low-level primitives
    that the Flutter [framework](/resources/architectural-overview#architectural-layers)
    builds upon.

2. Converts low-level drawing commands into pixels (also called
    _rasterization_, this includes [Impeller](/resources/glossary#impeller)ImpellerFlutter's modern graphics rendering engine,
designed for smooth, predictable performance. [Learn more](/resources/glossary#impeller "Learn more about 'Impeller' and find related resources.")
    and Skia).

3. Responsible for launching and managing Dart's runtime.
4. Responsible for laying out text.
5. Responsible for asset resolution.

### Related docs and resources

- [articleArchitectural overview: The Engine](/resources/architectural-overview#architectural-layers)
- [code\_blocksEngine repository](https://github.com/flutter/flutter/tree/main/engine/src/flutter)

## Frame

[tag](#frame "Link to card") keyboard\_arrow\_up

A single image in a sequence of images that
makes up an animation or UI update.


Flutter aims to produce 60 frames per second (fps),
or 120 fps on capable devices.
This means the framework has approximately 16ms (at 60 fps)
or 8ms (at 120 fps) to render each frame.
If the app takes longer than this to render a frame,
the user might see [jank](/resources/glossary#jank)JankWhen an app appears to stutter or jerk visually instead of animating
smoothly. [Learn more](/resources/glossary#jank "Learn more about 'Jank' and find related resources.").


### Related docs and resources

- [articleRendering performance](/perf/rendering-performance)

## Hot reload

[tag](#hot-reload "Link to card") keyboard\_arrow\_up

A Flutter feature that allows you to inject updated code into
a running application in the Dart VM and see the changes immediately
while maintaining application state.


This feature is also called "stateful hot reload".
After the Dart runtime updates classes with the new versions
of fields and functions, the Flutter framework automatically
rebuilds the widget tree, allowing you to quickly view the effects
of your changes. Hot reload greatly increases the speed of development.


Hot reload works on mobile, web, and desktop apps that are
running in debug mode and is fully supported in VS Code,
Android Studio, and IntelliJ IDEA. It does not re-run `main` or
`initState`; for that, use [hot restart](/resources/glossary#hot-restart)Hot restartSimilar to hot reload, but it does not maintain app state.
Use hot restart to re-run \`main\` or \`initState\`. [Learn more](/resources/glossary#hot-restart "Learn more about 'Hot restart' and find related resources.").


### Related docs and resources

- [articleHot reload documentation](/tools/hot-reload)
- [play\_arrowFast development cycles with Flutter's hot reload](https://youtu.be/YScJS8obxlo?si=QxJDIf_LGmle2Xs6)
- [play\_arrowStateful hot reload for web is here](https://youtu.be/7nT3BHm6Gyg?si=nLUM0n69PSQnm8CF)

## Hot restart

[tag](#hot-restart "Link to card") keyboard\_arrow\_up

Similar to hot reload, but it does not maintain app state.
Use hot restart to re-run
`main`
or
`initState`
.


Hot restart is still faster than a full restart, which also
recompiles the native, platform code (such as Swift).
On the web, it also restarts the Dart Development Compiler (DDC).


### Related docs and resources

- [articleDifference between hot reload, hot restart, and full restart](/tools/hot-reload#hot-restart)

## Impeller

[tag](#impeller "Link to card") keyboard\_arrow\_up

Flutter's modern graphics rendering engine,
designed for smooth, predictable performance.


_Impeller_ is Flutter's high-performance rendering engine,
built from the ground up for Flutter's needs and modern graphics APIs.


Its primary goal is to provide consistently smooth performance and
eliminate stuttering while rendering, particularly that
caused by shader compilation during animations and interactions.


Impeller achieves this by pre-compiling a specific, smaller set of
shaders at application build time, rather than compiling at runtime.


### Related docs and resources

- [articleImpeller documentation](/perf/impeller)
- [open\_in\_newImpeller FAQ](https://github.com/flutter/flutter/blob/main/docs/engine/impeller/docs/faq.md)

## Jank

[tag](#jank "Link to card") keyboard\_arrow\_up

When an app appears to stutter or jerk visually instead of animating
smoothly.


Jank occurs when a system can't keep up with the expected frame rate
and drops frames. Jank is a performance problem. Flutter offers
information and tooling, such as the Performance tool in DevTools,
that can help you diagnose and fix jank in your application.


### Related docs and resources

- [articleUse the Performance view in DevTools](/tools/devtools/performance)
- [articleImproving rendering performance](/perf/rendering-performance)
- [articlePerformance best practices](/perf/best-practices)
- [articleMeasure performance with an integration test](/cookbook/testing/integration/profiling)

## Prop drilling

[tag](#prop-drilling "Link to card") keyboard\_arrow\_up

The process of passing data through multiple layers of widgets
through constructor parameters.


The process of passing data through multiple layers of widgets
through constructor parameters, usually to reach a deeper descendant.
This pattern can become verbose, which is
why other state management solutions
(like `InheritedWidget` or `Provider`) are often used.


### Related docs and resources

- [articleState management introduction](/data-and-backend/state-mgmt/intro)

## Sliver

[tag](#sliver "Link to card") keyboard\_arrow\_up

A customizable portion of a scrollable area.

A sliver is a portion of a scrollable area that you can define
to behave in a special way.
Think of slivers as building blocks that you can compose together
inside a `CustomScrollView` to create custom scrolling experiences,
like elastic scrolling or a collapsing header.
Slivers are built lazily, which means that Flutter only renders
the slivers that are visible on screen,
making them very efficient for long lists of content.


### Related docs and resources

- [articleSliver documentation](/ui/layout/scrolling/slivers)
- [articleSlivers demystified](https://blog.flutter.dev/slivers-demystified-6ff68ab0296f)
- [play\_arrowSliverList and SliverGrid WotW](https://youtu.be/ORiTTaVY6mM)
- [play\_arrowSliverAppBar WotW](https://youtu.be/R9C5KMJKluE)
- [descriptionCustomScrollView class](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html)
- [descriptionSliverAppBar class](https://api.flutter.dev/flutter/material/SliverAppBar-class.html)
- [descriptionSliverGrid class](https://api.flutter.dev/flutter/widgets/SliverGrid-class.html)
- [descriptionSliverList class](https://api.flutter.dev/flutter/widgets/SliverList-class.html)

## Viewport

[tag](#viewport "Link to card") keyboard\_arrow\_up

A widget that displays a subset of its children
based on the current scroll offset.


A viewport is the visual component of the scrolling machinery.
It displays a subset of its children (usually slivers)
based on the current scroll offset.
It is often described as being "bigger on the inside"
because it can contain more content than is visible on the screen.


### Related docs and resources

- [descriptionViewport class](https://api.flutter.dev/flutter/widgets/Viewport-class.html)
- [articleSlivers](/ui/layout/scrolling/slivers)

## Widget

[tag](#widget "Link to card") keyboard\_arrow\_up

The basic building block of a Flutter user interface.

An immutable description of part of a user interface.

In Flutter, almost everything is a _widget_.
Widgets are the fundamental building blocks you use to
create your application's UI with Flutter.
Each widget is an immutable declaration of \_what the UI should
look like based on its current configuration and state.


Widgets are composed together in a hierarchy to form the widget tree.
When a widget's state changes, the Flutter framework
rebuilds the necessary parts of the tree to update the UI.


The two primary types of widgets are
[`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html), which have no mutable state, and
[`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html), which have a persistent
[state](https://api.flutter.dev/flutter/widgets/State-class.html) that can be updated.


### Related docs and resources

- [articleWidget fundamentals](/learn/tutorial/widget-fundamentals)
- [articleWidget catalog](/ui/widgets)
- [descriptionWidget class](https://api.flutter.dev/flutter/widgets/Widget-class.html)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. [Report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/resources/glossary "Report an issue with this page").