---
name: an-introduction-to-widget-testing
description: Learn more about widget testing in Flutter.
metadata:
  url: https://docs.flutter.dev/cookbook/testing/widget/introduction
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# An introduction to widget testing

In the [introduction to unit testing](/cookbook/testing/unit/introduction) recipe,
you learned how to test Dart classes using the `test` package.
To test widget classes, you need a few additional tools provided by the
[`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
package, which ships with the Flutter SDK.


The `flutter_test` package provides the following tools for
testing widgets:


- The [`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)
   allows building and interacting
   with widgets in a test environment.

- The [`testWidgets()`](https://api.flutter.dev/flutter/flutter_test/testWidgets.html)
   function automatically
   creates a new `WidgetTester` for each test case,
   and is used in place of the normal `test()` function.

- The [`Finder`](https://api.flutter.dev/flutter/flutter_test/Finder-class.html) classes allow searching for widgets
   in the test environment.

- Widget-specific [`Matcher`](https://api.flutter.dev/flutter/package-matcher_matcher/Matcher-class.html)
   constants help verify
   whether a `Finder` locates a widget or
   multiple widgets in the test environment.


If this sounds overwhelming, don't worry. Learn how all of these pieces fit
together throughout this recipe, which uses the following steps:


1. Add the `flutter_test` dependency.
2. Create a widget to test.
3. Create a `testWidgets` test.
4. Build the widget using the `WidgetTester`.
5. Search for the widget using a `Finder`.
6. Verify the widget using a `Matcher`.

## 1\. Add the `flutter_test` dependency

[#](#1-add-the-flutter-test-dependency)

Before writing tests, include the `flutter_test`
dependency in the `dev_dependencies` section of the `pubspec.yaml`
file.
If creating a new Flutter project with the command line tools or
a code editor, this dependency should already be in place.


yaml

```
dev_dependencies:
  flutter_test:
    sdk: flutter

```

content\_copy

## 2\. Create a widget to test

[#](#2-create-a-widget-to-test)

Next, create a widget for testing. For this recipe,
create a widget that displays a `title` and `message`.


dart

```
class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title, required this.message});
​
  final String title;
  final String message;
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text(message)),
      ),
    );
  }
}

```

content\_copy

## 3\. Create a `testWidgets` test

[#](#3-create-a-testwidgets-test)

With a widget to test, begin by writing your first test.
Use the [`testWidgets()`](https://api.flutter.dev/flutter/flutter_test/testWidgets.html)
function provided by the
`flutter_test` package to define a test.
The `testWidgets` function allows you to define a
widget test and creates a `WidgetTester` to work with.


This test verifies that `MyWidget` displays a given title and message.
It is titled accordingly, and it will be populated in the next section.


dart

```
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (tester) async {
    // Test code goes here.
  });
}

```

content\_copy

## 4\. Build the widget using the `WidgetTester`

[#](#4-build-the-widget-using-the-widgettester)

Next, build `MyWidget` inside the test environment by using the
[`pumpWidget()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpWidget.html)
method provided by `WidgetTester`.
The `pumpWidget` method builds and renders the provided widget.


Create a `MyWidget` instance that displays "T" as the title
and "M" as the message.


dart

```
void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
  });
}

```

content\_copy

### Notes about the pump() methods

[#](#notes-about-the-pump-methods)

After the initial call to `pumpWidget()`, the `WidgetTester` provides
additional ways to rebuild the same widget. This is useful if you're
working with a `StatefulWidget` or animations.


For example, tapping a button calls `setState()`, but Flutter won't
automatically rebuild your widget in the test environment.
Use one of the following methods to ask Flutter to rebuild the widget.


[`tester.pump(Duration duration)`](https://api.flutter.dev/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html)

Schedules a frame and triggers a rebuild of the widget.
If a `Duration` is specified, it advances the clock by
that amount and schedules a frame. It does not schedule
multiple frames even if the duration is longer than a
single frame.


infoNote

To kick off the animation, you need to call `pump()`
once (with no duration specified) to start the ticker.
Without it, the animation does not start.


[`tester.pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html)

Repeatedly calls `pump()` with the given duration until
there are no longer any frames scheduled.
This, essentially, waits for all animations to complete.


These methods provide fine-grained control over the build lifecycle,
which is particularly useful while testing.


## 5\. Search for our widget using a `Finder`

[#](#5-search-for-our-widget-using-a-finder)

With a widget in the test environment, search
through the widget tree for the `title` and `message`
Text widgets using a `Finder`. This allows verification that
the widgets are being displayed correctly.


For this purpose, use the top-level [`find()`](https://api.flutter.dev/flutter/flutter_test/find-constant.html)

method provided by the `flutter_test` package to create the `Finders`.
Since you know you're looking for `Text` widgets, use the
[`find.text()`](https://api.flutter.dev/flutter/flutter_test/CommonFinders/text.html)
method.


For more information about `Finder` classes, see the
[Finding widgets in a widget test](/cookbook/testing/widget/finders) recipe.


dart

```
void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
​
    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
  });
}

```

content\_copy

## 6\. Verify the widget using a `Matcher`

[#](#6-verify-the-widget-using-a-matcher)

Finally, verify the title and message `Text` widgets appear on screen
using the `Matcher` constants provided by `flutter_test`.
`Matcher` classes are a core part of the `test` package,
and provide a common way to verify a given
value meets expectations.


Ensure that the widgets appear on screen exactly one time.
For this purpose, use the [`findsOneWidget`](https://api.flutter.dev/flutter/flutter_test/findsOneWidget-constant.html) `Matcher`.


dart

```
void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
​
    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

```

content\_copy

### Additional Matchers

[#](#additional-matchers)

In addition to `findsOneWidget`, `flutter_test` provides additional
matchers for common cases.


[`findsNothing`](https://api.flutter.dev/flutter/flutter_test/findsNothing-constant.html)

Verifies that no widgets are found.

[`findsWidgets`](https://api.flutter.dev/flutter/flutter_test/findsWidgets-constant.html)

Verifies that one or more widgets are found.

[`findsNWidgets`](https://api.flutter.dev/flutter/flutter_test/findsNWidgets.html)

Verifies that a specific number of widgets are found.

[`matchesGoldenFile`](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)

Verifies that a widget's rendering matches a particular bitmap image ("golden file" testing).

## Complete example

[#](#complete-example)

dart

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
​
void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));
​
    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
​
    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
​
class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.title, required this.message});
​
  final String title;
  final String message;
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text(message)),
      ),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-22. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/introduction.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/testing/widget/introduction&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/introduction.md "Report an issue with this page").