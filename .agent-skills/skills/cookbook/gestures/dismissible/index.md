---
name: implement-swipe-to-dismiss
description: How to implement swiping to dismiss or delete.
metadata:
  url: https://docs.flutter.dev/cookbook/gestures/dismissible
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Implement swipe to dismiss

The "swipe to dismiss" pattern is common in many mobile apps.
For example, when writing an email app,
you might want to allow a user to swipe away
email messages to delete them from a list.


Flutter makes this task easy by providing the
[`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
widget.
Learn how to implement swipe to dismiss with the following steps:


1. Create a list of items.
2. Wrap each item in a `Dismissible` widget.
3. Provide "leave behind" indicators.

## 1\. Create a list of items

[#](#1-create-a-list-of-items)

First, create a list of items. For detailed
instructions on how to create a list,
follow the [Working with long lists](/cookbook/lists/long-lists) recipe.


### Create a data source

[#](#create-a-data-source)

In this example,
you want 20 sample items to work with.
To keep it simple, generate a list of strings.


dart

```
final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

```

content\_copy

### Convert the data source into a list

[#](#convert-the-data-source-into-a-list)

Display each item in the list on screen. Users won't
be able to swipe these items away just yet.


dart

```
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(title: Text(items[index]));
  },
)

```

content\_copy

## 2\. Wrap each item in a Dismissible widget

[#](#2-wrap-each-item-in-a-dismissible-widget)

In this step,
give users the ability to swipe an item off the list by using the
[`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
widget.


After the user has swiped away the item,
remove the item from the list and display a snackbar.
In a real app, you might need to perform more complex logic,
such as removing the item from a web service or database.


Update the `itemBuilder()` function to return a `Dismissible` widget:

dart

```
itemBuilder: (context, index) {
  final item = items[index];
  return Dismissible(
    // Each Dismissible must contain a Key. Keys allow Flutter to
    // uniquely identify widgets.
    key: Key(item),
    // Provide a function that tells the app
    // what to do after an item has been swiped away.
    onDismissed: (direction) {
      // Remove the item from the data source.
      setState(() {
        items.removeAt(index);
      });
​
      // Then show a snackbar.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$item dismissed')));
    },
    child: ListTile(title: Text(item)),
  );
},

```

content\_copy

## 3\. Provide "leave behind" indicators

[#](#3-provide-leave-behind-indicators)

As it stands,
the app allows users to swipe items off the list, but it doesn't
give a visual indication of what happens when they do.
To provide a cue that items are removed,
display a "leave behind" indicator as they
swipe the item off the screen. In this case,
the indicator is a red background.


To add the indicator,
provide a `background` parameter to the `Dismissible`.


dart

```
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('$item dismissed')));
},
// Show a red background as the item is swiped away.
background: Container(color: Colors.red),
child: ListTile(
  title: Text(item),
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

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    const title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text(item)),
            );
          },
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/gestures/dismissible.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/gestures/dismissible&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/gestures/dismissible.md "Report an issue with this page").