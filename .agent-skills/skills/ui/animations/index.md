---
name: introduction-to-animations
description: How to perform animations in Flutter.
metadata:
  url: https://docs.flutter.dev/ui/animations
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Introduction to animations

Well-designed animations make a UI feel more intuitive,
contribute to the slick look and feel of a polished app,
and improve the user experience.
Flutter's animation support makes it easy to implement a variety of
animation types. Many widgets, especially [Material widgets](/ui/widgets/material),
come with the standard motion effects defined in their design spec,
but it's also possible to customize these effects.


## Choosing an approach

[#](#choosing-an-approach)

There are different approaches you can take when creating
animations in Flutter. Which approach is right for you?
To help you decide, check out the video,
[How to choose which Flutter Animation Widget is right for you?](https://www.youtube.com/watch?v=GXIJJkq_H8g)

(Also published as a [_companion article_](https://blog.flutter.dev/how-to-choose-which-flutter-animation-widget-is-right-for-you-79ecfb7e72b5).)


[Watch on YouTube in a new tab: "How to choose which Flutter animation widget is right for your use case"](https://www.youtube.com/watch/GXIJJkq_H8g)

(To dive deeper into the decision process,
watch the [Animations in Flutter done right](https://www.youtube.com/watch?v=wnARLByOtKA&t=3s)
video,
presented at Flutter Europe.)


As shown in the video, the following
decision tree helps you decide what approach
to use when implementing a Flutter animation:


![The animation decision tree](/assets/images/docs/ui/animations/animation-decision-tree.png)

## Animation deep dive

[#](#animation-deep-dive)

For a deeper understanding of just how animations work in Flutter, watch
[Animation deep dive](https://www.youtube.com/watch?v=PbcILiN8rbo&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=5).
(Also published as a [_companion article_](https://blog.flutter.dev/animation-deep-dive-39d3ffea111f).)


[Watch on YouTube in a new tab: "Take a deep dive into Flutter animation"](https://www.youtube.com/watch/PbcILiN8rbo)

## Implicit and explicit animations

[#](#implicit-and-explicit-animations)

### Pre-packaged implicit animations

[#](#pre-packaged-implicit-animations)

If a pre-packaged implicit animation (the easiest animation
to implement) suits your needs, watch
[Animation basics with implicit animations](https://www.youtube.com/watch?v=IVTjpW3W33s&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=1).
(Also published as a [_companion article_](https://blog.flutter.dev/flutter-animation-basics-with-implicit-animations-95db481c5916).)


[Watch on YouTube in a new tab: "Flutter implicit animation basics"](https://www.youtube.com/watch/IVTjpW3W33s)

### Custom implicit animations

[#](#custom-implicit-animations)

To create a custom implicit animation, watch
[Creating your own custom implicit animations with TweenAnimationBuilder](https://www.youtube.com/watch?v=6KiPEqzJIKQ&feature=youtu.be).
(Also published as a [_companion article_](https://blog.flutter.dev/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185).)


[Watch on YouTube in a new tab: "Create custom implicit animations with TweenAnimationBuilder"](https://www.youtube.com/watch/6KiPEqzJIKQ)

### Built-in explicit animations

[#](#built-in-explicit-animations)

To create an explicit animation (where you control the animation,
rather than letting the framework control it), perhaps
you can use one of the built-in explicit animations classes.
For more information, watch
[Making your first directional animations with\
built-in explicit animations](https://www.youtube.com/watch?v=CunyH6unILQ&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=3).
(Also published as a [_companion article_](https://blog.flutter.dev/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7).)


[Watch on YouTube in a new tab: "Making your first directional animations with built-in explicit animations"](https://www.youtube.com/watch/CunyH6unILQ)

### Explicit animations

[#](#explicit-animations)

If you need to build an explicit animation from scratch, watch
[Creating custom explicit animations with\
AnimatedBuilder and AnimatedWidget](https://www.youtube.com/watch?v=fneC7t4R_B0&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=4).
(Also published as a [_companion article_](https://blog.flutter.dev/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8).)


[Watch on YouTube in a new tab: "Creating custom explicit animations with AnimatedBuilder and AnimatedWidget"](https://www.youtube.com/watch/fneC7t4R_B0)

## Animation types

[#](#animation-types)

Generally, animations are either tween- or physics-based.
The following sections explain what these terms mean,
and point you to resources where you can learn more.


### Tween animation

[#](#tween-animation)

Short for _in-betweening_. In a tween animation, the beginning
and ending points are defined, as well as a timeline, and a curve
that defines the timing and speed of the transition.
The framework calculates how to transition from the beginning point
to the end point.


- See the [Animations tutorial](/ui/animations/tutorial), which uses tweens in the examples.

- Also see the API documentation for [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html),
   [`CurveTween`](https://api.flutter.dev/flutter/animation/CurveTween-class.html), and
   [`TweenSequence`](https://api.flutter.dev/flutter/animation/TweenSequence-class.html).


### Physics-based animation

[#](#physics-based-animation)

In physics-based animation, motion is modeled to resemble real-world
behavior. When you toss a ball, for example, where and when it lands
depends on how fast it was tossed and how far it was from the ground.
Similarly, dropping a ball attached to a spring falls
(and bounces) differently than dropping a ball attached to a string.


- [Animate a widget using a physics simulation](/cookbook/animation/physics-simulation)



   A recipe in the animations section of the Flutter cookbook.

- Also see the API documentation for
   [`AnimationController.animateWith`](https://api.flutter.dev/flutter/animation/AnimationController/animateWith.html)
   and
   [`SpringSimulation`](https://api.flutter.dev/flutter/physics/SpringSimulation-class.html).


## Common animation patterns

[#](#common-animation-patterns)

Most UX or motion designers find that certain
animation patterns are used repeatedly when designing a UI.
This section lists some of the commonly
used animation patterns, and tells you where to learn more.


### Animated list or grid

[#](#animated-list-or-grid)

This pattern involves animating the addition or removal of
elements from a list or grid.


- [`AnimatedList` example](https://github.com/flutter/samples/blob/main/animations)



   This demo, from the [Sample app catalog](https://github.com/flutter/samples), shows how to
   animate adding an element to a list, or removing a selected element.
   The internal Dart list is synced as the user modifies the list using
   the plus (+) and minus (-) buttons.


### Shared element transition

[#](#shared-element-transition)

In this pattern, the user selects an element—often an
image—from the page, and the UI animates the selected element
to a new page with more detail. In Flutter, you can easily implement
shared element transitions between routes (pages)
using the `Hero` widget.


- [Hero animations](/ui/animations/hero-animations)
   How to create two styles of Hero animations:
  - The hero flies from one page to another while changing position
     and size.
  - The hero's boundary changes shape, from a circle to a square,
     as its flies from one page to another.
- Also see the API documentation for the
   [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html),
   [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html), and
   [`PageRoute`](https://api.flutter.dev/flutter/widgets/PageRoute-class.html) classes.


### Staggered animation

[#](#staggered-animation)

Animations that are broken into smaller motions,
where some of the motion is delayed.
The smaller animations might be sequential,
or might partially or completely overlap.


- [Staggered Animations](/ui/animations/staggered-animations)

## Essential animation concepts and classes

[#](#essential-animation-concepts-and-classes)

The animation system in Flutter is based on typed
[`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html)
objects. Widgets can either incorporate
these animations in their build functions directly by
reading their current value and listening to their state
changes or they can use the animations as the basis of
more elaborate animations that they pass along to
other widgets.


### Animation<double>

[#](#animationwbrdouble)

In Flutter, an `Animation` object knows nothing about what
is onscreen. An `Animation` is an abstract class that
understands its current value and its state (completed or dismissed).
One of the more commonly used animation types is `Animation<double>`.


An `Animation` object sequentially generates
interpolated numbers between two values over a certain duration.
The output of an `Animation` object might be linear,
a curve, a step function, or any other mapping you can create.
Depending on how the `Animation` object is controlled,
it could run in reverse, or even switch directions in the
middle.


Animations can also interpolate types other than double, such as
`Animation<Color>` or `Animation<Size>`.


An `Animation` object has state. Its current value is
always available in the `.value` member.


An `Animation` object knows nothing about rendering or
`build()` functions.


### CurvedAnimation

[#](#curvedanimation)

A [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html)
defines the animation's progress
as a non-linear curve.


dart

```
animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

```

content\_copy

`CurvedAnimation` and `AnimationController` (described in the next sections)
are both of type `Animation<double>`, so you can pass them interchangeably.
The `CurvedAnimation` wraps the object it's modifying—you
don't subclass `AnimationController` to implement a curve.


You can use [`Curves`](https://api.flutter.dev/flutter/animation/Curves-class.html)
with `CurvedAnimation`. The `Curves` class defines
many commonly used curves, or you can create your own. For example:


dart

```
import 'dart:math';
​
class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}

```

content\_copy

If you want to apply an animation curve to a `Tween`, consider using
[`CurveTween`](https://api.flutter.dev/flutter/animation/CurveTween-class.html).


### AnimationController

[#](#animationcontroller)

[`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
is a special `Animation`
object that generates a new value whenever the hardware
is ready for a new frame. By default,
an `AnimationController` linearly produces the numbers
from 0.0 to 1.0 during a given duration.
For example, this code creates an `Animation` object,
but does not start it running:


dart

```
controller = AnimationController(
  duration: const Duration(seconds: 2),
  vsync: this,
);

```

content\_copy

`AnimationController` derives from `Animation<double>`, so it can be used
wherever an `Animation` object is needed. However, the `AnimationController`

has additional methods to control the animation. For example, you start
an animation with the `.forward()` method. The generation of numbers is
tied to the screen refresh, so typically 60 numbers are generated per
second. After each number is generated, each `Animation` object calls the
attached `Listener` objects. To create a custom display list for each
child, see [`RepaintBoundary`](https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html).


When creating an `AnimationController`, you pass it a `vsync` argument.
The presence of `vsync` prevents offscreen animations from consuming
unnecessary resources.
You can use your stateful object as the vsync by adding
`SingleTickerProviderStateMixin` to the class definition.
You can see an example of this in [animate1](https://github.com/flutter/website/tree/main/examples/animation/animate1)
on GitHub.


infoNote

In some cases, a position might exceed the `AnimationController`'s
0.0-1.0 range. For example, the `fling()` function
allows you to provide velocity, force, and position
(using the Force object). The position can be anything and
so can be outside of the 0.0 to 1.0 range.


A `CurvedAnimation` can also exceed the 0.0 to 1.0 range,
even if the `AnimationController` doesn't.
Depending on the curve selected, the output of
the `CurvedAnimation` can have a wider range than the input.
For example, elastic curves such as `Curves.elasticIn`
significantly overshoots or undershoots the default range.


### Tween

[#](#tween)

By default, the `AnimationController` object ranges from 0.0 to 1.0.
If you need a different range or a different data type, you can use a
[`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html)
to configure an animation to interpolate to a
different range or data type. For example, the
following `Tween` goes from -200.0 to 0.0:


dart

```
tween = Tween<double>(begin: -200, end: 0);

```

content\_copy

A `Tween` is a stateless object that takes only `begin` and `end`.
The sole job of a `Tween` is to define a mapping from an
input range to an output range. The input range is commonly
0.0 to 1.0, but that's not a requirement.


A `Tween` inherits from `Animatable<T>`, not from `Animation<T>`.
An `Animatable`, like `Animation`, doesn't have to output double.
For example, `ColorTween` specifies a progression between two colors.


dart

```
colorTween = ColorTween(begin: Colors.transparent, end: Colors.black54);

```

content\_copy

A `Tween` object doesn't store any state. Instead, it provides the
[`evaluate(Animation<double> animation)`](https://api.flutter.dev/flutter/animation/Animation/value.html)
method that uses the
`transform` function to map the current value of the animation
(between 0.0 and 1.0), to the actual animation value.


The current value of the `Animation` object can be found in the
`.value` method. The evaluate function also performs some housekeeping,
such as ensuring that begin and end are returned when the
animation values are 0.0 and 1.0, respectively.


#### Tween.animate

[#](#tween-animate)

To use a `Tween` object, call `animate()` on the `Tween`,
passing in the controller object. For example,
the following code generates the
integer values from 0 to 255 over the course of 500 ms.


dart

```
AnimationController controller = AnimationController(
  duration: const Duration(milliseconds: 500),
  vsync: this,
);
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(controller);

```

content\_copy

infoNote

The `animate()` method returns an [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html),
not an [`Animatable`](https://api.flutter.dev/flutter/animation/Animatable-class.html).


The following example shows a controller, a curve, and a `Tween`:

dart

```
AnimationController controller = AnimationController(
  duration: const Duration(milliseconds: 500),
  vsync: this,
);
final Animation<double> curve = CurvedAnimation(
  parent: controller,
  curve: Curves.easeOut,
);
Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);

```

content\_copy

### Animation notifications

[#](#animation-notifications)

An [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html)
object can have `Listener` s and `StatusListener` s,
defined with `addListener()` and `addStatusListener()`.
A `Listener` is called whenever the value of the animation changes.
The most common behavior of a `Listener` is to call `setState()`

to cause a rebuild. A `StatusListener` is called when an animation begins,
ends, moves forward, or moves reverse, as defined by `AnimationStatus`.


## Codelabs, tutorials, and articles

[#](#codelabs-tutorials-and-articles)

The following resources are a good place to start learning
the Flutter animation framework. Each of these documents
shows how to write animation code.


- [Animations in Flutter codelab](https://codelabs.developers.google.com/advanced-flutter-animations)



   Learn about implicit and explicit animations
   while building a multiple-choice quiz game.

- [Animations tutorial](/ui/animations/tutorial)


   Explains the fundamental classes in the Flutter animation package
   (controllers, `Animatable`, curves, listeners, builders),
   as it guides you through a progression of tween animations using
   different aspects of the animation APIs. This tutorial shows
   how to create your own custom explicit animations.

- [Zero to One with Flutter, part 1](https://medium.com/dartlang/zero-to-one-with-flutter-43b13fd7b354)
   and [part 2](https://medium.com/dartlang/zero-to-one-with-flutter-part-two-5aa2f06655cb)



   Medium articles showing how to create an animated chart using tweening.

- [Casual games toolkit](/resources/games-toolkit/)


   A toolkit with game templates that contain examples of how to use Flutter
   animations.


## Other resources

[#](#other-resources)

Learn more about Flutter animations at the following links:

- There are several [animations packages](https://pub.dev/packages?q=topic%3Aanimation) available on pub.dev that contain
   pre-built animations for commonly used patterns, including:
   `Container` transforms, shared axis transitions,
   fade through transitions, and fade transitions.

- [Animation samples](https://github.com/flutter/samples/tree/main/animations#animation-samples)
   from the [Sample app catalog](https://github.com/flutter/samples).

- [Animation recipes](/cookbook/animation) from the Flutter cookbook.

- [Animation videos](https://www.youtube.com/@flutterdev/search?query=animation) from the Flutter YouTube channel.

- [Animations: overview](/ui/animations/overview)


   A look at some of the major classes in the
   animations library, and Flutter's animation architecture.

- [Animation and motion widgets](/ui/widgets/animation)


   A catalog of some of the animation widgets
   provided in the Flutter APIs.

- The [animation library](https://api.flutter.dev/flutter/animation/animation-library.html) in the
   [Flutter API documentation](https://api.flutter.dev)


   The animation API for the Flutter framework. This link
   takes you to a technical overview page for the library.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-21. [View source](https://github.com/flutter/website/blob/main/src/content/ui/animations/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/animations&page-source=https://github.com/flutter/website/blob/main/src/content/ui/animations/index.md "Report an issue with this page").