---
name: use-lists
description: How to implement a list.
metadata:
  url: https://docs.flutter.dev/cookbook/lists/basic-list
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Use lists

Displaying lists of data is a fundamental pattern for mobile apps.
Flutter includes the [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)

widget to make working with lists a breeze.


## Create a ListView

[#](#create-a-listview)

Using the standard `ListView` constructor is
perfect for lists that contain only a few items.
The built-in [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html)

widget is a way to give items a visual structure.


dart

```
ListView(
  children: const <Widget>[
    ListTile(leading: Icon(Icons.map), title: Text('Map')),
    ListTile(leading: Icon(Icons.photo_album), title: Text('Album')),
    ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
  ],
),

```

content\_copy

## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Basic List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView(
          children: const <Widget>[
            ListTile(leading: Icon(Icons.map), title: Text('Map')),
            ListTile(leading: Icon(Icons.photo_album), title: Text('Album')),
            ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
          ],
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/lists/basic-list.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/lists/basic-list&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/lists/basic-list.md "Report an issue with this page").