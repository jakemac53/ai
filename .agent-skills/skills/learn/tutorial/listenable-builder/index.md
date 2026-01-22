---
name: rebuild-ui-when-state-changes
description: Instructions on how to manage state with ChangeNotifiers.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/listenable-builder
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Rebuild UI when state changes

Learn to use ListenableBuilder to automatically rebuild UI and handle all possible states with switch expressions.


### What you'll accomplish

syncUse ListenableBuilder to rebuild UI automatically

alt\_routeHandle all possible states with switch expressions

articleBuild the complete View layer with proper styling

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

The view layer is your UI, and in Flutter,
that refers to your app's widgets.
As it pertains to this tutorial, the important part is
wiring up your UI to respond to data changes from the ViewModel.
[`ListenableBuilder`](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html)
is a widget that can "listen" to a
[`ChangeNotifier`](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), and automatically rebuilds when it's
provided `ChangeNotifier` calls `notifyListeners()`.


Continue

2

### Create the article view widget

keyboard\_arrow\_up

Create the `ArticleView` widget that
manages the overall page layout and state handling.
Start with the basic class structure and widgets:


dart

```
class ArticleView extends StatelessWidget {
  ArticleView({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: const Center(
        child: Text('UI will update here'),
      ),
    );
  }
}

```

content\_copy

Continue

3

### Create the article view model

keyboard\_arrow\_up

Create the `ArticleViewModel` in this widget:

dart

```
class ArticleView extends StatelessWidget {
  ArticleView({super.key});
​
  final viewModel = ArticleViewModel(ArticleModel());
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: const Center(
        child: Text('UI will update here'),
      ),
    );
  }
}

```

content\_copy

Continue

4

### Listen for state changes

keyboard\_arrow\_up

Wrap your UI in a [`ListenableBuilder`](https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html)
to listen for state changes,
and pass it a `ChangeNotifier` object.
In this case, the `ArticleViewModel` extends `ChangeNotifier`.


dart

```
class ArticleView extends StatelessWidget {
  ArticleView({super.key});
​
  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return const Center(child: Text('UI will update here'));
        },
      ),
    );
  }
}

```

content\_copy

`ListenableBuilder` uses the _builder_ pattern,
which requires a callback rather than a `child` widget to
build the widget tree below it.
These widgets are flexible because you can
perform operations within the callback,
building different widgets based on the state.


Continue

5

### Handle possible view model states

keyboard\_arrow\_up

Recall the `ArticleViewModel`, which has three properties that
the UI is interested in:


- `Summary? summary`
- `bool loading`
- `String? errorMessage`

Depending on the combined state of these properties,
the UI can display different widgets.
Use Dart's support for [switch expressions](https://dart.dev/language/branches#switch-expressions)

to handle all possible combinations in a clean, readable way:


dart

```
class ArticleView extends StatelessWidget {
  ArticleView({super.key});
​
  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Flutter'),
        actions: [],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return switch ((
            viewModel.loading,
            viewModel.summary,
            viewModel.errorMessage,
          )) {
            (true, _, _) => CircularProgressIndicator(),
            (false, _, String message) => Center(child: Text(message)),
            (false, null, null) => Center(
              child: Text('An unknown error has occurred'),
            ),
            // The summary must be non-null in this switch case.
            (false, Summary summary, null) => ArticlePage(
              summary: summary,
              onPressed: viewModel.getRandomArticleSummary,
            ),
          };
        },
      ),
    );
  }
}

```

content\_copy

This is an excellent example of how a
declarative, reactive framework like Flutter and
a pattern like MVVM work together:
The UI is rendered based on the state and updates when
a state changes demands it, but it
doesn't manage any state or the process of updating itself.
The business logic and rendering are completely separate from each other.


Continue

6

### Complete the UI

keyboard\_arrow\_up

The only thing remaining is to use the properties and methods provided
by the view model to build the UI.


Now create a `ArticlePage` widget that displays the actual article content.
This reusable widget takes summary data and a callback function:


dart

```
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });
​
  final Summary summary;
  final VoidCallback nextArticleCallback;
​
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Article content will be displayed here'));
  }
}

```

content\_copy

Continue

7

### Add a scrollable layout

keyboard\_arrow\_up

Replace the placeholder with a scrollable column layout:

dart

```
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });
​
  final Summary summary;
  final VoidCallback nextArticleCallback;
​
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}

```

content\_copy

Continue

8

### Add article content and button

keyboard\_arrow\_up

Complete the layout with an article widget and navigation button:

dart

```
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.onPressed,
  });
​
  final Summary summary;
  final VoidCallback onPressed;
​
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Flexible(
            child: ArticleWidget(
              summary: summary,
            ),
          ),
          ElevatedButton(
            onPressed: nextArticleCallback,
            child: Text('Next random article'),
          ),
        ],
      ),
    );
  }
}

```

content\_copy

Continue

9

### Create the `ArticleWidget`

keyboard\_arrow\_up

The `ArticleWidget` handles the display of the actual article content
with proper styling and conditional rendering.


#### Set up the basic article structure

