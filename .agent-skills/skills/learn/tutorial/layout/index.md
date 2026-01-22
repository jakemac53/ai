---
name: layout
description: Learn about common layout widgets in Flutter.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/layout
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Layout

Learn how to build layouts with common widgets like Scaffold, AppBar, Column, and Row.

[Watch on YouTube in a new tab: "Flutter layout and constraints"](https://www.youtube.com/watch/z8bY3XVAzgI)

### What you'll accomplish

web\_assetStructure an app with Scaffold and AppBar

view\_columnArrange widgets using Column and Row

repeatGenerate widgets dynamically from data

grid\_viewBuild a grid layout for the game board

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

Given that Flutter is a UI toolkit,
you'll spend a lot of time creating layouts with Flutter widgets.


In this section, you'll learn how to build layouts with
some of the most common layout widgets.
This includes high-level widgets like
[`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html)
and [`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html), which lay out the structure of a screen,
as well as lower-level widgets like [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
or [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) that
lay out widgets vertically or horizontally.


Continue

2

### `Scaffold` and `AppBar`

keyboard\_arrow\_up

Mobile applications often have a bar at the top called an "app bar" that can
display a title, navigation controls, and/or actions.


![A screenshot of a simple application with a bar across the top that has a title and settings button.](/assets/images/docs/tutorial/appbar.png)

The simplest way to add an app bar to your app is by using two widgets:
`Scaffold` and `AppBar`.


`Scaffold` is a convenience widget that provides a Material-style page layout,
making it simple to add an app bar, drawer, navigation bar, and more to a page of
your app. `AppBar` is, of course, the app bar.


The code generated from the `flutter create --empty` command already
contains an `AppBar` widget and a `Scaffold` widget.
The following code updates it to use an additional layout widget: [`Align`](https://api.flutter.dev/flutter/widgets/Align-class.html).
This positions the title to the left, which would be centered by default.
The `Text` widget contains the title itself.


Modify the `Scaffold` within your `MainApp` widget's `build` method:


dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text('Birdle'),
          ),
        ),
        body: Center(child: Tile('A', HitType.hit)),
      ),
    );
  }
}

```

content\_copy

#### An updated widget tree

[#](#an-updated-widget-tree)

Considering your app's widget tree gets more important as your app grows.
At this point, there's a "branch" in the widget tree for the first time,
and it now looks like the following figure:


![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/widget_tree_with_app_bar.png)

Continue

3

### Create a widget for the game page layout

keyboard\_arrow\_up

Add the following code for a new widget,
called `GamePage`, to your `main.dart` file.
This widget will eventually display the UI elements needed for the game itself.


lib/main.dart

dart

```
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  // This object is part of the game.dart file.
  // It manages wordle logic, and is outside the scope of this tutorial.
  final Game _game = Game();
​
  @override
  Widget build(BuildContext context) {
    // TODO: Replace with screen contents
    return Container();
  }
}

```

content\_copy

infoChallenge - Display the `GamePage` rather than a `Tile`.

**Solution:**

solution.dartkeyboard\_arrow\_up

dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Changed from `Tile`
        body: Center(child: GamePage()),
      ),
    );
  }
}

```

content\_copy

Continue

4

### Arrange widgets with `Column` and `Row`

keyboard\_arrow\_up

The `GamePage` layout contains the grid of tiles that display a user's guesses.

![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/birdle.png)

There are a number of ways you can build this layout.
The simplest is with the `Column` and `Row` widgets.
Each row contains five tiles that represent the five letters in a guess,
with five rows total.
So you'll need a single `Column` with five `Row` widgets as children,
where each row contains five children.


To get started, replace the `Container` in `GamePage.build` with a
`Padding` widget with a `Column` widget as its child:


dart

```
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  // This manages game logic, and is out of scope for this lesson.
  final Game _game = Game();
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          // Add children next.
        ],
      ),
    );
  }
}

```

content\_copy

The `spacing` property puts five pixels between each element on the main axis.

Within `Column.children`, for each element in the `_game.guesses` list,
add a `Row` widget as a child.


infoNote

This `guesses` list is a **fixed-size** list, starting with five
elements, one for each _potential_ guess.
The list will always contain exactly five elements,
and therefore will always render five rows.


