---
name: adaptive-and-responsive-design-in-flutter
description: It's important to create an app, whether for mobile or web, that responds to size and orientation changes and maximizes the use of each platform.
metadata:
  url: https://docs.flutter.dev/ui/adaptive-responsive
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Adaptive and responsive design in Flutter

![List of supported platforms](/assets/images/docs/ui/adaptive-responsive/platforms.png)

One of Flutter's primary goals is to create a framework
that allows you to develop apps from a single codebase
that look and feel great on any platform.


This means that your app might appear on screens of
many different sizes, from a watch, to a foldable
phone with two screens, to a high definition monitor.
And your input device might be a physical or
virtual keyboard, a mouse, a touchscreen, or
any number of other devices.


Two terms that describe these design concepts
are _adaptive_ and _responsive_. Ideally,
you'd want your app to be _both_ but what,
exactly, does this mean?


## What is responsive vs adaptive?

[#](#what-is-responsive-vs-adaptive)

An easy way to think about it is that responsive design
is about fitting the UI _into_ the space and
adaptive design is about the UI being _usable_ in
the space.


So, a responsive app adjusts the placement of design
elements to _fit_ the available space. And an
adaptive app selects the appropriate layout and
input devices to be usable _in_ the available space.
For example, should a tablet UI use bottom navigation or
side-panel navigation?


infoNote

Often adaptive and responsive concepts are
collapsed into a single term. Most often,
_adaptive design_ is used to refer to both
adaptive and responsive.


This section covers various aspects of adaptive and
responsive design:


- [General approach](/ui/adaptive-responsive/general)
- [SafeArea & MediaQuery](/ui/adaptive-responsive/safearea-mediaquery)
- [Large screens & foldables](/ui/adaptive-responsive/large-screens)
- [User input & accessibility](/ui/adaptive-responsive/input)
- [Capabilities & policies](/ui/adaptive-responsive/capabilities)
- [Best practices for adaptive apps](/ui/adaptive-responsive/best-practices)
- [Additional resources](/ui/adaptive-responsive/more-info)

infoNote

You might also check out the Google I/O 2024 talk about
this subject.


[Watch on YouTube in a new tab: "How to build adaptive UI with Flutter"](https://www.youtube.com/watch/LeKLGzpsz9I)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/ui/adaptive-responsive/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/adaptive-responsive&page-source=https://github.com/flutter/website/blob/main/src/content/ui/adaptive-responsive/index.md "Report an issue with this page").