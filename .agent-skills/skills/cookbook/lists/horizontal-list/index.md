---
name: create-a-horizontal-list
description: How to implement a horizontal list.
metadata:
  url: https://docs.flutter.dev/cookbook/lists/horizontal-list
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create a horizontal list

You might want to create a list that scrolls
horizontally rather than vertically.
The [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
widget supports horizontal lists.


Use the standard `ListView` constructor, passing in a horizontal
`scrollDirection`, which overrides the default vertical direction.


dart

```
ListView(
  scrollDirection: Axis.horizontal,
  children: [
    for (final color in Colors.primaries)
      Container(width: 160, color: color),
  ],
),

```

content\_copy

## Interactive example

[#](#interactive-example)

```
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal list';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: ScrollConfiguration(
            // Add a custom scroll behavior that
            // allows all devices to drag the list.
            behavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {...PointerDeviceKind.values},
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final color in Colors.primaries)
                  Container(width: 160, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/horizontal-list.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/horizontal-list&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/horizontal-list.md "Report an issue with this page").