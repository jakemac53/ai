---
name: approaches-to-state-management
description: An introduction to different approaches to managing state in Flutter apps.
metadata:
  url: https://docs.flutter.dev/data-and-backend/state-mgmt/options
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Approaches to state management

State management is a complex topic.
If you feel that some of your questions haven't been answered,
or that the approach described on these pages
is not viable for your use cases, you are probably right.


Learn more from the following resources,
many of which have been contributed by the Flutter community.


## General overview

[#](#general-overview)

Things to review before selecting an approach.

- [Introduction to state management](/data-and-backend/state-mgmt/intro),
   which is the beginning of this very section
   (for those of you who arrived directly to this _Options_ page
   and missed the previous pages)

- [Pragmatic State Management in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I),
   a video from Google I/O 2019

- [Flutter Architecture Samples](https://fluttersamples.com/), by Brian Egan

## Built-in approaches

[#](#built-in-approaches)

### `setState`

[#](#setstate)

The low-level approach to use for widget-specific, ephemeral state.

- [Adding interactivity to your Flutter app](/ui/interactivity), a Flutter tutorial
- [Basic state management in Google Flutter](https://medium.com/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d), by Agung Surya


### `ValueNotifier` and `InheritedNotifier`

[#](#valuenotifier-and-inheritednotifier)

An approach using only Flutter provided APIs to
update state and notify the UI of changes.


- [State Management using ValueNotifier and InheritedNotifier](https://www.hungrimind.com/articles/flutter-state-management), by Tadas Petra


### `InheritedWidget` and `InheritedModel`

[#](#inheritedwidget-and-inheritedmodel)

The low-level approach used to
communicate between ancestors and children in the widget tree.
This is what `package:provider` and many other approaches use under the hood.


The following instructor-led video workshop covers how to
use `InheritedWidget`:


[Watch on YouTube in a new tab: "How to manage application state using inherited widgets"](https://www.youtube.com/watch/LFcGPS6cGrY)

Other useful docs include:

- [InheritedWidget docs](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
- [Managing Flutter Application State With InheritedWidgets](https://blog.flutter.dev/managing-flutter-application-state-with-inheritedwidgets-1140452befe1),
   by Hans Muller

- [Inheriting Widgets](https://medium.com/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1), by Mehmet Fidanboylu

- [Using Flutter Inherited Widgets Effectively](https://ericwindmill.com/articles/inherited_widget/), by Eric Windmill

- [Widget - State - Context - InheritedWidget](https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/), by Didier Bolelens


## Community-provided packages

[#](#community-provided-packages)

Depending on the complexity of your app and preferences of your team,
you might find adopting a state management package useful.
State management packages often help reduce boilerplate code,
provide specialized debugging tools, and can help
enable a clearer and consistent application architecture.


The Flutter community offers a wide variety of state management packages.
The best choice for your app often depends on the app's complexity,
your team's preferences, and the specific problems you need to solve.


To begin exploring the available options,
check out the [`#state-management`](https://pub.dev/packages?q=topic%3Astate-management)
topic on the pub.dev site and
refine the search to find packages that match your needs.


[State management packagesopen\_in\_new\
\
Explore the variety of state-management packages built by and for the Flutter community.](https://pub.dev/packages?q=topic%3Astate-management)

lightbulbTip

If you've developed a state management package that
you think would be useful to the Flutter community,
consider [adding the `state-management` topic](https://dart.dev/tools/pub/pubspec#topics)
and
[publishing the package](https://dart.dev/tools/pub/publishing) to pub.dev.


[chevron\_left\
PreviousSimple app state management](/data-and-backend/state-mgmt/simple)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-8. [View source](https://github.com/flutter/website/blob/main/src/content/data-and-backend/state-mgmt/options.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/data-and-backend/state-mgmt/options&page-source=https://github.com/flutter/website/blob/main/src/content/data-and-backend/state-mgmt/options.md "Report an issue with this page").