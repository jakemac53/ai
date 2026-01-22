---
name: devtools
description: Learn to use the Dart DevTools when developing Flutter apps.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/devtools
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# DevTools

Learn to use the widget inspector and property editor to debug layout issues and experiment with properties in real-time.


[Watch on YouTube in a new tab: "Intro to Flutter and Dart DevTools"](https://www.youtube.com/watch/CIfLE0CShbg)

### What you'll accomplish

account\_treeExplore your app's widget tree with the widget inspector

bug\_reportLearn to debug layout issues like unbounded constraints

tuneExperiment with properties in real-time

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

As your Flutter app grows in complexity, it becomes more important
to understand how each of the widget properties affects the UI.
The [Dart and Flutter DevTools](/tools/devtools) provide you with
two particularly useful features:
the **widget inspector** and the **property editor**.


First, launch DevTools by running the following commands while
your app is running in debug mode:


```
$ dart devtools

```

content\_copy

infoRun in your IDE

Provided you have the appropriate Flutter plugin installed,
you can also run DevTools directly inside
Code OSS-based editors such as [VS Code](/tools/vs-code) as well as
[IntelliJ and Android Studio](/tools/android-studio).
The screenshots in this lesson are from VS Code.


Continue

2

### The widget inspector

keyboard\_arrow\_up

The widget inspector allows you to visualize and explore your widget tree.
It helps you understand the layout of your UI and
identifies which widgets are responsible for different parts of the screen.
Running against the app you've built so far, the inspector looks like this:


![A screenshot of the Flutter widget inspector tool.](/assets/images/docs/tutorial/widget_inspector.png)

Consider the `GamePage` widget you created in this section:

dart

```
class GamePage extends StatelessWidget {
  const GamePage({super.key});
​
  final Game _game = Game();
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (var guess in _game.guesses)
            Row(
              spacing: 5.0,
              children: [
              for (var letter in guess) Tile(letter, )
              ]
            ),
        ],
      ),
    );
  }
}

```

content\_copy

And how it's used in `MainApp`:

dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: GamePage()),
      ),
    );
  }
}

```

content\_copy

In the widget inspector, you should see a tree of
exactly the same widgets that are in your code:
`MaterialApp` as the root, with `Scaffold` as its
`home`,
an `AppBar` as its `appBar`, and so on down the entire tree to
the `Row` widgets with `Tile` children.
You can select any widget in the tree to see its properties and
even jump to its source code in your IDE.


Continue

3

### Debugging layout issues

keyboard\_arrow\_up

The widget inspector is perhaps most useful for debugging layout issues.

In certain situations,
a widget's [constraints](/ui/layout/constraints) are unbounded, or infinite.
This means that either
the maximum width or the maximum height is set to [`double.infinity`](https://api.flutter.dev/flutter/dart-core/double/infinity-constant.html).
A widget that tries to be as big as possible won't function usefully when
given an unbounded constraint and, in debug mode, throws an exception.


The most common case where a render box ends up with an unbounded
constraint is within a flex box widget ( [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html)
or [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)),
and within a scrollable region,
such as a [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
or [`ScrollView`](https://api.flutter.dev/flutter/widgets/ScrollView-class.html)
subclasses.


`ListView`, for example, tries to expand to
fit the space available in its cross-direction. Such as if
it's a vertically scrolling block that tries to be as wide as its parent.
If you nest a vertically scrolling `ListView` inside
a horizontally scrolling `ListView`, the inner list tries to
be as wide as possible, which is infinitely wide, since the
outer one is scrollable in that direction.


Perhaps the most common error you'll run into while
building a Flutter application is due to incorrectly using layout widgets.
This error is referred to as the "unbounded constraints" error.


Watch the following video to get an understanding of how to
spot and resolve this issue.


[Watch on YouTube in a new tab: "Decoding Flutter: Unbounded height and width"](https://www.youtube.com/watch/jckqXR5CrPI)

Continue

4

### The property editor

keyboard\_arrow\_up

When you select a widget in the widget inspector,
the property editor displays all the properties of that selected widget.
This is a powerful tool for understanding why a widget looks the way it does and
for experimenting with property value changes in real-time.


![A screenshot of the Flutter property editor tool.](/assets/images/docs/tutorial/property_editor.png)

Look at the `Tile` widget's `build` method from earlier:

dart

```
class Tile extends StatelessWidget {
  const Tile(required this.letter, required hitType, {super.key});
​
  final String letter;
  final HitType hitType;
​
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
    );
  }
}

```

content\_copy

If you select a `Tile` widget in the widget inspector,
the property editor would show you its
`width` (60), `height` (60), and the `decoration`
property.
You could then expand the `BoxDecoration` to
see the `border` and `color` properties.


For many properties, you can even
modify their values directly within the property editor.
For example, to quickly test how a different `width` or `height`
would look
for your `Container` in the `Tile` widget,
change the numerical value in the property editor.
Then instantly see the update on your running app without
needing to recompile or even hot reload.
This allows for rapid iteration on UI design.


Continue

5

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circleaccount\_treeExplored your app's widget tree with the widget inspectorkeyboard\_arrow\_up

The widget inspector lets you visualize your entire widget tree, select any widget to view its properties, and jump directly to its source code. It's an essential tool for understanding your app's structure.


bug\_reportLearned about common layout issueskeyboard\_arrow\_up

You learned about **unbounded constraints**, one of the most common errors hit in Flutter development. This happens when widgets like
`Row`, `Column`, or `ListView` receive infinite constraints. Now you can recognize and fix these issues when they occur.


bug\_reportLearned about common layout issueskeyboard\_arrow\_up

You learned about **unbounded constraints**, one of the most common errors hit in Flutter development. This happens when widgets like
`Row`, `Column`, or `ListView` receive infinite constraints. Now you can recognize and fix these issues when they occur.


tuneExperimented with properties in real-timekeyboard\_arrow\_up

The property editor shows all properties of a selected widget and lets you modify values instantly with no recompiling or hot reload needed. This enables rapid iteration when fine-tuning your UI.


Continue

6

### Test yourself

keyboard\_arrow\_up

### DevTools Quiz

1 / 2

**What is a common cause of "unbounded constraints" errors in Flutter?**

1. Using too many StatefulWidgets in the widget tree.







Not quite



StatefulWidget usage doesn't cause unbounded constraints.

2. Placing a widget that tries to expand infinitely inside a scrollable or flex container without proper constraints.







That's right!



Widgets like ListView inside a Row, or nested scrollables, can receive infinite constraints and fail.

3. Forgetting to call setState after changing data.







Not quite



Missing setState causes UI not to update, not constraint errors.

4. Using Container without specifying a color.







Not quite



Color is optional and unrelated to layout constraints.


**What can you do with the Widget Inspector in Flutter DevTools?**

1. Automatically generate unit tests for your widgets.







Not quite



The Widget Inspector is for visualization and debugging, not test generation.

2. Visualize your widget tree, select widgets to view their properties, and jump to source code.







That's right!



The Widget Inspector lets you explore your app's structure, inspect widget properties, and navigate to the corresponding source code.

3. Deploy your app directly to the app store.







Not quite



Deployment is handled separately; the Widget Inspector is for debugging.

4. Edit your app's theme colors and typography.







Not quite



Theme editing requires code changes; the Widget Inspector is for inspecting the current state.


PreviousNext question

Finish

[chevron\_left\
PreviousLayout widgets on a screen](/learn/tutorial/layout) [NextHandle user input\
chevron\_right](/learn/tutorial/user-input)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-20. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/devtools.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/devtools&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/devtools.md "Report an issue with this page").