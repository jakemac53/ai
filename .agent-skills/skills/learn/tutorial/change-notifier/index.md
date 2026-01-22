---
name: state-management-in-flutter
description: Instructions on how to manage state with ChangeNotifiers.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/change-notifier
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# State management in Flutter

Learn to create a ViewModel with ChangeNotifier and manage loading, success, and error states.

### What you'll accomplish

layersCreate a ViewModel with ChangeNotifier

toggle\_onManage loading, success, and error states

notifications\_activeSignal UI updates with notifyListeners

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

When developers talk about state-management in Flutter,
they're essentially referring to the pattern by which your app
updates the data it needs to render correctly and then
tells Flutter to re-render the UI with that new data.


In MVVM, this responsibility falls to the ViewModel layer,
which sits between and connects your UI to your Model layer.
In Flutter, ViewModels use Flutter's `ChangeNotifier` class to
notify the UI when data changes.


To use [`ChangeNotifier`](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html), extend it in your state management class to
gain access to the `notifyListeners()` method,
which triggers UI rebuilds when called.


Continue

2

### Create the basic view model structure

keyboard\_arrow\_up

Create the `ArticleViewModel` class with its
basic structure and state properties:


dart

```
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;
​
  ArticleViewModel(this.model);
}

```

content\_copy

The `ArticleViewModel` holds three pieces of state:

- `summary`: The current Wikipedia article data.
- `errorMessage`: Any error that occurred during data fetching.
- `loading`: A flag to show progress indicators.

Continue

3

### Add constructor initialization

keyboard\_arrow\_up

Update the constructor to automatically fetch content when the
`ArticleViewModel` is created:


dart

```
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;
​
  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }
​
  // Methods will be added next.
}

```

content\_copy

This constructor initialization provides immediate content when
a `ArticleViewModel` object is created.
Because constructors can't be asynchronous,
it delegates initial content fetching to a separate method.


Continue

4

### Set up the `getRandomArticleSummary` method

keyboard\_arrow\_up

Add the `getRandomArticleSummary` that fetches data and manages state updates:

dart

```
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;
​
  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }
​
  Future<void> getRandomArticleSummary() async {
    loading = true;
    notifyListeners();
​
    // TODO: Add data fetching logic
​
    loading = false;
    notifyListeners();
  }
}

```

content\_copy

The ViewModel updates the `loading` property and
calls `notifyListeners()` to inform the UI of the update.
When the operation completes, it toggles the property back.
When you build the UI, you'll use this `loading` property to
show a loading indicator while fetching a new article.


Continue

5

### Retrieve an article from the `ArticleModel`

keyboard\_arrow\_up

Complete the `getRandomArticleSummary` method to fetch an article summary.
Use a [try-catch block](https://dart.dev/language/error-handling#catch)
to gracefully handle network errors and
store error messages that the UI can display to users.
The method clears previous errors on success and
clears the previous article summary on error to maintain a consistent state.


dart

```
class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model;
  Summary? summary;
  String? errorMessage;
  bool loading = false;
​
  ArticleViewModel(this.model) {
    getRandomArticleSummary();
  }
​
  Future<void> getRandomArticleSummary() async {
    loading = true;
    notifyListeners();
    try {
      summary = await model.getRandomArticleSummary();
      errorMessage = null; // Clear any previous errors.
    } on HttpException catch (error) {
      errorMessage = error.message;
      summary = null;
    }
    loading = false;
    notifyListeners();
  }
}

```

content\_copy

Continue

6

### Test the ViewModel

keyboard\_arrow\_up

Before building the full UI, test that your HTTP requests work by
printing results to the console.
First, update the `getRandomArticleSummary` method to
print the results:


dart

```
Future<void> getRandomArticleSummary() async {
  loading = true;
  notifyListeners();
  try {
    summary = await model.getRandomArticleSummary();
    print('Article loaded: ${summary!.titles.normalized}'); // Temporary
    errorMessage = null; // Clear any previous errors.
  } on HttpException catch (error) {
    print('Error loading article: ${error.message}'); // Temporary
    errorMessage = error.message;
    summary = null;
  }
  loading = false;
  notifyListeners();
}

```

content\_copy

Then, update the `MainApp` widget to create the `ArticleViewModel`,
which calls the `getRandomArticleSummary` method on creation:


dart

```
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    // Instantiate your `ArticleViewModel` to test its HTTP requests.
    final viewModel = ArticleViewModel(ArticleModel());
​
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wikipedia Flutter'),
        ),
        body: const Center(
          child: Text('Check console for article data'),
        ),
      ),
    );
  }
}

```

content\_copy

Hot reload your app and check your console output.
You should see either an article title or an error message,
which confirms that your Model and ViewModel are wired up correctly.


Continue

7

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circlelayersCreated the ArticleViewModel with ChangeNotifierkeyboard\_arrow\_up

The ViewModel sits between your UI and Model, managing state and connecting the two layers. By extending
`ChangeNotifier`, your ViewModel gains the ability to notify listeners when data changes.


toggle\_onManaged loading, success, and error stateskeyboard\_arrow\_up

Your ViewModel tracks three pieces of state: `loading`, `summary`, and `errorMessage`. Using
`try` and `catch`, you handle network errors gracefully and maintain consistent state for each possible outcome.


notifications\_activeUsed notifyListeners to signal UI updateskeyboard\_arrow\_up

Calling `notifyListeners()` tells any listening widgets to rebuild. You call it after setting
`loading = true` and again after the operation completes. This is how you can implement reactive UI updates in Flutter.


Continue

8

### Test yourself

keyboard\_arrow\_up

### State Management Quiz

1 / 2

**What is a ChangeNotifier?**

1. A widget that displays notifications to the user.







Not quite



ChangeNotifier is not a widget; it's a class for managing state.

2. A class that can notify listeners when its data changes, enabling reactive UI updates.







That's right!



ChangeNotifier provides the notifyListeners method to signal widgets to rebuild when state changes.

3. A built-in Dart class for sending push notifications.







Not quite



ChangeNotifier is for in-app state management, not push notifications.

4. A type of animation controller in Flutter.







Not quite



Animation controllers are separate; ChangeNotifier is for state management.


**What does calling \`notifyListeners()\` do in a ChangeNotifier?**

1. Saves the current state to local storage.







Not quite



\`notifyListeners()\` signals UI updates; persistence requires separate implementation.

2. Tells any listening widgets to rebuild and reflect the new state.







That's right!



Calling \`notifyListeners()\` triggers a rebuild of all widgets listening to this ChangeNotifier.

3. Logs the state change to the console for debugging.







Not quite



It doesn't log anything; it signals listeners to rebuild.

4. Resets all state properties to their default values.







Not quite



\`notifyListeners()\` doesn't modify state; it just signals that state has changed.


PreviousNext question

Finish

[chevron\_left\
PreviousMake Http Requests](/learn/tutorial/http-requests) [NextUse `ListenableBuilder` to update app UI\
chevron\_right](/learn/tutorial/listenable-builder)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/change-notifier.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/change-notifier&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/change-notifier.md "Report an issue with this page").