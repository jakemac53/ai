---
name: update-the-ui-based-on-orientation
description: Respond to a change in the screen's orientation.
metadata:
  url: https://docs.flutter.dev/cookbook/design/orientation
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Update the UI based on orientation

In some situations,
you want to update the display of an app when the shape of the
available space changes like when a user rotates
the screen from portrait mode to landscape mode. For example,
the app might show one item after the next in portrait mode,
yet put those same items side-by-side in landscape mode.
Expanded docs covering this and more can be found
in the [adaptive ui documenation](https://api.flutter.dev/ui/adaptive-responsive).


In Flutter, you can build different layouts depending
on a given [`Orientation`](https://api.flutter.dev/flutter/widgets/Orientation.html).
In this example, build a list that displays two columns in
portrait mode and three columns in landscape mode using the
following steps:


1. Build a `GridView` with two columns.
2. Use an `OrientationBuilder` to change the number of columns.

## 1\. Build a `GridView` with two columns

[#](#1-build-a-gridview-with-two-columns)

First, create a list of items to work with.
Rather than using a normal list,
create a list that displays items in a grid.
For now, create a grid with two columns.


dart

```
return GridView.count(
  // A list with 2 columns
  crossAxisCount: 2,
  // ...
);

```

content\_copy

To learn more about working with `GridViews`,
see the [Creating a grid list](/cookbook/lists/grid-lists) recipe.


## 2\. Use an `OrientationBuilder` to change the number of columns

[#](#2-use-an-orientationbuilder-to-change-the-number-of-columns)

To determine the app's current `Orientation`, use the
[`OrientationBuilder`](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html)
widget.
The `OrientationBuilder` calculates the current `Orientation`
by
comparing the width and height available to the parent widget,
and rebuilds when the size of the parent changes.


Using the `Orientation`, build a list that displays two columns in portrait
mode, or three columns in landscape mode.


dart

```
body: OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      // Create a grid with 2 columns in portrait mode,
      // or 3 columns in landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
),

```

content\_copy

infoNote

If you're interested in the orientation of the screen,
rather than the amount of space available to the parent,
use `MediaQuery.orientationOf(context)` instead of an
`OrientationBuilder` widget.
Using `MediaQuery.orientationOf` as a way to organize UI
is [discouraged](https://api.flutter.dev/ui/adaptive-responsive/best-practices). Instead use
`MediaQuery.sizeOf(context)`

## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Orientation Demo';

    return const MaterialApp(
      title: appTitle,
      home: OrientationList(title: appTitle),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  const OrientationList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or
            // 3 columns in landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 widgets that display their index in the list.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: TextTheme.of(context).displayLarge,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
```

## Locking device orientation

[#](#locking-device-orientation)

In the previous section, you learned
how to adapt the app UI to device orientation changes.


Flutter also allows you to specify the orientations your app supports
using the values of [`DeviceOrientation`](https://api.flutter.dev/flutter/services/DeviceOrientation.html). You can either:


- Lock the app to a single orientation, like only the `portraitUp` position, or...
- Allow multiple orientations, like both `portraitUp` and `portraitDown`, but not landscape.


In the application `main()` method,
call [`SystemChrome.setPreferredOrientations()`](https://api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html)

with the list of preferred orientations that your app supports.


To lock the device to a single orientation,
you can pass a list with a single item.


For a list of all the possible values, check out [`DeviceOrientation`](https://api.flutter.dev/flutter/services/DeviceOrientation.html).


dart

```
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/design/orientation.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/design/orientation&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/design/orientation.md "Report an issue with this page").