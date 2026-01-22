---
name: stateful-widgets
description: Learn about StatefulWidgets and rebuilding Flutter UI.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/stateful-widget
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Stateful widgets

Learn when widgets need to be stateful and how to trigger UI updates with setState.

[Watch on YouTube in a new tab: "Stateful widgets in Flutter"](https://www.youtube.com/watch/Gzz8FwSlsUg)

### What you'll accomplish

change\_circleLearn when widgets need to be stateful

swap\_horizConvert a StatelessWidget to a StatefulWidget

refreshTrigger UI updates with setState

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

So far, your app displays a grid and an input field,
but the grid doesn't yet update to reflect the user's guesses.
When this app is complete, each tile in the next unfilled row should
update after each submitted user guess by:


- Displaying the correct letter.
- Changing color to reflect whether the letter is correct (green),
is in the word but at an incorrect position (yellow), or
doesn't appear in the word at all (grey).


To handle this dynamic behavior, you need to convert `GamePage` from a
`StatelessWidget` to a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).


Continue

2

### Why stateful widgets?

keyboard\_arrow\_up

When a widget's appearance or data needs to change during its lifetime,
you need a `StatefulWidget` and a companion `State`
object.
While the `StatefulWidget` itself is still immutable (its properties
can't change after creation), the `State` object is long-lived,
can hold mutable data, and can be rebuilt when that data changes,
causing the UI to update.


For example, the following widget tree imagines a simple app
that uses a stateful widget with a counter that
increases when the button is pressed.


![A diagram of a widget tree with a stateful widget and state object.](/assets/images/docs/tutorial/widget_tree_stateful.png)

Here is the basic `StatefulWidget` structure (doesn't do anything yet):

dart

```
class ExampleWidget extends StatefulWidget {
  ExampleWidget({super.key});
​
  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}
​
class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

```

content\_copy

Continue

3

### Convert `GamePage` to a stateful widget

keyboard\_arrow\_up

To convert the `GamePage` (or any other) widget from
a stateless widget to a stateful widget, do the following steps:


1. Change `GamePage` to extend `StatefulWidget` instead of `StatelessWidget`.

2. Create a new class named `_GamePageState`, that extends `State<GamePage>`.
    This new class will hold the mutable state and the `build` method.
    Move the `build` method and all properties _instantiated on the widget_

    from `GamePage` to the state object.

3. Implement the `createState()` method in `GamePage`, which
    returns an instance of `_GamePageState`.


lightbulbQuick assists

You don't have to manually do this work, as the Flutter plugins for
VS Code and IntelliJ provide ["quick assists"](/tools/android-studio#assists-quick-fixes)
that can
do this conversion for you.


Your modified code should look like this:

dart

```
class GamePage extends StatefulWidget {
  GamePage({super.key});
​
  @override
  State<GamePage> createState() => _GamePageState();
}
​
class _GamePageState extends State<GamePage> {
  final Game _game = Game();
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
                    child: Tile(letter),
                  )
              ],
            ),
          GuessInput(
            onSubmitGuess: (_) {
              // TODO, handle guess
              print(guess); // Temporary
            },
          ),
        ],
      ),
    );
  }
}

```

content\_copy

Continue

4

### Updating the UI with `setState`

keyboard\_arrow\_up

Whenever you mutate a `State` object,
you must call [`setState`](https://api.flutter.dev/flutter/widgets/State/setState.html)
to signal the framework to
update the user interface and call the `build` method again.


In this app, when a user makes a guess, the word they guessed is
saved on the `Game` object, which is a property on the `GamePage`
class,
and therefore is state that might change and require the UI to update.
When this state is mutated, the grid should be
re-drawn to show the user's guess.


To implement this, update the callback function passed to `GuessInput`.
The function needs to call `setState` and, within `setState`,
it needs to execute the logic to determine whether the users guess was correct.


infoNote

The game logic is abstracted away into the `Game` object,
and outside the scope of this tutorial.


Update your code:

dart

```
class GamePage extends StatefulWidget {
  GamePage({super.key});
​
  @override
  State<GamePage> createState() => _GamePageState();
}
​
class _GamePageState extends State<GamePage> {
  final Game _game = Game();
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
                    child: Tile(letter),
                  )
              ],
            ),
          GuessInput(
           onSubmitGuess: (String guess) {
              setState(() { // NEW
                _game.guess(guess);
              });
            },
          ),
        ],
      ),
    );
  }
}

```

content\_copy

Now, when you type a legal guess into the `TextInput` and submit it,
the application will reflect the user's guess.
If you were to call `_game.guess(guess)` _without_ a calling
`setState`,
the internal game data would change, but Flutter wouldn't know it
needs to repaint the screen, and the user wouldn't see any updates.


Continue

5

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circlechange\_circleLearned when widgets need to be statefulkeyboard\_arrow\_up

When a widget's appearance or data needs to change during its lifetime, you need a `StatefulWidget`. The widget itself stays immutable, but its companion
`State` object holds mutable data and triggers rebuilds.


swap\_horizConverted GamePage to a StatefulWidgetkeyboard\_arrow\_up

You refactored `GamePage` to be stateful by creating a companion `_GamePageState`
class, moving the `build` method and mutable properties to it, and implementing `createState()`. Your IDE's support for quick assists can automate this conversion.


refreshMade your app respond to user input with setStatekeyboard\_arrow\_up

Calling `setState` tells Flutter to rebuild the UI of a widget. When a user submits a guess, you call
`setState` to update the game state, and the grid automatically reflects the new data. Your app is now truly interactive!


Continue

6

### Test yourself

keyboard\_arrow\_up

### Stateful Widgets Quiz

1 / 2

**When should you use a StatefulWidget instead of a StatelessWidget?**

1. When the widget needs to make HTTP requests.







Not quite



HTTP requests can be made from either, but state changes require StatefulWidget.

2. When the widget's appearance or data needs to change during its lifetime.







That's right!



StatefulWidget is needed when the UI must update in response to data changes over time.

3. When the widget has more than three child widgets.







Not quite



The number of children doesn't determine whether a widget is stateful.

4. When the widget is at the root of the widget tree.







Not quite



Root widgets can be stateless; statefulness depends on whether data changes during the widget's lifetime.


**What happens if you change data in a State object without calling setState?**

1. The app will crash with an error.







Not quite



The app won't crash, but the UI won't update.

2. The data changes internally, but Flutter won't rebuild the UI to reflect the change.







That's right!



Without calling setState, Flutter doesn't know it needs to repaint, so the user won't see updates.

3. Flutter automatically detects the change and rebuilds the UI.







Not quite



Flutter requires setState to know when to rebuild; it doesn't auto-detect changes.

4. The widget is removed from the widget tree.







Not quite



The widget remains; it just won't visually update without setState.


PreviousNext question

Finish

[chevron\_left\
PreviousHandle user input](/learn/tutorial/user-input) [NextAdd implicit animations\
chevron\_right](/learn/tutorial/implicit-animations)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-20. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/stateful-widget.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/stateful-widget&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/stateful-widget.md "Report an issue with this page").