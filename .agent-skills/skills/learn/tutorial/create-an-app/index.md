---
name: create-an-app
description: Instructions on how to create a new Flutter app.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/create-an-app
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create an app

Learn the first steps to building a Flutter app, from creating a project to understanding widgets and hot reload.


[Watch on YouTube in a new tab: "First steps with Flutter"](https://www.youtube.com/watch/sE1M2EayFes)

### What you'll accomplish

terminalCreate a new Flutter project using the CLI

account\_treeUnderstand widgets and the widget tree

boltRun your app and use hot reload

* * *

## Steps

1

### What you'll build

keyboard\_arrow\_up

In this first section of the Flutter tutorial,
you'll build the core UI of an app called 'Birdle',
a game similar to [Wordle, the popular New York Times game](https://www.nytimes.com/games/wordle/index.html).


![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/birdle.png)

By the end of this tutorial, you'll have
learned the fundamentals of building Flutter UIs, and your app will
look like the following screenshot (and it'll even mostly work 😀).


Continue

2

### Create a new Flutter project

keyboard\_arrow\_up

The first step to building Flutter apps is to create a new project.
You create new apps with the [Flutter CLI tool](/reference/flutter-cli),
installed as part of the Flutter SDK.


Open your terminal or command prompt and run
the following command to create a new Flutter project:


```
$ flutter create birdle --empty

```

content\_copy

This creates a new Flutter project using the minimal "empty" template.

Continue

3

### Examine the code

keyboard\_arrow\_up

In your IDE, open the file at `lib/main.dart`.
Starting from the top, you'll see this code.


dart

```
import 'package:flutter/material.dart'; // Imports Flutter.
​
void main() {
  runApp(const MainApp());
}
// ...

```

content\_copy

The `main` function is the entry point to any Dart program,
and a Flutter app is just a **Dart** program.
The `runApp` method is part of the Flutter SDK,
and it takes a **widget** as an argument.
In this case, an instance of the `MainApp` widget is being passed in.


Just below the `main` function, you'll find the `MainApp` class declaration.

dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

```

content\_copy

`MainApp` is the **root widget**,
as it's the widget that's passed into `runApp`.
Within this widget, there's a `build` method that
returns another widget called `MaterialApp`.
Essentially, this is what a Flutter app is:
a composition of widgets that make
up a tree structure called the **widget tree.**

Your job as a Flutter developer is to
compose widgets from the SDK into larger, custom widgets that display a UI.


At the moment, the widget tree is quite simple:

![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/initial_widget_tree.png)

Continue

4

### Run your app

keyboard\_arrow\_up

1. In your terminal,
    navigate to the root directory of your created Flutter app:





```
$ cd birdle

```

content\_copy

2. Run the app using the Flutter CLI tool.





```
$ flutter run -d chrome

```

content\_copy



The app will build and launch in a new instance of Chrome.


![A screenshot that resembles the popular game Wordle.](/assets/images/docs/tutorial/hello_world.png)

Continue

5

### Use hot reload

keyboard\_arrow\_up

**Stateful hot reload**, if you haven't heard of it,
allows a running Flutter app to re-render updated business logic or UI code in
less than a second – all without losing your place in the app.


In your IDE, open the `main.dart` file and navigate to line ~15 and find this
code:


dart

```
child: Text('Hello World!'),

```

content\_copy

Change the text inside the string to anything you want.
Then, hot-reload your app by
pressing `r` in the terminal where the app is running.
The running app should instantly show your updated text.


Continue

6

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circle

terminalCreated your first Flutter project

You used `flutter create` with the `--empty` flag to scaffold a minimal Flutter project. The CLI generates the project structure and boilerplate code needed to get started.


account\_treeExplored the widget tree

Flutter UIs are built by composing **widgets** into a tree structure. The `runApp`
function takes a root widget, and that widget's `build` method returns other widgets, forming the
**widget tree**. Your job as a Flutter developer is to compose these widgets into custom UIs.


boltRan your app with hot reload

You ran your app with `flutter run` and experienced **stateful hot reload**, which lets you see code changes reflected in under a second without losing app state. Press
`r` in the terminal to trigger a hot reload.


Continue

7

### Test yourself

keyboard\_arrow\_up

### Create an App Quiz

1 / 2

**What is the purpose of the \`runApp\` function in a Flutter application?**

1. It compiles the Dart code into native machine code.







Not quite



Compilation happens before the app runs; \`runApp\` starts the Flutter framework with a root widget.

2. It takes a widget as an argument and makes it the root of the widget tree.







That's right!



The \`runApp\` function inflates the given widget and attaches it to the screen, making it the root of the widget tree.

3. It creates the \`main.dart\` file for the project.







Not quite



The file is created by \`flutter create\`; \`runApp\` is called at runtime.

4. It downloads Flutter dependencies from the internet.







Not quite



Dependencies are managed by \`flutter pub get\`, not \`runApp\`.


**How do you trigger a hot reload while a Flutter app is running in the terminal?**

1. Press \`h\` in the terminal.







Not quite



Pressing \`h\` shows help options; \`r\` triggers hot reload.

2. Press \`r\` in the terminal.







That's right!



Pressing \`r\` in the terminal where the app is running triggers a hot reload.

3. Stop and restart the app with \`flutter run\`.







Not quite



A full restart is not needed; hot reload is faster.

4. Save the file and wait for automatic reload.







Not quite



By default, you need to press \`r\` to trigger hot reload in the terminal.


PreviousNext question

Finish

[NextWidget fundamentals\
chevron\_right](/learn/tutorial/widget-fundamentals)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-20. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/create-an-app.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/create-an-app&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/create-an-app.md "Report an issue with this page").