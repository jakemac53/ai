---
name: send-data-to-a-new-screen
description: How to pass data to a new route.
metadata:
  url: https://docs.flutter.dev/cookbook/navigation/passing-data
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Send data to a new screen

Often, you not only want to navigate to a new screen,
but also pass data to the screen as well.
For example, you might want to pass information about
the item that's been tapped.


Remember: Screens are just widgets.
In this example, create a list of todos.
When a todo is tapped, navigate to a new screen (widget) that
displays information about the todo.
This recipe uses the following steps:


1. Define a todo class.
2. Display a list of todos.
3. Create a detail screen that can display information about a todo.
4. Navigate and pass data to the detail screen.

## 1\. Define a todo class

[#](#1-define-a-todo-class)

First, you need a simple way to represent todos. For this example,
create a class that contains two pieces of data: the title and description.


dart

```
class Todo {
  final String title;
  final String description;
​
  const Todo(this.title, this.description);
}

```

content\_copy

## 2\. Create a list of todos

[#](#2-create-a-list-of-todos)

Second, display a list of todos. In this example, generate
20 todos and show them using a ListView.
For more information on working with lists,
see the [Use lists](/cookbook/lists/basic-list) recipe.


### Generate the list of todos

[#](#generate-the-list-of-todos)

dart

```
final todos = List.generate(
  20,
  (i) => Todo(
    'Todo $i',
    'A description of what needs to be done for Todo $i',
  ),
);

```

content\_copy

### Display the list of todos using a ListView

[#](#display-the-list-of-todos-using-a-listview)

dart

```
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(title: Text(todos[index].title));
  },
)

```

content\_copy

So far, so good.
This generates 20 todos and displays them in a ListView.


## 3\. Create a Todo screen to display the list

[#](#3-create-a-todo-screen-to-display-the-list)

For this, we create a `StatelessWidget`. We call it `TodosScreen`.
Since the contents of this page won't change during runtime,
we'll have to require the list
of todos within the scope of this widget.


We pass in our `ListView.builder` as body of the widget we're returning to `build()`.
This'll render the list on to the screen for you to get going!


dart

```
class TodosScreen extends StatelessWidget {
  // Requiring the list of todos.
  const TodosScreen({super.key, required this.todos});
​
  final List<Todo> todos;
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      //passing in the ListView.builder
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(todos[index].title));
        },
      ),
    );
  }
}

```

content\_copy

With Flutter's default styling, you're good to go without sweating about
things that you'd like to do later on!


## 4\. Create a detail screen to display information about a todo

[#](#4-create-a-detail-screen-to-display-information-about-a-todo)

Now, create the second screen. The title of the screen contains the
title of the todo, and the body of the screen shows the description.


Since the detail screen is a normal `StatelessWidget`,
require the user to enter a `Todo` in the UI.
Then, build the UI using the given todo.


dart

```
class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});
​
  // Declare a field that holds the Todo.
  final Todo todo;
​
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}

```

content\_copy

## 5\. Navigate and pass data to the detail screen

[#](#5-navigate-and-pass-data-to-the-detail-screen)

With a `DetailScreen` in place,
you're ready to perform the Navigation.
In this example, navigate to the `DetailScreen` when a user
taps a todo in the list. Pass the todo to the `DetailScreen`.


To capture the user's tap in the `TodosScreen`, write an [`onTap()`](https://api.flutter.dev/flutter/material/ListTile/onTap.html)

callback for the `ListTile` widget. Within the `onTap()` callback,
use the [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)
method.


dart

```
body: ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(todos[index].title),
      // When a user taps the ListTile, navigate to the DetailScreen.
      // Notice that you're not only creating a DetailScreen, you're
      // also passing the current todo through to it.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => DetailScreen(todo: todos[index]),
          ),
        );
      },
    );
  },
),

```

content\_copy

### Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          20,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.todo});

  // Declare a field that holds the Todo.
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}
```

## Alternatively, pass the arguments using RouteSettings

[#](#alternatively-pass-the-arguments-using-routesettings)

Repeat the first two steps.

### Create a detail screen to extract the arguments

[#](#create-a-detail-screen-to-extract-the-arguments)

Next, create a detail screen that extracts and displays the title and description from the `Todo`. To access the
`Todo`, use the [`ModalRoute.of()`](https://api.flutter.dev/flutter/widgets/ModalRoute/of.html)
method. This method returns the current route with the arguments.


dart

```
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
​
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
​
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}

```

content\_copy

### Navigate and pass the arguments to the detail screen

[#](#navigate-and-pass-the-arguments-to-the-detail-screen)

Finally, navigate to the `DetailScreen` when a user taps
a `ListTile` widget using `Navigator.push()`.
Pass the arguments as part of the [`RouteSettings`](https://api.flutter.dev/flutter/widgets/RouteSettings-class.html).
The `DetailScreen` extracts these arguments.


dart

```
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(todos[index].title),
      // When a user taps the ListTile, navigate to the DetailScreen.
      // Notice that you're not only creating a DetailScreen, you're
      // also passing the current todo through to it.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const DetailScreen(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(arguments: todos[index]),
          ),
        );
      },
    );
  },
)

```

content\_copy

### Complete example

[#](#complete-example)

dart

```
import 'package:flutter/material.dart';
​
class Todo {
  final String title;
  final String description;
​
  const Todo(this.title, this.description);
}
​
void main() {
  runApp(
    MaterialApp(
      title: 'Passing Data',
      home: TodosScreen(
        todos: List.generate(
          20,
          (i) => Todo(
            'Todo $i',
            'A description of what needs to be done for Todo $i',
          ),
        ),
      ),
    ),
  );
}
​
class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});
​
  final List<Todo> todos;
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const DetailScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(arguments: todos[index]),
                ),
              );
            },
          );
        },
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
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
​
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(todo.description),
      ),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/passing-data.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/navigation/passing-data&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/passing-data.md "Report an issue with this page").