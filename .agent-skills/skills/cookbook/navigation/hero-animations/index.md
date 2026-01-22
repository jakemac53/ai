---
name: animate-a-widget-across-screens
description: How to animate a widget from one screen to another
metadata:
  url: https://docs.flutter.dev/cookbook/navigation/hero-animations
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Animate a widget across screens

It's often helpful to guide users through an app as they navigate from screen
to screen. A common technique to lead users through an app is to animate a
widget from one screen to the next. This creates a visual anchor connecting
the two screens.


Use the [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html) widget
to animate a widget from one screen to the next.
This recipe uses the following steps:


1. Create two screens showing the same image.
2. Add a `Hero` widget to the first screen.
3. Add a `Hero` widget to the second screen.

## 1\. Create two screens showing the same image

[#](#1-create-two-screens-showing-the-same-image)

In this example, display the same image on both screens.
Animate the image from the first screen to the second screen when
the user taps the image. For now, create the visual structure;
handle animations in the next steps.


infoNote

This example builds upon the
[Navigate to a new screen and back](/cookbook/navigation/navigation-basics)

and [Handle taps](/cookbook/gestures/handling-taps) recipes.


dart

```
import 'package:flutter/material.dart';
​
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return const DetailScreen();
              },
            ),
          );
        },
        child: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
​
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network('https://picsum.photos/250?image=9'),
        ),
      ),
    );
  }
}

```

content\_copy

## 2\. Add a `Hero` widget to the first screen

[#](#2-add-a-hero-widget-to-the-first-screen)

To connect the two screens together with an animation, wrap
the `Image` widget on both screens in a `Hero` widget.
The `Hero` widget requires two arguments:


`tag`

An object that identifies the `Hero`.
It must be the same on both screens.


`child`

The widget to animate across screens.

dart

```
Hero(
  tag: 'imageHero',
  child: Image.network('https://picsum.photos/250?image=9'),
)

```

content\_copy

## 3\. Add a `Hero` widget to the second screen

[#](#3-add-a-hero-widget-to-the-second-screen)

To complete the connection with the first screen,
wrap the `Image` on the second screen with a `Hero`
widget that has the same `tag` as the `Hero` in the first screen.


After applying the `Hero` widget to the second screen,
the animation between screens just works.


dart

```
Hero(
  tag: 'imageHero',
  child: Image.network('https://picsum.photos/250?image=9'),
)

```

content\_copy

infoNote

This code is identical to what you have on the first screen.
As a best practice, create a reusable widget instead of
repeating code. This example uses identical code for both
widgets, for simplicity.


## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() => runApp(const HeroApp());

class HeroApp extends StatelessWidget {
  const HeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Transition Demo', home: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return const DetailScreen();
              },
            ),
          );
        },
        child: Hero(
          tag: 'imageHero',
          child: Image.network('https://picsum.photos/250?image=9'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network('https://picsum.photos/250?image=9'),
          ),
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/hero-animations.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/navigation/hero-animations&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/hero-animations.md "Report an issue with this page").