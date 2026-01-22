---
name: tap-drag-and-enter-text
description: How to test widgets for user interaction.
metadata:
  url: https://docs.flutter.dev/cookbook/testing/widget/tap-drag
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Tap, drag, and enter text

Many widgets not only display information, but also respond
to user interaction. This includes buttons that can be tapped,
and [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
for entering text.


To test these interactions, you need a way to simulate them
in the test environment. For this purpose, use the
[`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)
library.


The `WidgetTester` provides methods for entering text,
tapping, and dragging.


- [`enterText()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/enterText.html)
- [`tap()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/tap.html)
- [`drag()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/drag.html)

In many cases, user interactions update the state of the app. In the test
environment, Flutter doesn't automatically rebuild widgets when the state
changes. To ensure that the widget tree is rebuilt after simulating a user
interaction, call the [`pump()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pump.html)
or [`pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html)

methods provided by the `WidgetTester`.
This recipe uses the following steps:


1. Create a widget to test.
2. Enter text in the text field.
3. Ensure tapping a button adds the todo.
4. Ensure swipe-to-dismiss removes the todo.

## 1\. Create a widget to test

[#](#1-create-a-widget-to-test)

For this example,
create a basic todo app that tests three features:


1. Entering text into a `TextField`.
2. Tapping a `FloatingActionButton` to add the text to a list of todos.
3. Swiping-to-dismiss to remove the item from the list.

To keep the focus on testing,
this recipe won't provide a detailed guide on how to build the todo app.
To learn more about how this app is built,
see the relevant recipes:


- [Create and style a text field](/cookbook/forms/text-input)
- [Handle taps](/cookbook/gestures/handling-taps)
- [Create a basic list](/cookbook/lists/basic-list)
- [Implement swipe to dismiss](/cookbook/gestures/dismissible)

dart

```
class TodoList extends StatefulWidget {
  const TodoList({super.key});
​
  @override
  State<TodoList> createState() => _TodoListState();
}
​
class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(_appTitle)),
        body: Column(
          children: [
            TextField(controller: controller),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
​
                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

```

content\_copy

## 2\. Enter text in the text field

[#](#2-enter-text-in-the-text-field)

Now that you have a todo app, begin writing the test.
Start by entering text into the `TextField`.


Accomplish this task by:

1. Building the widget in the test environment.
2. Using the [`enterText()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/enterText.html)

    method from the `WidgetTester`.


dart

```
testWidgets('Add and remove a todo', (tester) async {
  // Build the widget
  await tester.pumpWidget(const TodoList());
​
  // Enter 'hi' into the TextField.
  await tester.enterText(find.byType(TextField), 'hi');
});

```

content\_copy

infoNote

This recipe builds upon previous widget testing recipes.
To learn the core concepts of widget testing,
see the following recipes:


- [Introduction to widget testing](/cookbook/testing/widget/introduction)
- [Finding widgets in a widget test](/cookbook/testing/widget/finders)

## 3\. Ensure tapping a button adds the todo

[#](#3-ensure-tapping-a-button-adds-the-todo)

After entering text into the `TextField`, ensure that tapping
the `FloatingActionButton` adds the item to the list.


This involves three steps:

1. Tap the add button using the [`tap()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/tap.html)
    method.

2. Rebuild the widget after the state has changed using the
    [`pump()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pump.html)
    method.

3. Ensure that the list item appears on screen.

dart

```
testWidgets('Add and remove a todo', (tester) async {
  // Enter text code...
​
  // Tap the add button.
  await tester.tap(find.byType(FloatingActionButton));
​
  // Rebuild the widget after the state has changed.
  await tester.pump();
​
  // Expect to find the item on screen.
  expect(find.text('hi'), findsOneWidget);
});

```

content\_copy

## 4\. Ensure swipe-to-dismiss removes the todo

[#](#4-ensure-swipe-to-dismiss-removes-the-todo)

Finally, ensure that performing a swipe-to-dismiss action on the todo
item removes it from the list. This involves three steps:


1. Use the [`drag()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/drag.html)

    method to perform a swipe-to-dismiss action.

2. Use the [`pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html)

    method to continually rebuild the widget tree until the dismiss
    animation is complete.

3. Ensure that the item no longer appears on screen.

dart

```
testWidgets('Add and remove a todo', (tester) async {
  // Enter text and add the item...
​
  // Swipe the item to dismiss it.
  await tester.drag(find.byType(Dismissible), const Offset(500, 0));
​
  // Build the widget until the dismiss animation ends.
  await tester.pumpAndSettle();
​
  // Ensure that the item is no longer on screen.
  expect(find.text('hi'), findsNothing);
});

```

content\_copy

## Complete example

[#](#complete-example)

dart

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
​
void main() {
  testWidgets('Add and remove a todo', (tester) async {
    // Build the widget.
    await tester.pumpWidget(const TodoList());
​
    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');
​
    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));
​
    // Rebuild the widget with the new item.
    await tester.pump();
​
    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);
​
    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));
​
    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();
​
    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });
}
​
class TodoList extends StatefulWidget {
  const TodoList({super.key});
​
  @override
  State<TodoList> createState() => _TodoListState();
}
​
class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(_appTitle)),
        body: Column(
          children: [
            TextField(controller: controller),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
​
                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/tap-drag.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/testing/widget/tap-drag&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/tap-drag.md "Report an issue with this page").