dart

```
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  // This manages game logic, and is out of scope for this lesson.
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
                // We'll add the tiles here later.
              ]
            ),
        ],
      ),
    );
  }
}

```

content\_copy

The `for` loop in the `children` list is called a [collection for element](https://dart.dev/language/collections#for-element),
a Dart syntax that allows you to iteratively add items to a collection
when it is built at runtime.
This syntactic sugar makes it easier for you to work
with collections of widgets,
providing a declarative alternative to the following:


dart

```
[..._game.guesses.map((guess) => Row(/* ... */))],

```

content\_copy

In this case, it adds five `Row` widgets to the column,
one for each guess on the `Game` object.


#### An updated widget tree

[#](#an-updated-widget-tree-1)

The widget tree for this app has expanded significantly in this lesson.
Now, it looks more like the following (abridged) figure:


![A diagram showing a tree like structure with a node for each widget in the app.](/assets/images/docs/tutorial/widget_tree_rows_columns.png)

infoChallenge

Add a `Tile` to each row for each letter allowed in the guess.
The `guess` variable in the loop is a [record](https://dart.dev/language/records)
with the type
`({String char, HitType type})`.


**Solution:**

dart

```
class GamePage extends StatelessWidget {
  const GamePage({super.key});
  // This manages game logic, and is out of scope for this lesson.
  final Game _game = Game();
​
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
                  for (var letter in guess)
                    Tile(letter.char, letter.type),
                ]
              ),
          ],
      ),
    );
  }
}

```

content\_copy

When you reload your app, you should see a 5x5 grid of white squares.

![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/grid_of_tiles.png)

Continue

5

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circleweb\_assetStructured your app with Scaffold and AppBarkeyboard\_arrow\_up

You used `Scaffold` to provide a Material-style page layout and `AppBar` to add a title bar at the top of your app. These high-level widgets give your app a standard, yet polished structure.


view\_columnArranged widgets using Column and Rowkeyboard\_arrow\_up

`Column` arranges widgets vertically and `Row` arranges them horizontally. These are fundamental layout widgets you'll use constantly in Flutter. The
`spacing` property adds consistent gaps between children.


repeatGenerated widgets dynamically from datakeyboard\_arrow\_up

You used a collection for element to build widgets from a list. This declarative approach lets you build user interfaces that automatically and visually reflect your data, a pattern central to Flutter development.


grid\_viewBuilt the game board gridkeyboard\_arrow\_up

By nesting `Row` widgets inside a `Column` and using nested loops, you created a 5x5 grid of
`Tile` widgets. Your app now displays the complete game board layout!


Continue

6

### Test yourself

keyboard\_arrow\_up

### Layout Quiz

1 / 2

**What is the primary difference between a Column and a Row widget?**

1. Column is for scrolling content; Row is for static content.







Not quite



Both Column and Row are for layout, not scrolling. Use ListView or SingleChildScrollView for scrolling.

2. Column arranges children vertically; Row arranges children horizontally.







That's right!



Column lays out its children along the vertical axis, while Row uses the horizontal axis.

3. Column can have unlimited children; Row is limited to two.







Not quite



Both widgets can have any number of children.

4. Column requires a Scaffold parent; Row does not.







Not quite



Neither widget requires a Scaffold as a parent.


**What does the Scaffold widget provide in a Flutter app?**

1. Only a background color for the page.







Not quite



Scaffold provides much more, including structure for app bars, drawers, and more.

2. A Material-style page layout with slots for app bar, body, drawer, and more.







That's right!



Scaffold is a convenience widget that provides a standard Material page structure.

3. A way to navigate between different pages.







Not quite



Navigation is handled by Navigator, not Scaffold.

4. Automatic state management for the page.







Not quite



Scaffold doesn't manage state; you use StatefulWidget or state management solutions for that.


PreviousNext question

Finish

[chevron\_left\
PreviousWidget fundamentals](/learn/tutorial/widget-fundamentals) [NextDevTools\
chevron\_right](/learn/tutorial/devtools)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-20. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/layout.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/layout&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/layout.md "Report an issue with this page").