---
name: display-a-snackbar
description: How to implement a snackbar to display messages.
metadata:
  url: https://docs.flutter.dev/cookbook/design/snackbars
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Display a snackbar

It can be useful to briefly inform your users when certain actions
take place. For example, when a user swipes away a message in a list,
you might want to inform them that the message has been deleted.
You might even want to give them an option to undo the action.


In Material Design, this is the job of a [`SnackBar`](https://api.flutter.dev/flutter/material/SnackBar-class.html).
This recipe implements a snackbar using the following steps:


1. Create a `Scaffold`.
2. Display a `SnackBar`.
3. Provide an optional action.

## 1\. Create a `Scaffold`

[#](#1-create-a-scaffold)

When creating apps that follow the Material Design guidelines,
give your apps a consistent visual structure.
In this example, display the `SnackBar` at the bottom of the screen,
without overlapping other important
widgets, such as the `FloatingActionButton`.


The [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget, from the
[material library](https://api.flutter.dev/flutter/material/material-library.html),
creates this visual structure and ensures that important
widgets don't overlap.


dart

```
return MaterialApp(
  title: 'SnackBar Demo',
  home: Scaffold(
    appBar: AppBar(title: const Text('SnackBar Demo')),
    body: const SnackBarPage(),
  ),
);

```

content\_copy

## 2\. Display a `SnackBar`

[#](#2-display-a-snackbar)

With the `Scaffold` in place, display a `SnackBar`.
First, create a `SnackBar`, then display it using `ScaffoldMessenger`.


dart

```
const snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
​
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
ScaffoldMessenger.of(context).showSnackBar(snackBar);

```

content\_copy

infoNote

To learn more, watch this short Widget of the Week video on
the `ScaffoldMessenger` widget:


[Watch on YouTube in a new tab: "ScaffoldMessenger \| Flutter widget of the week"](https://www.youtube.com/watch/lytQi-slT5Y)

## 3\. Provide an optional action

[#](#3-provide-an-optional-action)

You might want to provide an action to the user when
the SnackBar is displayed.
For example, if the user accidentally deletes a message,
they might use an optional action in the SnackBar to recover
the message.


Here's an example of providing
an additional `action` to the `SnackBar` widget:


dart

```
final snackBar = SnackBar(
  content: const Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

```

content\_copy

## Interactive example

[#](#interactive-example)

infoNote

In this example, the SnackBar displays when a user taps a button.
For more information on working with user input,
see the [Gestures](/cookbook/gestures) section of the cookbook.


```
import 'package:flutter/material.dart';

void main() => runApp(const SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('SnackBar Demo')),
        body: const SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/design/snackbars.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/design/snackbars&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/design/snackbars.md "Report an issue with this page").