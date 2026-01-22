---
name: set-up-your-project
description: Instructions on how to create a new Flutter app.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/set-up-state-project
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up your project

Preview the Wikipedia reader app you'll build and set up the initial project with required packages.

[Watch on YouTube in a new tab: "Decoding Flutter: Unbounded height and width"](https://www.youtube.com/watch/jckqXR5CrPI)

### What you'll accomplish

previewPreview the Wikipedia reader app you'll build

inventory\_2Add packages for handling HTTP requests and Wikipedia data

codeSet up the initial project structure

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

In the next few lessons, you'll learn how to work with data in a Flutter app.
You'll build an app that fetches and displays article summaries from
the [Wikipedia API](https://en.wikipedia.org/api/rest_v1/).


![A screenshot of the completed Wikipedia reader app showing an article with image, title, description, and extract text.](/assets/images/docs/tutorial/wikipedia_app.png)

These lessons explore:

- Making HTTP requests in Flutter.
- Managing application state with `ChangeNotifier`.
- Using the MVVM architecture pattern.
- Creating responsive user interfaces that
update automatically when data changes.


This tutorial assumes you've completed the
[Getting started with Dart](https://dart.dev/tutorial) and the
[Introduction to Flutter UI](/learn/tutorial/create-an-app) tutorials,
and therefore doesn't explain concepts like HTTP, JSON, or widget basics.


boltSupport Wikipedia

[Wikipedia](https://wikipedia.org/) is a valuable resource, providing free
access to human knowledge through millions of articles written
collaboratively by volunteers worldwide.
Consider [donating to Wikipedia](https://donate.wikimedia.org/)
to help keep this incredible resource
free and accessible to everyone.


Continue

2

### Create a new Flutter project

keyboard\_arrow\_up

Create a new Flutter project using the [Flutter CLI](/reference/flutter-cli).
In your preferred terminal, run the following command to
create a minimal Flutter app:


```
$ flutter create wikipedia_reader --empty

```

content\_copy

Continue

3

### Add required dependencies

keyboard\_arrow\_up

Your app needs two [packages](/packages-and-plugins/using-packages) to work with HTTP requests and
Wikipedia data. Add them to your project:


```
$ cd wikipedia_reader && flutter pub add http dartpedia

```

content\_copy

The [`http` package](https://pub.dev/packages/http) provides tools for making HTTP requests, while
the `dartpedia` package contains data models for working with
Wikipedia's API responses.


Continue

4

### Examine the starter code

keyboard\_arrow\_up

Open `lib/main.dart` and replace the existing code with
this basic structure, which adds required imports that the app uses:


lib/main.dart

dart

```
import 'dart:convert';
import 'dart:io';
​
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wikipedia/wikipedia.dart';
​
void main() {
  runApp(const MainApp());
}
​
class MainApp extends StatelessWidget {
  const MainApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wikipedia Flutter'),
        ),
        body: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}

```

content\_copy

This code provides a basic app structure with
a title bar and placeholder content.
The imports at the top include everything you need for
HTTP requests, JSON parsing, and Wikipedia data models.


Continue

5

### Run your app

keyboard\_arrow\_up

Test that everything works by running your app:

```
$ flutter run -d chrome

```

content\_copy

You should see a simple app with "Wikipedia Flutter" in the app bar
and "Loading..." in the center of the screen.


Continue

6

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circlepreviewPreviewed the Wikipedia reader appkeyboard\_arrow\_up

You're starting a new tutorial section focused on working with data. You'll learn HTTP requests, state management with
`ChangeNotifier`, and the MVVM architectural pattern.


inventory\_2Added the http and dartpedia packageskeyboard\_arrow\_up

You used `flutter pub add` to install packages for making HTTP requests and working with Wikipedia data models. Packages let you leverage existing code built by the community instead of building everything from scratch.


codeSet up the initial project structurekeyboard\_arrow\_up

Your app has the basic structure with all necessary imports for HTTP requests, JSON parsing, and Wikipedia data. You're ready to start fetching real data from the Wikipedia API!


Continue

7

### Test yourself

keyboard\_arrow\_up

### Project Setup Quiz

1 / 2

**What does the \`--empty\` flag do when running \`flutter create\`?**

1. Creates a project with no files at all.







Not quite



The project still has essential files; it just uses a minimal template.

2. Creates a minimal Flutter project with less boilerplate code.







That's right!



The \`--empty\` flag generates a minimal starter template without the default counter app.

3. Creates a project without any dependencies.







Not quite



The project still includes core Flutter dependencies.

4. Creates a project that can only run on web.







Not quite



The flag doesn't restrict platforms; it only affects the starter template.


**What command is used to add a package dependency to a Flutter project?**

1. \`flutter install \[package\_name\]\`







Not quite



The correct command uses \`pub add\`, not \`install\`.

2. \`flutter pub add \[package\_name\]\`







That's right!



Running \`flutter pub add\` adds the package to pubspec.yaml and downloads it.

3. \`dart get \[package\_name\]\`







Not quite



The command for adding packages is \`flutter pub add\` or editing pubspec.yaml.

4. \`flutter package install \[package\_name\]\`







Not quite



There is no \`flutter package\` command; use \`flutter pub add\`.


PreviousNext question

Finish

[chevron\_left\
PreviousAdd implicit animations](/learn/tutorial/implicit-animations) [NextMake Http Requests\
chevron\_right](/learn/tutorial/http-requests)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/set-up-state-project.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/set-up-state-project&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/set-up-state-project.md "Report an issue with this page").