---
name: list-with-spaced-items
description: How to create a list with spaced or expanded items
metadata:
  url: https://docs.flutter.dev/cookbook/lists/spaced-items
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# List with spaced items

Perhaps you want to create a list where all list items
are spaced evenly, so that the items take up the visible space.
For example, the four items in the following image are spaced evenly,
with "Item 0" at the top, and "Item 3" at the bottom.


![Spaced items](/assets/images/docs/cookbook/spaced-items-1.png)

At the same time, you might want to allow users
to scroll through the list when the list of items won't fit,
maybe because a device is too small, a user resized a window,
or the number of items exceeds the screen size.


![Scrollable items](/assets/images/docs/cookbook/spaced-items-2.png)

Typically, you use [`Spacer`](https://api.flutter.dev/flutter/widgets/Spacer-class.html)
to tune the spacing between widgets,
or [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
to expand a widget to fill the available space.
However, these solutions are not possible inside scrollable widgets,
because they need a finite height constraint.


This recipe demonstrates how to use [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
and [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html)

to space out list items evenly when there is enough space, and to allow
users to scroll when there is not enough space,
using the following steps:


1. Add a [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
    with a [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).

2. Add a [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html)
    inside the [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).

3. Create a [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) with spaced items.


## 1\. Add a `LayoutBuilder` with a `SingleChildScrollView`

[#](#1-add-a-layoutbuilder-with-a-singlechildscrollview)

Start by creating a [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html). You need to provide
a `builder` callback function with two parameters:


1. The [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
    provided by the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html).

2. The [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html)
    of the parent widget.


In this recipe, you won't be using the [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html),
but you will need the [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html)
in the next step.


Inside the `builder` function, return a [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).
This widget ensures that the child widget can be scrolled,
even when the parent container is too small.


dart

```
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(child: Placeholder());
  },
);

```

content\_copy

## 2\. Add a `ConstrainedBox` inside the `SingleChildScrollView`

[#](#2-add-a-constrainedbox-inside-the-singlechildscrollview)

In this step, add a [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html)

as the child of the [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).


The [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html)
widget imposes additional constraints to its child.


Configure the constraint by setting the `minHeight` parameter to be
the `maxHeight` of the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
constraints.


This ensures that the child widget
is constrained to have a minimum height equal to the available
space provided by the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
constraints,
namely the maximum height of the [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html).


dart

```
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Placeholder(),
      ),
    );
  },
);

```

content\_copy

However, you don't set the `maxHeight` parameter,
because you need to allow the child to be larger
than the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
size,
in case the items don't fit the screen.


## 3\. Create a `Column` with spaced items

[#](#3-create-a-column-with-spaced-items)

Finally, add a [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
as the child of the [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html).


To space the items evenly,
set the `mainAxisAlignment` to `MainAxisAlignment.spaceBetween`.


dart

```
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemWidget(text: 'Item 1'),
            ItemWidget(text: 'Item 2'),
            ItemWidget(text: 'Item 3'),
          ],
        ),
      ),
    );
  },
);

```

content\_copy

Alternatively, you can use the [`Spacer`](https://api.flutter.dev/flutter/widgets/Spacer-class.html)
widget
to tune the spacing between the items,
or the [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
widget, if you want one widget to take more space than others.


For that, you have to wrap the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
with an [`IntrinsicHeight`](https://api.flutter.dev/flutter/widgets/IntrinsicHeight-class.html)
widget,
which forces the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
widget to size itself to a minimum height,
instead of expanding infinitely.


dart

```
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: Column(
            children: [
              ItemWidget(text: 'Item 1'),
              Spacer(),
              ItemWidget(text: 'Item 2'),
              Expanded(child: ItemWidget(text: 'Item 3')),
            ],
          ),
        ),
      ),
    );
  },
);

```

content\_copy

lightbulbTip

Play around with different devices, resizing the app,
or resizing the browser window, and see how the item list adapts
to the available space.


## Interactive example

[#](#interactive-example)

This example shows a list of items that are spaced evenly within a column.
The list can be scrolled up and down when the items don't fit the screen.
The number of items is defined by the variable `items`,
change this value to see what happens when the items won't fit the screen.


```
import 'package:flutter/material.dart';

void main() => runApp(const SpacedItemsList());

class SpacedItemsList extends StatelessWidget {
  const SpacedItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 4;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        cardTheme: CardThemeData(color: Colors.blue.shade50),
      ),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    items,
                    (index) => ItemWidget(text: 'Item $index'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(height: 100, child: Center(child: Text(text))),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/spaced-items.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/spaced-items&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/spaced-items.md "Report an issue with this page").