[#](#set-up-the-basic-article-structure)

Start with the widget that accepts a `summary` parameter:

dart

```
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});
​
  final Summary summary;
​
  @override
  Widget build(BuildContext context) {
    return Text('Article content will be displayed here');
  }
}

```

content\_copy

#### Add padding and column layout

[#](#add-padding-and-column-layout)

Wrap the content in proper padding and layout:

dart

```
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});
​
  final Summary summary;
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}

```

content\_copy

#### Add conditional image display

[#](#add-conditional-image-display)

Add the article image that only shows when available:

dart

```
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});
​
  final Summary summary;
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          if (summary.hasImage)
            Image.network(
              summary.originalImage!.source,
            ),
          Text('Article content will be displayed here'),
        ],
      ),
    );
  }
}

```

content\_copy

#### Complete with styled text content

[#](#complete-with-styled-text-content)

Replace the placeholder text with a
properly styled title, description, and extract:


dart

```
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});
​
  final Summary summary;
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        children: [
          if (summary.hasImage)
            Image.network(
              summary.originalImage!.source,
            ),
          Text(
            summary.titles.normalized,
            overflow: TextOverflow.ellipsis,
            style: TextTheme.of(context).displaySmall,
          ),
          if (summary.description != null)
            Text(
              summary.description!,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(context).bodySmall,
            ),
          Text(
            summary.extract,
          ),
        ],
      ),
    );
  }
}

```

content\_copy

This widget demonstrates a few important UI concepts:

- **Conditional rendering**:
The `if` statements show content only when available.

- **Text styling**:
Different text styles create visual hierarchy using Flutter's theme system.

- **Proper spacing**:
The `spacing` parameter provides consistent vertical spacing.

- **Overflow handling**:
`TextOverflow.ellipsis` prevents text from breaking the layout.


Continue

10

### Update your app to include the article view

keyboard\_arrow\_up

Connect everything together by updating your `MainApp` to
include your completed `ArticleView`.


Replace your existing `MainApp` with this updated version:

dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArticleView(),
    );
  }
}

```

content\_copy

This change switches from the console-based test to the full UI
experience with proper state management.


Continue

11

### Run the complete app

keyboard\_arrow\_up

Hot reload your app one final time. You should now see:

1. A loading spinner while the initial article loads.
2. The article's title, description, and summary extract.
3. An image (if the article has one).
4. A button to load another random article.

To see the reactive UI in action,
click the **Next random article** button.
The app shows a loading state, fetches new data, and
updates the display automatically.


Continue

12

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circlesyncUsed ListenableBuilder to rebuild UI automaticallykeyboard\_arrow\_up

`ListenableBuilder` listens to your ViewModel and automatically rebuilds its children whenever
`notifyListeners()` is called. In the MVVM pattern, this is the key connection between your ViewModel and View.


alt\_routeHandled all possible states with switch expressionskeyboard\_arrow\_up

Using a switch expression, you accounted for the possible state combinations with an appropriate user interface, Conditionally displaying a loading spinner, an error message, or the actual article content. With this handling, the UI is now more robust and complete.


articleBuilt the complete View layer with proper stylingkeyboard\_arrow\_up

You created `ArticleView`, `ArticlePage`, and `ArticleWidget` with conditional rendering, text styling, proper spacing, and overflow handling. These are core UI patterns you'll use in every Flutter app.


celebrationCompleted the MVVM architecturekeyboard\_arrow\_up

You've built a complete app with Model (data operations), ViewModel (state management), and View (reactive UI) layers. This separation of concerns helps your code be more testable, maintainable, and scalable.


Continue

13

### Test yourself

keyboard\_arrow\_up

### ListenableBuilder Quiz

1 / 2

**What is the purpose of ListenableBuilder in Flutter?**

1. To create animations based on a ChangeNotifier.







Not quite



ListenableBuilder rebuilds UI on state changes, not specifically for animations.

2. To listen to a ChangeNotifier and automatically rebuild its child widgets when \`notifyListeners()\` is called.







That's right!



ListenableBuilder listens to a Listenable and rebuilds its builder function when notified.

3. To manually control when widgets should be rebuilt.







Not quite



The rebuild is automatic when notifyListeners() is called; you don't control it manually.

4. To cache widget builds for better performance.







Not quite



ListenableBuilder is about reactive updates, not caching.


**When does ListenableBuilder rebuild its child widgets?**

1. Every time the app's frame refreshes.







Not quite



ListenableBuilder only rebuilds when notified, not on every frame.

2. When the Listenable it's listening to calls notifyListeners().







That's right!



ListenableBuilder subscribes to the Listenable and rebuilds its builder function whenever \`notifyListeners()\` is called.

3. Only when the widget is first mounted.







Not quite



It rebuilds whenever \`notifyListeners()\` is called, not just on mount.

4. When the parent widget rebuilds.







Not quite



ListenableBuilder rebuilds based on the Listenable, not parent rebuilds.


PreviousNext question

Finish

[chevron\_left\
PreviousUse `ChangeNotifier` to update app state](/learn/tutorial/change-notifier) [NextAdvanced UI features\
chevron\_right](/learn/tutorial/advanced-ui)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/listenable-builder.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/listenable-builder&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/listenable-builder.md "Report an issue with this page").