---
name: user-input
description: Accept input from the user with buttons and text fields.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/user-input
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# User input

Learn to build text inputs, manage text with controllers, and handle user actions with buttons.

### What you'll accomplish

text\_fieldsBuild a text input widget with TextField

edit\_noteManage text with TextEditingController

center\_focus\_strongControl input focus for a better user experience

touch\_appHandle user actions with callbacks and buttons

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

The app will display the user's guesses in the `Tile` widgets,
but it needs a way for the user to input those guesses.
In this lesson, build that functionality with two interaction widgets:
[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
and [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html).


Continue

2

### Implement callback functions

keyboard\_arrow\_up

To allow users to type in their guesses,
you'll create a dedicated widget named `GuessInput`.
First, create the basic structure for your `GuessInput` widget that
requires a callback function as an argument.
Name the callback function `onSubmitGuess`.


Add the following code to your `main.dart` file.

dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  @override
  Widget build(BuildContext context) {
    // You'll build the UI in the next steps.
    return Container(); // Placeholder
  }
}

```

content\_copy

The line `final void Function(String) onSubmitGuess;`
declares a `final` member of the class called `onSubmitGuess`

that has the type `void Function(String)`.
This function takes a single `String` argument (the user's guess) and
doesn't return any value (denoted by `void`).


This callback tells us that the logic that
actually handles the user's guess will be written elsewhere.
It's a good practice for interactive widgets to
use callback functions to keep the widget that handles interactions reusable and
decoupled from any specific functionality.


By the end of this lesson, the passed-in `onGuessSubmitted` function
is called when a user enters a guess.
First, you'll need to build the visual parts of this widget.
This is what the widget will look like.


![A screenshot of the Flutter property editor tool.](/assets/images/docs/tutorial/app_with_input.png)

Continue

3

### The `TextField` widget

keyboard\_arrow\_up

Given that the text field and button are displayed side-by-side,
create them as a `Row` widget.
Replace the `Container` placeholder in your `build`
method with
a `Row` containing an `Expanded` `TextField`:


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  @override
  Widget build(BuildContext context) {
     return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

You have seen some of these widgets in previous lessons:
`Row` and `Padding`. New, though, is the [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
widget.
When a child of a `Row` (or `Column`) is wrapped in
`Expanded`,
it tells that child to fill all the available space along the main axis
(horizontal for `Row`, vertical for `Column`) that
hasn't been taken by other children.
This makes the `TextField` stretch to take up all the space _except_

what's taken by other widgets in the row.


lightbulbTip

`Expanded` is often the solution to " [unbounded width/height](https://www.youtube.com/watch?v=jckqXR5CrPI)" exceptions.


The `TextField` widget is also new in this lesson and is the star of the show.
This is the basic Flutter widget for text input.


Thus far, `TextField` has the following configuration.

- It's decorated with a rounded border.
Notice that the decoration configuration is
very similar to how a `Container` and boxes are decorated.

- Its `maxLength` property is set to 5 because the game
only allows guesses of 5-letter words.


Continue

4

### Handle text with `TextEditingController`

keyboard\_arrow\_up

Next, you need a way to manage the text that
the user types into the input field.
For this, use a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html).


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  // NEW
  final TextEditingController _textEditingController = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}

```

content\_copy

A `TextEditingController` is used to
read, clear, and modify the text in a `TextField`.
To use it, pass it into the `TextField`.


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController, // NEW
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

Now, when a user inputs text, you can
capture it with the `_textEditingController`, but
you'll need to know _when_ to capture it.
The simplest way to react to input is by
using the `TextField.onSubmitted` argument.
This argument accepts a callback, and the callback is triggered whenever
the user presses the "Enter" key on the keyboard while the text field has focus.


For now, ensure that this works by
adding the following callback to `TextField.onSubmitted`:


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (String input) { // NEW
                print(_textEditingController.text); // Temporary
              }
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

