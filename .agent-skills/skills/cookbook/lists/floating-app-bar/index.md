---
name: place-a-floating-app-bar-above-a-list
description: How to place a floating app bar or navigation bar above a list.
metadata:
  url: https://docs.flutter.dev/cookbook/lists/floating-app-bar
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Place a floating app bar above a list

This guide describes how to place a floating app bar or
navigation bar above a list in a Flutter app.


## Overview

[#](#overview)

To make it easier for users to view a list of items,
you might want to minimize the app bar (navigation bar), as
the user scrolls down the list.


Moving the app bar into a [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html)
allows you
to create an app bar that can be minimized or scroll
offscreen as you scroll through a list of items contained
inside the `CustomScrollView`.


This recipe demonstrates how to use a `CustomScrollView` to
display a list of items with an app bar on top that
minimizes as the user scrolls down the list using the
following steps:


1. Create a `CustomScrollView`.
2. Add a floating app bar to `CustomScrollView`.
3. Add a list of items to `CustomScrollView`.

## 1\. Create a `CustomScrollView`

[#](#1-create-a-customscrollview)

To create a floating app bar, place the app bar inside a
`CustomScrollView` that also contains the list of items.
This synchronizes the scroll position of the app bar and the
list of items. You might think of the `CustomScrollView`
widget as a `ListView` that allows you to mix and match
different types of scrollable lists and widgets together.


The scrollable lists and widgets provided to the
`CustomScrollView` are known as _slivers_. There are several
types of slivers, such as `SliverList`, `SliverGrid`, and
`SliverAppBar`. In fact, the `ListView` and `GridView`

widgets use the `SliverList` and `SliverGrid` widgets to
implement scrolling.


For this example, create a `CustomScrollView` that contains
a `SliverList`. Also, remove the app bar property from your
code if it exists.


- [Material widgets](#127-tab-panel)
- [Cupertino widgets](#128-tab-panel)

dart

```
MaterialApp(
  title: 'Floating App Bar',
  home: Scaffold(
    // No app bar property provided yet.
    body: CustomScrollView(
      // Add the app bar and list of items as slivers in the next steps.
      slivers: <Widget>[],
    ),
  ),
);

```

content\_copy

dart

```
CupertinoApp(
  title: 'Floating Navigation Bar',
  home: CupertinoPageScaffold(
    // No navigation bar property provided yet.
    child: CustomScrollView(
      // Add the navigation bar and list of items as slivers in the next steps.
      slivers: <Widget>[],
    ),
  ),
);

```

content\_copy

## 2\. Add a floating app bar

[#](#2-add-a-floating-app-bar)

Next, add an app bar to the [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html).


- [Material widgets](#129-tab-panel)
- [Cupertino widgets](#130-tab-panel)

Flutter provides the [`SliverAppBar`](https://api.flutter.dev/flutter/material/SliverAppBar-class.html)
widget which,
much like the normal `AppBar` widget,
uses the `SliverAppBar` to display a title,
tabs, images and more.


However, the `SliverAppBar` also gives you the ability to
create a "floating" app bar that shrinks and floats when
you're not at the top of the page.


To create this effect:

1. Start with an app bar that displays only a title.
2. Set the `pinned` property to `true`.
3. Add a `flexibleSpace` widget that fills the available
    `expandedHeight`.


dart

```
slivers: [
  // Add the app bar to the CustomScrollView.
  SliverAppBar(
    // Provide a standard title.
    title: Text('Floating App Bar'),
    // Pin the app bar when scrolling.
    pinned: true,
    // Display a placeholder widget to visualize the shrinking size.
    flexibleSpace: Placeholder(),
    // Make the initial height of the SliverAppBar larger than normal.
    expandedHeight: 200,
  ),
],

```

content\_copy

lightbulbTip

Play around with the
[various properties you can pass to the `SliverAppBar` widget](https://api.flutter.dev/flutter/material/SliverAppBar/SliverAppBar.html),
and use hot reload to see the results. For example, use an
`Image` widget for the `flexibleSpace` property to create a
background image that shrinks in size as it's scrolled offscreen.


Flutter provides the [`CupertinoSliverNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar-class.html)

widget, which lets you have a "floating" navigation
bar that shrinks when you scroll down and floats when
you're not at the top of the page.


To create this effect:

1. Add `CupertinoSliverNavigationBar` to
    `CustomScrollView`.

2. Start with an app bar that displays only a title.

dart

```
slivers: [
  // Add the navigation bar to the CustomScrollView.
  CupertinoSliverNavigationBar(
    // Provide a standard title.
    largeTitle: Text('Floating App Bar'),
  ),
],

```

content\_copy

## 3\. Add a list of items

[#](#3-add-a-list-of-items)

Now that you have the app bar in place, add a list of items
to the `CustomScrollView`. You have two options: a
[`SliverList`](https://api.flutter.dev/flutter/widgets/SliverList-class.html)
or a [`SliverGrid`](https://api.flutter.dev/flutter/widgets/SliverGrid-class.html). If you need to
display a list of items one after the other, use the
`SliverList` widget. If you need to display a grid list, use
the `SliverGrid` widget.


- [Material widgets](#131-tab-panel)
- [Cupertino widgets](#132-tab-panel)

dart

```
// Next, create a SliverList
SliverList.builder(
  // The builder function returns a ListTile with a title that
  // displays the index of the current item.
  itemBuilder: (context, index) =>
      ListTile(title: Text('Item #$index')),
  // Builds 50 ListTiles
  itemCount: 50,
)

```

content\_copy

dart

```
// Next, create a SliverList
SliverList.builder(
  // The builder function returns a CupertinoListTile with a title
  // that displays the index of the current item.
  itemBuilder: (context, index) =>
      CupertinoListTile(title: Text('Item #$index')),
  // Builds 50 CupertinoListTile
  itemCount: 50,
)

```

content\_copy

## Interactive example

[#](#interactive-example)

- [Material widgets](#133-tab-panel)
- [Cupertino widgets](#134-tab-panel)

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No app bar provided to Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            const SliverAppBar(
              // Provide a standard title.
              title: Text(title),
              // Pin the app bar when scrolling
              pinned: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Placeholder(),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 200,
            ),
            // Next, create a SliverList
            SliverList.builder(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item #$index')),
              // Builds 50 ListTiles
              itemCount: 50,
            ),
          ],
        ),
      ),
    );
  }
}
```

```
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Floating Navigation Bar';

    return CupertinoApp(
      title: title,
      home: CupertinoPageScaffold(
        // No navigation bar provided to CupertinoPageScaffold,
        // only a body with a CustomScrollView.
        child: CustomScrollView(
          slivers: [
            // Add the navigation bar to the CustomScrollView.
            const CupertinoSliverNavigationBar(
              // Provide a standard title.
              largeTitle: Text(title),
            ),
            // Next, create a SliverList
            SliverList.builder(
              // The builder function returns a CupertinoListTile with a title
              // that displays the index of the current item.
              itemBuilder: (context, index) =>
                  CupertinoListTile(title: Text('Item #$index')),
              // Builds 50 CupertinoListTile
              itemCount: 50,
            ),
          ],
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/floating-app-bar.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/floating-app-bar&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/floating-app-bar.md "Report an issue with this page").