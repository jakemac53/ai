---
name: animations-tutorial
description: A tutorial showing how to build explicit animations in Flutter.
metadata:
  url: https://docs.flutter.dev/ui/animations/tutorial
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Animations tutorial

What you'll learn

- How to use the fundamental classes from the
animation library to add animation to a widget.

- When to use `AnimatedWidget` vs. `AnimatedBuilder`.

This tutorial shows you how to build explicit animations in Flutter.
The examples build on each other, introducing you to different aspects of the
animation library. The tutorial is built on essential concepts, classes,
and methods in the animation library that you can learn about in
[Introduction to animations](/ui/animations).


The Flutter SDK also provides built-in explicit animations,
such as [`FadeTransition`](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html),
[`SizeTransition`](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html),
and [`SlideTransition`](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html). These simple animations are
triggered by setting a beginning and ending point.
They are simpler to implement
than custom explicit animations, which are described here.


The following sections walks you through several animation examples.
Each section provides a link to the source code for that example.


## Rendering animations

[#](#rendering-animations)

What's the point?

- How to add basic animation to a widget using `addListener()` and
`setState()`.

- Every time the Animation generates a new number, the `addListener()`
function calls `setState()`.

- How to define an `AnimationController` with the required
`vsync` parameter.

- Understanding the " `..`" syntax in " `..addListener`",
also known as Dart's _cascade notation_.

- To make a class private, start its name with an underscore ( `_`).

So far you've learned how to generate a sequence of numbers over time.
Nothing has been rendered to the screen. To render with an
`Animation` object, store the `Animation` object as a
member of your widget, then use its value to decide how to draw.


Consider the following app that draws the Flutter logo without animation:

dart

```
import 'package:flutter/material.dart';
​
void main() => runApp(const LogoApp());
​
class LogoApp extends StatefulWidget {
  const LogoApp({super.key});
​
  @override
  State<LogoApp> createState() => _LogoAppState();
}
​
class _LogoAppState extends State<LogoApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 300,
        width: 300,
        child: const FlutterLogo(),
      ),
    );
  }
}

```

content\_copy

**App source:** [animate0](https://github.com/flutter/website/tree/main/examples/animation/animate0)

The following shows the same code modified to animate the
logo to grow from nothing to full size.
When defining an `AnimationController`, you must pass in a
`vsync` object. The `vsync` parameter is described in the
[`AnimationController` section](/ui/animations/index#animationcontroller).


The changes from the non-animated example are highlighted:

dart

```
class _LogoAppState extends State<LogoApp> {
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
​
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    controller.forward();
  }
​
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 300,
        width: 300,
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
​
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

```

content\_copy

**App source:** [animate1](https://github.com/flutter/website/tree/main/examples/animation/animate1)

The `addListener()` function calls `setState()`,
so every time the `Animation` generates a new number,
the current frame is marked dirty, which forces
`build()` to be called again. In `build()`,
the container changes size because its height and
width now use `animation.value` instead of a hardcoded value.
Dispose of the controller when the `State` object is
discarded to prevent memory leaks.


With these few changes,
you've created your first animation in Flutter!


lightbulbDart language trick

You might not be familiar with Dart's cascade notation—the two
dots in `..addListener()`. This syntax means that the `addListener()`

method is called with the return value from `animate()`.
Consider the following example:


dart

```
animation = Tween<double>(begin: 0, end: 300).animate(controller)
  ..addListener(() {
    // ···
  });

```

content\_copy

This code is equivalent to:

dart

```
animation = Tween<double>(begin: 0, end: 300).animate(controller);
animation.addListener(() {
    // ···
  });

```

content\_copy

To learn more about cascades,
check out [Cascade notation](https://dart.dev/language/operators#cascade-notation)

in the [Dart language documentation](https://dart.dev/language).


## Simplifying with AnimatedWidget

[#](#simplifying-with-animatedwidget)

What's the point?

- How to use the [`AnimatedWidget`](https://api.flutter.dev/flutter/widgets/AnimatedWidget-class.html)
helper class
(instead of `addListener()`
and `setState()`) to create a widget that animates.

- Use `AnimatedWidget` to create a widget that performs
a reusable animation.
To separate the transition from the widget, use an
`AnimatedBuilder`, as shown in the
[Refactoring with AnimatedBuilder](#refactoring-with-animatedbuilder)
section.

- Examples of `AnimatedWidget` s in the Flutter API:
`AnimatedBuilder`, `AnimatedModalBarrier`,
`DecoratedBoxTransition`, `FadeTransition`,
`PositionedTransition`, `RelativePositionedTransition`,
`RotationTransition`, `ScaleTransition`,
`SizeTransition`, `SlideTransition`.


The `AnimatedWidget` base class allows you to separate out
the core widget code from the animation code.
`AnimatedWidget` doesn't need to maintain a `State`
object to hold the animation. Add the following `AnimatedLogo` class:


dart

```
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);
​
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

```

content\_copy

`AnimatedLogo` uses the current value of the `animation`
when drawing itself.


The `LogoApp` still manages the `AnimationController` and the `Tween`,
and it passes the `Animation` object to `AnimatedLogo`:


dart

```
void main() => runApp(const LogoApp());
​
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);
​
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
​
class LogoApp extends StatefulWidget {
  // ...
​
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }
​
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
​
  // ...
}

```

content\_copy

**App source:** [animate2](https://github.com/flutter/website/tree/main/examples/animation/animate2)

## Monitoring the progress of the animation

[#](#monitoring-the-progress-of-the-animation)

What's the point?

- Use `addStatusListener()` for notifications of changes
to the animation's state, such as starting, stopping,
or reversing direction.

- Run an animation in an infinite loop by reversing direction when
the animation has either completed or returned to its starting state.


It's often helpful to know when an animation changes state,
such as finishing, moving forward, or reversing.
You can get notifications for this with `addStatusListener()`.
The following code modifies the previous example so that
it listens for a state change and prints an update.
The highlighted line shows the change:


dart

```
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
​
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) => print('$status'));
    controller.forward();
  }
  // ...
}

```

content\_copy

Running this code produces this output:

```
AnimationStatus.forward
AnimationStatus.completed

```

content\_copy

Next, use `addStatusListener()` to reverse the animation
at the beginning or the end. This creates a "breathing" effect:


dart

```
void initState() {
  super.initState();
  controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);
  animation = Tween<double>(begin: 0, end: 300).animate(controller);
  animation = Tween<double>(begin: 0, end: 300).animate(controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    })
    ..addStatusListener((status) => print('$status'));
  controller.forward();
}

```

content\_copy

**App source:** [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3)

## Refactoring with AnimatedBuilder

[#](#refactoring-with-animatedbuilder)

What's the point?

- An [`AnimatedBuilder`](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html)
understands how to render the transition.

- An `AnimatedBuilder` doesn't know how to render the widget,
nor does it manage the `Animation` object.

- Use `AnimatedBuilder` to describe an animation as
part of a build method for another widget.
If you simply want to define a widget with a reusable
animation, use an `AnimatedWidget`, as shown in
the [Simplifying with AnimatedWidget](#simplifying-with-animatedwidget)
section.

- Examples of `AnimatedBuilders` in the Flutter API: `BottomSheet`,
`ExpansionTile`, `PopupMenu`, `ProgressIndicator`,
`RefreshIndicator`, `Scaffold`, `SnackBar`,
`TabBar`,
`TextField`.


One problem with the code in the [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3)
example,
is that changing the animation required changing the widget
that renders the logo. A better solution
is to separate responsibilities into different classes:


- Render the logo
- Define the `Animation` object
- Render the transition

You can accomplish this separation with the help of the
`AnimatedBuilder` class. An `AnimatedBuilder` is a
separate class in the render tree. Like `AnimatedWidget`,
`AnimatedBuilder` automatically listens to notifications
from the `Animation` object, and marks the widget tree
dirty as necessary, so you don't need to call `addListener()`.


The widget tree for the [animate4](https://github.com/flutter/website/tree/main/examples/animation/animate4)

example looks like this:


![AnimatedBuilder widget tree](/assets/images/docs/ui/AnimatedBuilder-WidgetTree.png)

Starting from the bottom of the widget tree, the code for rendering
the logo is straightforward:


dart

```
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
​
  // Leave out the height and width so it fills the animating parent.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

```

content\_copy

The middle three blocks in the diagram are all created in the
`build()` method in `GrowTransition`, shown below.
The `GrowTransition` widget itself is stateless and holds
the set of final variables necessary to define the transition animation.
The build() function creates and returns the `AnimatedBuilder`,
which takes the ( `Anonymous` builder) method and the
`LogoWidget` object as parameters. The work of rendering the
transition actually happens in the ( `Anonymous` builder)
method, which creates a `Container` of the appropriate size
to force the `LogoWidget` to shrink to fit.


One tricky point in the code below is that the child looks
like it's specified twice. What's happening is that the
outer reference of child is passed to `AnimatedBuilder`,
which passes it to the anonymous closure, which then uses
that object as its child. The net result is that the
`AnimatedBuilder` is inserted in between the two widgets
in the render tree.


dart

```
class GrowTransition extends StatelessWidget {
  const GrowTransition({
    required this.child,
    required this.animation,
    super.key,
  });
​
  final Widget child;
  final Animation<double> animation;
​
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

```

content\_copy

Finally, the code to initialize the animation looks very
similar to the [animate2](https://github.com/flutter/website/tree/main/examples/animation/animate2)
example. The `initState()`
method creates an `AnimationController` and a `Tween`,
then binds them with `animate()`. The magic happens in
the `build()` method, which returns a `GrowTransition`
object with a `LogoWidget` as a child, and an animation object to
drive the transition. These are the three elements listed
in the bullet points above.


dart

```
void main() => runApp(const LogoApp());
​
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
​
  // Leave out the height and width so it fills the animating parent.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
​
class GrowTransition extends StatelessWidget {
  const GrowTransition({
    required this.child,
    required this.animation,
    super.key,
  });
​
  final Widget child;
  final Animation<double> animation;
​
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
​
class LogoApp extends StatefulWidget {
  // ...
​
  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
  Widget build(BuildContext context) {
    return GrowTransition(
      animation: animation,
      child: const LogoWidget(),
    );
  }
​
  // ...
}

```

content\_copy

**App source:** [animate4](https://github.com/flutter/website/tree/main/examples/animation/animate4)

## Simultaneous animations

[#](#simultaneous-animations)

What's the point?

- The [`Curves`](https://api.flutter.dev/flutter/animation/Curves-class.html) class defines an array of
commonly used curves that you can
use with a [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html).


In this section, you'll build on the example from
[monitoring the progress of the animation](#monitoring)
( [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3)), which used
`AnimatedWidget`
to animate in and out continuously. Consider the case
where you want to animate in and out while the
opacity animates from transparent to opaque.


infoNote

This example shows how to use multiple tweens on the same animation
controller, where each tween manages a different effect in
the animation. It is for illustrative purposes only.
If you were tweening opacity and size in production code,
you'd probably use [`FadeTransition`](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html)
and [`SizeTransition`](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html)

instead.


Each tween manages an aspect of the animation. For example:

dart

```
controller = AnimationController(
  duration: const Duration(seconds: 2),
  vsync: this,
);
sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);

```

content\_copy

You can get the size with `sizeAnimation.value` and the opacity
with `opacityAnimation.value`, but the constructor for `AnimatedWidget`

only takes a single `Animation` object. To solve this problem,
the example creates its own `Tween` objects and explicitly calculates the
values.


Change `AnimatedLogo` to encapsulate its own `Tween` objects,
and its `build()` method calls `Tween.evaluate()`
on the parent's animation object to calculate
the required size and opacity values.
The following code shows the changes with highlights:


dart

```
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);
​
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);
​
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
​
class LogoApp extends StatefulWidget {
  const LogoApp({super.key});
​
  @override
  State<LogoApp> createState() => _LogoAppState();
}
​
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
​
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }
​
  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
​
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

```

content\_copy

**App source:** [animate5](https://github.com/flutter/website/tree/main/examples/animation/animate5)
object knows the current state of an animation
(for example, whether it's started, stopped,
or moving forward or in reverse),
but doesn't know anything about what appears onscreen.


- An [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
   manages the `Animation`.

- A [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html)
   defines progression as a non-linear curve.

- A [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) interpolates between a beginning and ending value
   for a property being animated.


## Next steps

[#](#next-steps)

This tutorial gives you a foundation for creating animations in
Flutter using `Tweens`, but there are many other classes to explore.
You might investigate the specialized `Tween` classes,
animations specific to your design system type, `ReverseAnimation`,
shared element transitions (also known as Hero animations),
physics simulations and `fling()` methods.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/ui/animations/tutorial.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/animations/tutorial&page-source=https://github.com/flutter/website/blob/main/src/content/ui/animations/tutorial.md "Report an issue with this page").