In this case,
you could print the `input` passed to the `onSubmitted`
callback directly,
but a better user experience clears the text after each guess:
You need a `TextEditingController` to do that. Update the code as follows:


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (_) { // UPDATED
                print(_textEditingController.text); // Temporary
                _textEditingController.clear(); // NEW
              }
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

infoNote

In Dart, it's good practice to use the `_` [wildcard](https://dart.dev/language/variables#wildcard-variables)
to
hide the input to a function that'll never be used.
The preceding example does so.


Continue

5

### Gain input focus

keyboard\_arrow\_up

Often, you want a specific input or widget to
automatically gain focus without the user taking action.
In this app, for example, the only thing a user can do is enter a guess,
so the `TextField` should be focused automatically when the app launches.
And after the user enters a guess, the focus should stay
in the `TextField` so they can enter their next guess.


To resolve the first focus issue,
set up the `autofocus` property on the `TextField`.


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              autofocus: true, // NEW
              onSubmitted: (String input) {
                print(input); // Temporary
                _textEditingController.clear();
              }
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

The second issue requires you to
use a [`FocusNode`](https://api.flutter.dev/flutter/widgets/FocusNode-class.html)
to manage the keyboard focus.
You can use `FocusNode` to request that a `TextField`
gain focus,
(making the keyboard appear on mobile),
or to know when a field has focus.


First, create a `FocusNode` in the `GuessInput` class:

dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  final FocusNode _focusNode = FocusNode(); // NEW
​
  @override
  Widget build(BuildContext context) {
    // ...
  }
}

```

content\_copy

Then, use the `FocusNode` to request focus whenever
the `TextField` is submitted after the controller is cleared:


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  final FocusNode _focusNode = FocusNode();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              autofocus: true,
              focusNode: _focusNode, // NEW
              onSubmitted: (String input) {
                print(input); // Temporary
                _textEditingController.clear();
                _focusNode.requestFocus(); // NEW
              }
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

Now, when you press `Enter` after inputting text,
you can continue typing.


Continue

6

### Use the input

keyboard\_arrow\_up

Finally, you need to handle the text that the user enters.
Recall that the constructor for `GuessInput` requires a
callback called `onGuessSubmitted`.
In `GuessInput`, you need to use that callback.
Replace the `print` statement with a call to that function.


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  final FocusNode _focusNode = FocusNode();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              autofocus: true,
              focusNode: _focusNode,
              onSubmitted: (String input) {
                onSubmitGuess(_textEditingController.text.trim());
                _textEditingController.clear();
                _focusNode.requestFocus();
              }
            ),
          ),
        ),
      ],
    );
  }
}

```

content\_copy

infoNote

The `trim` function prevents whitespace from being entered;
otherwise, the user could enter a four-letter word plus a space character.


The remaining functionality is handled in the parent widget, `GamePage`.
In the `build` method of that class,
under the `Row` widgets in the `Column` widget's children,
add the `GuessInput` widget:


dart

```
class GamePage extends StatelessWidget {
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
                for (var letter in guess) Tile(letter),
              ],
            ),
          GuessInput(
            onSubmitGuess: (String guess) {
              // TODO, handle guess
              print(guess); // Temporary
            }
          ),
        ],
      ),
    );
  }
}

```

content\_copy

For the moment, this only prints the guess to
prove that it's wired up correctly.
Submitting the guess requires using the functionality of a `StatefulWidget`,
which you'll do in the next lesson.


Continue

7

### Buttons

keyboard\_arrow\_up

To improve the UX on mobile and reflect well-known UI practices,
there should also be a button that can submit the guess.


There are many button widgets built into Flutter, like [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html),
[`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html), and the button you'll use now:
[`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html).
All of these buttons (and many other interaction widgets) require two
arguments (in addition to their optional arguments):


- A callback function passed to `onPressed`.
- A widget that makes up the content of the button (often `Text` or an `Icon`).

Add an icon button to the row widget's children list in the `GuessInput` widget,
and give it an [`Icon`](https://api.flutter.dev/flutter/material/Icons-class.html)
widget to display.
The `Icon` widget requires configuration; in this case,
the `padding` property sets the padding between the
edge of the button and the icon it wraps to zero.
This removes the default padding and makes the button smaller.


dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(/* ... */),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
        ),
      ],
    );
  }
}

