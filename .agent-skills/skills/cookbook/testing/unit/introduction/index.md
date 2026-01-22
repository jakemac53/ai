---
name: an-introduction-to-unit-testing
description: How to write unit tests.
metadata:
  url: https://docs.flutter.dev/cookbook/testing/unit/introduction
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# An introduction to unit testing

How can you ensure that your app continues to work as you
add more features or change existing functionality?
By writing tests.


Unit tests are handy for verifying the behavior of a single function,
method, or class. The [`test`](https://pub.dev/packages/test)
package provides the
core framework for writing unit tests, and the [`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)

package provides additional utilities for testing widgets.


This recipe demonstrates the core features provided by the `test` package
using the following steps:


1. Add the `test` or `flutter_test` dependency.
2. Create a test file.
3. Create a class to test.
4. Write a `test` for our class.
5. Combine multiple tests in a `group`.
6. Run the tests.

For more information about the test package,
see the [test package documentation](https://pub.dev/packages/test).


## 1\. Add the test dependency

[#](#1-add-the-test-dependency)

The `test` package provides the core functionality for
writing tests in Dart. This is the best approach when
writing packages consumed by web, server, and Flutter apps.


To add the `test` package as a dev dependency,
run `flutter pub add`:


```
$ flutter pub add dev:test

```

content\_copy

## 2\. Create a test file

[#](#2-create-a-test-file)

In this example, create two files: `counter.dart` and `counter_test.dart`.

The `counter.dart` file contains a class that you want to test and
resides in the `lib` folder. The `counter_test.dart` file contains
the tests themselves and lives inside the `test` folder.


In general, test files should reside inside a `test` folder
located at the root of your Flutter application or package.
Test files should always end with `_test.dart`,
this is the convention used by the test runner when searching for tests.


When you're finished, the folder structure should look like this:

```
counter_app/
  lib/
    counter.dart
  test/
    counter_test.dart

```

content\_copy

## 3\. Create a class to test

[#](#3-create-a-class-to-test)

Next, you need a "unit" to test. Remember: "unit" is another name for a
function, method, or class. For this example, create a `Counter` class
inside the `lib/counter.dart` file. It is responsible for incrementing
and decrementing a `value` starting at `0`.


dart

```
class Counter {
  int value = 0;
​
  void increment() => value++;
​
  void decrement() => value--;
}

```

content\_copy

**Note:** For simplicity, this tutorial does not follow the "Test Driven
Development" approach. If you're more comfortable with that style of
development, you can always go that route.


## 4\. Write a test for our class

[#](#4-write-a-test-for-our-class)

Inside the `counter_test.dart` file, write the first unit test. Tests are
defined using the top-level `test` function, and you can check if the results
are correct by using the top-level `expect` function.
Both of these functions come from the `test` package.


dart

```
// Import the test package and Counter class
import 'package:counter_app/counter.dart';
import 'package:test/test.dart';
​
void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();
​
    counter.increment();
​
    expect(counter.value, 1);
  });
}

```

content\_copy

## 5\. Combine multiple tests in a `group`

[#](#5-combine-multiple-tests-in-a-group)

If you want to run a series of related tests,
use the `flutter_test` package [`group`](https://api.flutter.dev/flutter/flutter_test/group.html)
function to categorize the tests.
Once put into a group, you can call `flutter test` on all tests in
that group with one command.


dart

```
import 'package:counter_app/counter.dart';
import 'package:test/test.dart';
​
void main() {
  group('Test start, increment, decrement', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });
​
    test('value should be incremented', () {
      final counter = Counter();
​
      counter.increment();
​
      expect(counter.value, 1);
    });
​
    test('value should be decremented', () {
      final counter = Counter();
​
      counter.decrement();
​
      expect(counter.value, -1);
    });
  });
}

```

content\_copy

## 6\. Run the tests

[#](#6-run-the-tests)

Now that you have a `Counter` class with tests in place,
you can run the tests.


### Run tests using IntelliJ or VSCode

[#](#run-tests-using-intellij-or-vscode)

The Flutter plugins for IntelliJ and VSCode support running tests.
This is often the best option while writing tests because it provides the
fastest feedback loop as well as the ability to set breakpoints.


- **IntelliJ**
  1. Open the `counter_test.dart` file
  2. Go to **Run** \> **Run 'tests in counter\_test.dart'**.
      You can also press the appropriate keyboard shortcut for your platform.
- **VSCode**
  1. Open the `counter_test.dart` file
  2. Go to **Run** \> **Start Debugging**.
      You can also press the appropriate keyboard shortcut for your platform.

### Run tests in a terminal

[#](#run-tests-in-a-terminal)

To run the all tests from the terminal,
run the following command from the root of the project:


```
flutter test test/counter_test.dart

```

content\_copy

To run all tests you put into one `group`,
run the following command from the root of the project:


```
flutter test --plain-name "Test start, increment, decrement"

```

content\_copy

This example uses the `group` created in **section 5**.

To learn more about unit tests, you can execute this command:

```
flutter test --help

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/testing/unit/introduction.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/testing/unit/introduction&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/testing/unit/introduction.md "Report an issue with this page").