---
name: add-a-drawer-to-a-screen
description: How to implement a Material Drawer.
metadata:
  url: https://docs.flutter.dev/cookbook/design/drawer
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Add a drawer to a screen

In apps that use Material Design,
there are two primary options for navigation: tabs and drawers.
When there is insufficient space to support tabs,
drawers provide a handy alternative.


In Flutter, use the [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html)
widget in combination with a
[`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html)
to create a layout with a Material Design drawer.
This recipe uses the following steps:


1. Create a `Scaffold`.
2. Add a drawer.
3. Populate the drawer with items.
4. Close the drawer programmatically.

## 1\. Create a `Scaffold`

[#](#1-create-a-scaffold)

To add a drawer to the app, wrap it in a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html)
widget.
The `Scaffold` widget provides a consistent visual structure to apps that
follow the Material Design Guidelines.
It also supports special Material Design
components, such as Drawers, AppBars, and SnackBars.


In this example, create a `Scaffold` with a `drawer`:

dart

```
Scaffold(
  appBar: AppBar(title: const Text('AppBar without hamburger button')),
  drawer: // Add a Drawer here in the next step.
);

```

content\_copy

## 2\. Add a drawer

[#](#2-add-a-drawer)

Now add a drawer to the `Scaffold`. A drawer can be any widget,
but it's often best to use the `Drawer` widget from the
[material library](https://api.flutter.dev/flutter/material/material-library.html),
which adheres to the Material Design spec.


dart

```
Scaffold(
  appBar: AppBar(title: const Text('AppBar with hamburger button')),
  drawer: Drawer(
    child: // Populate the Drawer in the next step.
  ),
);

```

content\_copy

## 3\. Populate the drawer with items

[#](#3-populate-the-drawer-with-items)

Now that you have a `Drawer` in place, add content to it.
For this example, use a [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html).
While you could use a `Column` widget,
`ListView` is handy because it allows users to scroll
through the drawer if the
content takes more space than the screen supports.


Populate the `ListView` with a [`DrawerHeader`](https://api.flutter.dev/flutter/material/DrawerHeader-class.html)

and two [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html)
widgets.
For more information on working with Lists,
see the [list recipes](/cookbook/lists).


dart

```
Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Item 1'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: const Text('Item 2'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
);

```

content\_copy

## 4\. Open the drawer programmatically

[#](#4-open-the-drawer-programmatically)

Typically, you don't need to write any code to open a `drawer`,
Because when the `leading` widget is null, the default implementation in
`AppBar` is `DrawerButton`.


But if you want to have free control of the `drawer`.
You can do this by using the `Builder` call `Scaffold.of(context).openDrawer()`.


dart

```
Scaffold(
  appBar: AppBar(
    title: const Text('AppBar with hamburger button'),
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
  ),
  drawer: Drawer(
    child: // Populate the Drawer in the last step.
  ),
);

```

content\_copy

## 5\. Close the drawer programmatically

[#](#5-close-the-drawer-programmatically)

After a user taps an item, you might want to close the drawer.
You can do this by using the [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html).


When a user opens the drawer, Flutter adds the drawer to the navigation
stack. Therefore, to close the drawer, call `Navigator.pop(context)`.


dart

```
ListTile(
  title: const Text('Item 1'),
  onTap: () {
    // Update the state of the app
    // ...
    // Then close the drawer
    Navigator.pop(context);
  },
),

```

content\_copy

## Interactive example

[#](#interactive-example)

This example shows a [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html)
as it is used within a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html)
widget.
The [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html)
has three [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html)
items.
The `_onItemTapped` function changes the selected item's index
and displays the corresponding text in the center of the `Scaffold`.


infoNote

For more information on implementing navigation,
check out the [Navigation](/cookbook/navigation) section of the cookbook.


```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Home', style: optionStyle),
    Text('Index 1: Business', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
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

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/design/drawer.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/design/drawer&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/design/drawer.md "Report an issue with this page").