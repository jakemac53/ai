---
name: navigate-to-a-new-screen-and-back
description: How to navigate between routes.
metadata:
  url: https://docs.flutter.dev/cookbook/navigation/navigation-basics
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Navigate to a new screen and back

Most apps contain several screens for displaying different
types of information. For example, an app might have a
screen that displays products. When the user taps the image
of a product, a new screen displays details about the
product.


infoTerminology

In Flutter, _screens_ and _pages_ are called _routes_.
The remainder of this recipe refers to routes.


In Android, a route is equivalent to an `Activity`.
In iOS, a route is equivalent to a `ViewController`.
In Flutter, a route is just a widget.


This recipe uses the [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
to navigate to a new route.


The next few sections show how to navigate between two routes,
using these steps:


1. Create two routes.
2. Navigate to the second route using `Navigator.push()`.
3. Return to the first route using `Navigator.pop()`.

## 1\. Create two routes

[#](#1-create-two-routes)

First, create two routes to work with. Since this is a basic example,
each route contains only a single button. Tapping the button on the
first route navigates to the second route. Tapping the button on the
second route returns to the first route.


First, set up the visual structure:

- [Android](#121-tab-panel)
- [iOS](#122-tab-panel)

dart

```
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
​
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

```

content\_copy

dart

```
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
​
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

```

content\_copy

## 2\. Navigate to the second route using Navigator.push()

[#](#2-navigate-to-the-second-route-using-navigator-push)

To switch to a new route, use the [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)

method. The `push()` method adds a `Route` to the stack of routes managed by
the `Navigator`. Where does the `Route` come from?
You can create your own, or use a platform-specific route
such as [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html)
or [`CupertinoPageRoute`](https://api.flutter.dev/flutter/cupertino/CupertinoPageRoute-class.html).
A platform-specific route is useful because it transitions
to the new route using a platform-specific animation.


In the `build()` method of the `FirstRoute` widget,
update the `onPressed()` callback:


- [Android](#123-tab-panel)
- [iOS](#124-tab-panel)

dart

```
// Within the `FirstRoute` widget:
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const SecondRoute(),
    ),
  );
}

```

content\_copy

dart

```
// Within the `FirstRoute` widget:
onPressed: () {
  Navigator.push(
    context,
    CupertinoPageRoute<void>(
      builder: (context) => const SecondRoute(),
    ),
  );
}

```

content\_copy

## 3\. Return to the first route using Navigator.pop()

[#](#3-return-to-the-first-route-using-navigator-pop)

How do you close the second route and return to the first?
By using the [`Navigator.pop()`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html)
method.
The `pop()` method removes the current `Route` from the stack of
routes managed by the `Navigator`.


To implement a return to the original route, update the `onPressed()`
callback in the `SecondRoute` widget:


dart

```
// Within the SecondRoute widget
onPressed: () {
  Navigator.pop(context);
}

```

content\_copy

## Interactive example

[#](#interactive-example)

- [Android](#125-tab-panel)
- [iOS](#126-tab-panel)

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const SecondRoute(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

```
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const CupertinoApp(title: 'Navigation Basics', home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('First Route')),
      child: Center(
        child: CupertinoButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                builder: (context) => const SecondRoute(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Second Route')),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
```

## Additional navigation methods

[#](#additional-navigation-methods)

The recipe in this topic shows you one way to navigate to a new screen and
back to the previous scene, using the [`push`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)
and [`pop`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html) methods in the
[`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
class, but there are several other `Navigator` static methods that
you can use. Here are a few of them:


- [`pushAndRemoveUntil`](https://api.flutter.dev/flutter/widgets/Navigator/pushAndRemoveUntil.html): Adds a navigation route to the stack and then removes
   the most recent routes from the stack until a condition is met.

- [`pushReplacement`](https://api.flutter.dev/flutter/widgets/Navigator/pushReplacement.html): Replaces the current route on the top of the
   stack with a new one.

- [`replace`](https://api.flutter.dev/flutter/widgets/Navigator/replace.html): Replace a route on the stack with another route.

- [`replaceRouteBelow`](https://api.flutter.dev/flutter/widgets/Navigator/replaceRouteBelow.html): Replace the route below a specific route on the stack.

- [`popUntil`](https://api.flutter.dev/flutter/widgets/Navigator/popUntil.html): Removes the most recent routes that were added to the stack of
   navigation routes until a condition is met.

- [`removeRoute`](https://api.flutter.dev/flutter/widgets/Navigator/removeRoute.html): Remove a specific route from the stack.

- [`removeRouteBelow`](https://api.flutter.dev/flutter/widgets/Navigator/removeRouteBelow.html): Remove the route below a specific route on the
   stack.

- [`restorablePush`](https://api.flutter.dev/flutter/widgets/Navigator/restorablePush.html): Restore a route that was removed from the stack.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/navigation-basics.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/navigation/navigation-basics&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/navigation-basics.md "Report an issue with this page").