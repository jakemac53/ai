---
name: fetch-data-from-the-internet
description: Instructions on how to make HTTP requests and parse responses.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/http-requests
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Fetch data from the internet

Learn the MVVM architecture pattern and how to build HTTP requests with async/await.

### What you'll accomplish

layersUnderstand the MVVM architecture pattern

cloud\_downloadBuild HTTP requests with async/await

data\_objectHandle errors and parse JSON responses

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

The overarching pattern that this tutorial implements is called
_Model-View-ViewModel_ or _MVVM_.
MVVM is an [architectural pattern](/app-architecture/guide) used in client apps that
separates your app into three layers:


- **Model**: Handles data operations.
- **View**: Displays the UI.
- **ViewModel**: Manages state and connects the two.

The core tenet of MVVM (and many other patterns) is _separation of concerns_.
Managing state in separate classes (outside your UI widgets) makes
your code more testable, reusable, and easier to maintain.


A single feature in your app contains each one of the MVVM components.
In this tutorial, in addition to Flutter widgets,
you'll create `ArticleModel`, `ArticleViewModel`, and
`ArticleView`.


Continue

2

### Define the Model

keyboard\_arrow\_up

The Model is the source-of-truth for your app's data and is responsible for
low-level tasks such as making HTTP requests, caching data, or
managing system resources such as used by a Flutter plugin.
A model doesn't usually need to import Flutter libraries.


Create an empty `ArticleModel` class in your `main.dart` file:

lib/main.dart

dart

```
class ArticleModel {
  // Properties and methods will be added here.
}

```

content\_copy

Continue

3

### Build the HTTP request

keyboard\_arrow\_up

Wikipedia provides a REST API that returns JSON data about articles.
For this app, you'll use the endpoint that returns a random article summary.


```
https://en.wikipedia.org/api/rest_v1/page/random/summary

```

content\_copy

Add a method to fetch a random Wikipedia article summary:

dart

```
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);
​
    // TODO: Add error handling and JSON parsing.
  }
}

```

content\_copy

Use the [`async` and `await`](https://dart.dev/language/async) keywords to handle asynchronous operations.
The `async` keyword marks a method as asynchronous, and
`await` waits for expressions that return a [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html).


The `Uri.https` constructor safely builds URLs by
handling encoding and formatting.
This approach is more reliable than string concatenation,
especially when dealing with special characters or query parameters.


Continue

4

### Handle network errors

keyboard\_arrow\_up

Always handle errors when making HTTP requests.
A status code of **200** indicates success, while other codes indicate errors.
If the status code isn't **200**, the model throws an error for
the UI to display to users.


dart

```
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);
​
    if (response.statusCode != 200) {
      throw HttpException('Failed to update resource');
    }
​
    // TODO: Parse JSON and return Summary.
  }
}

```

content\_copy

Continue

5

### Parse JSON from Wikipedia

keyboard\_arrow\_up

The [Wikipedia API](https://en.wikipedia.org/api/rest_v1/) returns [JSON](https://dart.dev/tutorial/json)
data that
you decode into a `Summary` class
Complete the `getRandomArticleSummary` method:


dart

```
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    final response = await get(uri);
​
    if (response.statusCode != 200) {
      throw HttpException('Failed to update resource');
    }
​
    return Summary.fromJson(jsonDecode(response.body));
  }
}

```

content\_copy

The `dartpedia` package provides the `Summary` class.
If you're unfamiliar with JSON parsing,
check out the [Getting started with Dart](https://dart.dev/tutorial)
tutorial.


Continue

6

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circlelayersUnderstood the MVVM architecture patternkeyboard\_arrow\_up

MVVM separates your app into Model (data operations), View (user interface), and ViewModel (state management). This separation of concerns makes your code more testable, reusable, and easier to maintain.


cloud\_downloadBuilt an HTTP request to fetch Wikipedia datakeyboard\_arrow\_up

You created an `ArticleModel` class with a method that uses `async` and `await`
to fetch data from the Wikipedia API. To safely build the URLs for the requests, you used the `Uri.https`
constructor which handles encoding and special characters for you.


data\_objectHandled errors and parsed JSON responseskeyboard\_arrow\_up

You checked the HTTP status code to detect errors and used `jsonDecode` to parse the response body. Then to convert the raw JSON into a typed Dart object, you used the
`Summary.fromJson` named constructor.


Continue

7

### Test yourself

keyboard\_arrow\_up

### HTTP Requests Quiz

1 / 2

**What do the \`async\` and \`await\` keywords do in Dart?**

1. They make code run on a separate thread.







Not quite



Dart is single-threaded; async/await handles asynchronous operations without threads.

2. They mark a function as asynchronous and pause execution until a Future completes.







That's right!



The \`async\` keyword marks a function as asynchronous, and \`await\` pauses execution until the Future resolves.

3. They automatically cache the results of function calls.







Not quite



Caching requires separate implementation; async/await is for handling asynchronous operations.

4. They convert synchronous code to run in the background.







Not quite



They don't move code to the background; they manage asynchronous execution flow.


**Why is \`Uri.https\` preferred over string concatenation when building URLs in Dart?**

1. It makes the code shorter.







Not quite



Code length isn't the main benefit; proper encoding is.

2. It safely handles encoding and formatting, especially for special characters and query parameters.







That's right!



Uri.https properly encodes special characters and formats URLs, preventing common errors.

3. It's required by the http package.







Not quite



You can use strings, but Uri.https is safer and more reliable.

4. It automatically validates that the URL exists.







Not quite



Uri.https builds the URL; it doesn't check if the endpoint exists.


PreviousNext question

Finish

[chevron\_left\
PreviousThe state management project](/learn/tutorial/set-up-state-project) [NextUse `ChangeNotifier` to update app state\
chevron\_right](/learn/tutorial/change-notifier)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/http-requests.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/http-requests&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/http-requests.md "Report an issue with this page").