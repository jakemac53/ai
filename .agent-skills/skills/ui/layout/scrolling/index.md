---
name: scrolling
description: Overview of Flutter's scrolling support
metadata:
  url: https://docs.flutter.dev/ui/layout/scrolling
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Scrolling

Flutter has many built-in widgets that automatically
scroll and also offers a variety of widgets
that you can customize to create specific scrolling
behavior.


## Basic scrolling

[#](#basic-scrolling)

Many Flutter widgets support scrolling out of the box
and do most of the work for you. For example,
[`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html)
automatically scrolls its
child when necessary. Other useful widgets include
[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
and [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html).
You can check out more of these widgets on the
[scrolling page](/ui/widgets/scrolling) of the Widget catalog.


[Watch on YouTube in a new tab: "Scrollbar \| Flutter widget of the week"](https://www.youtube.com/watch/DbkIQSvwnZc)

[Watch on YouTube in a new tab: "ListView \| Flutter widget of the week"](https://www.youtube.com/watch/KJpkjHGiI5A)

### Infinite scrolling

[#](#infinite-scrolling)

When you have a long list of items
in your `ListView` or `GridView` (including an _infinite_
list),
you can build the items on demand
as they scroll into view. This provides a much
more performant scrolling experience.
For more information, check out
[`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)
or [`GridView.builder`](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html).


### Specialized scrollable widgets

[#](#specialized-scrollable-widgets)

The following widgets provide more
specific scrolling behavior.


A video on using [`DraggableScrollableSheet`](https://api.flutter.dev/flutter/widgets/DraggableScrollableSheet-class.html):


[Watch on YouTube in a new tab: "DraggableScrollableSheet \| Flutter widget of the week"](https://www.youtube.com/watch/Hgw819mL_78)

Turn the scrollable area into a wheel with [`ListWheelScrollView`](https://api.flutter.dev/flutter/widgets/ListWheelScrollView-class.html)!


[Watch on YouTube in a new tab: "ListWheelScrollView \| Flutter widget of the week"](https://www.youtube.com/watch/dUhmWAz4C7Y)

## Fancy scrolling

[#](#fancy-scrolling)

Perhaps you want to implement _elastic_ scrolling,
also called _scroll bouncing_. Or maybe you want to
implement other dynamic scrolling effects, like parallax scrolling.
Or perhaps you want a scrolling header with very specific behavior,
such as shrinking or disappearing.


You can achieve all this and more using the
Flutter `Sliver*` classes.
A _sliver_ refers to a piece of the scrollable area.
You can define and insert a sliver into a [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html)

to have finer-grained control over that area.


For more information, check out
[Using slivers to achieve fancy scrolling](/ui/layout/scrolling/slivers)

and the [Sliver classes](/ui/widgets/layout#sliver-widgets).


## Nested scrolling widgets

[#](#nested-scrolling-widgets)

How do you nest a scrolling widget
inside another scrolling widget
without hurting scrolling performance?
Do you set the `ShrinkWrap` property to true,
or do you use a sliver?


Check out the "ShrinkWrap vs Slivers" video:

[Watch on YouTube in a new tab: "ShrinkWrap vs Slivers \| Decoding Flutter"](https://www.youtube.com/watch/LUqDNnv_dh0)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/ui/layout/scrolling/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/layout/scrolling&page-source=https://github.com/flutter/website/blob/main/src/content/ui/layout/scrolling/index.md "Report an issue with this page").