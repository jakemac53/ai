---
name: work-with-long-lists
description: Use ListView.builder to implement a long or infinite list.
metadata:
  url: https://docs.flutter.dev/cookbook/lists/long-lists
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Work with long lists

The standard [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
constructor works well
for small lists. To work with lists that contain
a large number of items, it's best to use the
[`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)
constructor.


In contrast to the default `ListView` constructor, which requires
creating all items at once, the `ListView.builder()` constructor
creates items as they're scrolled onto the screen.


## 1\. Create a data source

[#](#1-create-a-data-source)

First, you need a data source. For example, your data source
might be a list of messages, search results, or products in a store.
Most of the time, this data comes from the internet or a database.


For this example, generate a list of 10,000 Strings using the
[`List.generate`](https://api.flutter.dev/flutter/dart-core/List/List.generate.html)
constructor.


dart

```
List<String>.generate(10000, (i) => 'Item $i'),

```

content\_copy

## 2\. Convert the data source into widgets

[#](#2-convert-the-data-source-into-widgets)

To display the list of strings, render each String as a widget
using `ListView.builder()`.
In this example, display each String on its own line.


dart

```
ListView.builder(
  itemCount: items.length,
  prototypeItem: ListTile(title: Text(items.first)),
  itemBuilder: (context, index) {
    return ListTile(title: Text(items[index]));
  },
)

```

content\_copy

## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          prototypeItem: ListTile(title: Text(items.first)),
          itemBuilder: (context, index) {
            return ListTile(title: Text(items[index]));
          },
        ),
      ),
    );
  }
}
```

## Children's extent

[#](#childrens-extent)

To specify each item's extent, you can use either [`prototypeItem`](https://api.flutter.dev/flutter/widgets/ListView/prototypeItem.html),
[`itemExtent`](https://api.flutter.dev/flutter/widgets/ListView/itemExtent.html),
or [`itemExtentBuilder`](https://api.flutter.dev/flutter/widgets/ListView/itemExtentBuilder.html).


Specifying either is more efficient than letting the children determine their own extent
because the scrolling machinery can make use of the foreknowledge of the children's
extent to save work, for example when the scroll position changes drastically.


Use [`prototypeItem`](https://api.flutter.dev/flutter/widgets/ListView/prototypeItem.html)
or [`itemExtent`](https://api.flutter.dev/flutter/widgets/ListView/itemExtent.html)
if your list has items of fixed size.


Use [`itemExtentBuilder`](https://api.flutter.dev/flutter/widgets/ListView/itemExtentBuilder.html)
if your list has items of different sizes.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/long-lists.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/long-lists&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/long-lists.md "Report an issue with this page").