```

content\_copy

The `IconButton.onPressed` callback should look familiar:

dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(/* ... */),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: () {
            onSubmitGuess(_textEditingController.text.trim());
            _textEditingController.clear();
            _focusNode.requestFocus();
          },
        ),
      ],
    );
  }
}

```

content\_copy

This method does the same as the `onSubmitted` callback on the `TextField`.

infoChallenge - Share "on submitted" logic.

You might be thinking, "Shouldn't we abstract these methods into one
function and pass it to both inputs?"
You could, and as your app grows in complexity, you probably should.
That said, the callbacks `IconButton.onPressed` and `TextField.onSubmitted`
have
different signatures, so it's not completely straight-forward.


Refactor the code such that the logic inside this method isn't repeated.

**Solution:**

solution.dartkeyboard\_arrow\_up

dart

```
class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
​
  final void Function(String) onSubmitGuess;
​
  final TextEditingController _textEditingController = TextEditingController();
​
  final FocusNode _focusNode = FocusNode();
​
  void _onSubmit() {
    onSubmitGuess(_textEditingController.text);
    _textEditingController.clear();
    _focusNode.requestFocus();
  }
​
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              focusNode: _focusNode,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              onSubmitted: (String value) {
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: _onSubmit,
        ),
      ],
    );
  }
}

```

content\_copy

Continue

8

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circletext\_fieldsBuilt a text input widget with TextFieldkeyboard\_arrow\_up

You created a `GuessInput` widget with a `TextField` for text entry. You configured it with a rounded border, character limit, and used
`Expanded` to make it fill available space in the row.


edit\_noteManaged text with TextEditingControllerkeyboard\_arrow\_up

`TextEditingController` lets you read and modify text field content. You used it to capture the user's input with
`.text` and clear the field after submission with `.clear()`.


center\_focus\_strongControlled input focus for a polished UXkeyboard\_arrow\_up

You used `autofocus` to focus the text field on launch and `FocusNode` with `requestFocus()`
to maintain focus after each guess. These details make your app feel responsive and well-built.


touch\_appHandled user actions with callbacks and buttonskeyboard\_arrow\_up

To respond to user input, you specified callback functions like `onSubmitted` and `onPressed`. Passing callback functions as constructor arguments keeps your widgets reusable and decoupled from specific logic.


Continue

9

### Test yourself

keyboard\_arrow\_up

### User Input Quiz

1 / 2

**How do you programmatically read or clear the text in a TextField?**

1. Access the TextField's text property directly.







Not quite



TextField doesn't expose a text property; you need a controller.

2. Use the TextEditingController attached to the TextField.







That's right!



TextEditingController provides the text property to read the value and clear() method to reset it.

3. Listen to the onChanged callback and store the value in a variable.







Not quite



While onChanged works for reading, clearing requires a TextEditingController.

4. Call TextField.getText() method.







Not quite



TextField doesn't have a getText method; use TextEditingController instead.


**How do you programmatically move focus to a specific TextField?**

1. Call \`TextField.focus()\` directly.







Not quite



TextField doesn't have a focus method; you use a FocusNode.

2. Set the \`autofocus\` property to true at runtime.







Not quite



The 'autofocus' property only works on initial build, not for moving focus later.

3. Use a FocusNode and call \`requestFocus()\` on it.







That's right!



A FocusNode gives you control over focus, and calling \`requestFocus()\` moves focus to its associated widget.

4. Wrap the TextField in a GestureDetector and tap programmatically.







Not quite



This is not how focus is managed; FocusNode is the proper approach.


PreviousNext question

Finish

[chevron\_left\
PreviousDevTools](/learn/tutorial/devtools) [NextLearn about stateful widgets\
chevron\_right](/learn/tutorial/stateful-widget)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-16. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/user-input.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/user-input&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/user-input.md "Report an issue with this page").