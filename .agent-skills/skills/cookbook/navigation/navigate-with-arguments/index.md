---
name: pass-arguments-to-a-named-route
description: How to pass arguments to a named route.
metadata:
  url: https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Pass arguments to a named route

The [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
provides the ability to navigate
to a named route from any part of an app using
a common identifier.
In some cases, you might also need to pass arguments to a
named route. For example, you might wish to navigate to the `/user` route and
pass information about the user to that route.


infoNote

Named routes are no longer recommended for most
applications. For more information, see
[Limitations](/ui/navigation#limitations) in the [navigation overview](/ui/navigation)
page.


You can accomplish this task using the `arguments` parameter of the
[`Navigator.pushNamed()`](https://api.flutter.dev/flutter/widgets/Navigator/pushNamed.html)
method. Extract the arguments using the
[`ModalRoute.of()`](https://api.flutter.dev/flutter/widgets/ModalRoute/of.html)
method or inside an [`onGenerateRoute()`](https://api.flutter.dev/flutter/widgets/WidgetsApp/onGenerateRoute.html)

function provided to the [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
or [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html)

constructor.


This recipe demonstrates how to pass arguments to a named
route and read the arguments using `ModalRoute.of()`
and `onGenerateRoute()` using the following steps:


1. Define the arguments you need to pass.
2. Create a widget that extracts the arguments.
3. Register the widget in the `routes` table.
4. Navigate to the widget.

## 1\. Define the arguments you need to pass

[#](#1-define-the-arguments-you-need-to-pass)

First, define the arguments you need to pass to the new route.
In this example, pass two pieces of data:
The `title` of the screen and a `message`.


To pass both pieces of data, create a class that stores this information.

dart

```
// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;
​
  ScreenArguments(this.title, this.message);
}

```

content\_copy

## 2\. Create a widget that extracts the arguments

[#](#2-create-a-widget-that-extracts-the-arguments)

Next, create a widget that extracts and displays the
`title` and `message` from the `ScreenArguments`.
To access the `ScreenArguments`,
use the [`ModalRoute.of()`](https://api.flutter.dev/flutter/widgets/ModalRoute/of.html)
method.
This method returns the current route with the arguments.


dart

```
// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});
​
  static const routeName = '/extractArguments';
​
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
​
    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Center(child: Text(args.message)),
    );
  }
}

```

content\_copy

## 3\. Register the widget in the `routes` table

[#](#3-register-the-widget-in-the-routes-table)

Next, add an entry to the `routes` provided to the `MaterialApp` widget. The
`routes` define which widget should be created based on the name of the route.


dart

```
MaterialApp(
  routes: {
    ExtractArgumentsScreen.routeName: (context) =>
        const ExtractArgumentsScreen(),
  },
)

```

content\_copy

## 4\. Navigate to the widget

[#](#4-navigate-to-the-widget)

Finally, navigate to the `ExtractArgumentsScreen`
when a user taps a button using [`Navigator.pushNamed()`](https://api.flutter.dev/flutter/widgets/Navigator/pushNamed.html).
Provide the arguments to the route via the `arguments` property. The
`ExtractArgumentsScreen` extracts the `title` and `message`
from these
arguments.


dart

```
// A button that navigates to a named route.
// The named route extracts the arguments
// by itself.
ElevatedButton(
  onPressed: () {
    // When the user taps the button,
    // navigate to a named route and
    // provide the arguments as an optional
    // parameter.
    Navigator.pushNamed(
      context,
      ExtractArgumentsScreen.routeName,
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );
  },
  child: const Text('Navigate to screen that extracts arguments'),
),

```

content\_copy

## Alternatively, extract the arguments using `onGenerateRoute`

[#](#alternatively-extract-the-arguments-using-ongenerateroute)

Instead of extracting the arguments directly inside the widget, you can also
extract the arguments inside an [`onGenerateRoute()`](https://api.flutter.dev/flutter/widgets/WidgetsApp/onGenerateRoute.html)

function and pass them to a widget.


The `onGenerateRoute()` function creates the correct route based on the given
[`RouteSettings`](https://api.flutter.dev/flutter/widgets/RouteSettings-class.html).


dart

```
MaterialApp(
  // Provide a function to handle named routes.
  // Use this function to identify the named
  // route being pushed, and create the correct
  // Screen.
  onGenerateRoute: (settings) {
    // If you push the PassArguments route
    if (settings.name == PassArgumentsScreen.routeName) {
      // Cast the arguments to the correct
      // type: ScreenArguments.
      final args = settings.arguments as ScreenArguments;
​
      // Then, extract the required data from
      // the arguments and pass the data to the
      // correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return PassArgumentsScreen(
            title: args.title,
            message: args.message,
          );
        },
      );
    }
    // The code only supports
    // PassArgumentsScreen.routeName right now.
    // Other values need to be implemented if we
    // add them. The assertion here will help remind
    // us of that higher up in the call stack, since
    // this assertion would otherwise fire somewhere
    // in the framework.
    assert(false, 'Need to implement ${settings.name}');
    return null;
  },
)

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
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
      },
      // Provide a function to handle named routes.
      // Use this function to identify the named
      // route being pushed, and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Navigation with Arguments',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A button that navigates to a named route.
            // The named route extracts the arguments
            // by itself.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button,
                // navigate to a named route and
                // provide the arguments as an optional
                // parameter.
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Extract Arguments Screen',
                    'This message is extracted in the build method.',
                  ),
                );
              },
              child: const Text('Navigate to screen that extracts arguments'),
            ),
            // A button that navigates to a named route.
            // For this route, extract the arguments in
            // the onGenerateRoute function and pass them
            // to the screen.
            ElevatedButton(
              onPressed: () {
                // When the user taps the button, navigate
                // to a named route and provide the arguments
                // as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute '
                        'function.',
                  ),
                );
              },
              child: const Text('Navigate to a named that accepts arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Center(child: Text(args.message)),
    );
  }
}

// A Widget that accepts the necessary arguments via the
// constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor
  // parameters. It does not extract the arguments from
  // the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute
  // function provided to the MaterialApp widget.
  const PassArgumentsScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(message)),
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/navigate-with-arguments.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/navigate-with-arguments.md "Report an issue with this page").