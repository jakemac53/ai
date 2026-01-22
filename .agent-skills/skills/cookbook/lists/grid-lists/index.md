---
name: create-a-grid-list
description: How to implement a grid list.
metadata:
  url: https://docs.flutter.dev/cookbook/lists/grid-lists
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create a grid list

In some cases, you might want to display your items as a grid rather than
a normal list of items that come one after the next.
For this task, use the [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html)
widget.


The simplest way to get started using grids is by using the
[`GridView.count()`](https://api.flutter.dev/flutter/widgets/GridView/GridView.count.html)
constructor,
because it allows you to specify how many rows or columns you'd like.


To visualize how `GridView` works,
generate a list of 100 widgets that display their index in the list.


dart

```
GridView.count(
  // Create a grid with 2 columns.
  // If you change the scrollDirection to horizontal,
  // this produces 2 rows.
  crossAxisCount: 2,
  // Generate 100 widgets that display their index in the list.
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        'Item $index',
        style: TextTheme.of(context).headlineSmall,
      ),
    );
  }),
),

```

content\_copy

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
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: GridView.count(
          // Create a grid with 2 columns.
          // If you change the scrollDirection to horizontal,
          // this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the list.
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: TextTheme.of(context).headlineSmall,
              ),
            );
          }),
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/grid-lists.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/grid-lists&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/grid-lists.md "Report an issue with this page").