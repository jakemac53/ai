---
name: testing-flutter-apps
description: Learn more about the different types of testing and how to write them.
metadata:
  url: https://docs.flutter.dev/testing/overview#unit-tests
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Testing Flutter apps

The more features your app has, the harder it is to test manually.
Automated tests help ensure that your app performs correctly before
you publish it, while retaining your feature and bug fix velocity.


Automated testing falls into a few categories:

- A [_unit test_](#unit-tests) tests a single function, method, or class.
- A [_widget test_](#widget-tests) (in other UI frameworks referred to
   as _component test_) tests a single widget.

- An [_integration test_](#integration-tests)
   tests a complete app or a large part of an app.


Generally speaking, a well-tested app has many unit and widget tests,
tracked by [code coverage](https://en.wikipedia.org/wiki/Code_coverage), plus enough integration tests
to cover all the important use cases. This advice is based on
the fact that there are trade-offs between different kinds of testing,
seen below.


TradeoffUnitWidgetIntegration**Confidence**LowHigherHighest**Maintenance cost**LowHigherHighest**Dependencies**FewMoreMost**Execution speed**QuickQuickSlow

## Unit tests

[#](#unit-tests)

A _unit test_ tests a single function, method, or class.
The goal of a unit test is to verify the correctness of a
unit of logic under a variety of conditions.
External dependencies of the unit under test are generally
[mocked out](/cookbook/testing/unit/mocking).
Unit tests generally don't read from or write
to disk, render to screen, or receive user actions from
outside the process running the test.
For more information regarding unit tests,
you can view the following recipes
or run `flutter test --help` in your terminal.


infoNote

If you're writing unit tests for code that
uses plugins and you want to avoid crashes,
check out [Plugins in Flutter tests](/testing/plugins-in-tests).
If you want to test your Flutter plugin,
check out [Testing plugins](/testing/testing-plugins).


### Recipes

[#](#recipes)

- [Introduction to unit testing](/cookbook/testing/unit/introduction)
- [Mock dependencies using Mockito](/cookbook/testing/unit/mocking)

## Widget tests

[#](#widget-tests)

A _widget test_ (in other UI frameworks referred to as _component test_)
tests a single widget. The goal of a widget test is to verify that the
widget's UI looks and interacts as expected. Testing a widget involves
multiple classes and requires a test environment that provides the
appropriate widget lifecycle context.


For example, the Widget being tested should be able to receive and
respond to user actions and events, perform layout, and instantiate child
widgets. A widget test is therefore more comprehensive than a unit test.
However, like a unit test, a widget test's environment is replaced with
an implementation much simpler than a full-blown UI system.


### Recipes

[#](#recipes-1)

- [Introduction to widget testing](/cookbook/testing/widget/introduction)
- [Find widgets using finders](/cookbook/testing/widget/finders)
- [Handling scrolling in widget tests](/cookbook/testing/widget/scrolling)
- [Tap, drag, and enter text in widget tests](/cookbook/testing/widget/tap-drag)
- [Test different orientations](/cookbook/testing/widget/orientation)

## Integration tests

[#](#integration-tests)

An _integration test_ tests a complete app or a large part of an app.
The goal of an integration test is to verify that all the widgets
and services being tested work together as expected.
Furthermore, you can use integration
tests to verify your app's performance.


Generally, an _integration test_ runs on a real device or an OS emulator,
such as iOS Simulator or Android Emulator.
The app under test is typically isolated
from the test driver code to avoid skewing the results.


For more information on how to write integration tests, see the [integration\
testing page](/testing/integration-tests).


### Recipes

[#](#recipes-2)

- [Integration testing concepts](/cookbook/testing/integration/introduction)
- [Measure performance with an integration test](/cookbook/testing/integration/profiling)

## Continuous integration services

[#](#continuous-integration-services)

Continuous integration (CI) services allow you to run your
tests automatically when pushing new code changes.
This provides timely feedback on whether the code
changes work as expected and do not introduce bugs.


For information on running tests on various continuous
integration services, see the following:


- [Continuous delivery using fastlane with Flutter](/deployment/cd#fastlane)
- [Test Flutter apps on Appcircle](https://blog.appcircle.io/article/flutter-ci-cd-github-ios-android-web#)
- [Test Flutter apps on Travis](https://blog.flutter.dev/test-flutter-apps-on-travis-3fd5142ecd8c)
- [Test Flutter apps on Cirrus](https://cirrus-ci.org/examples/#flutter)
- [Codemagic CI/CD for Flutter](https://blog.codemagic.io/getting-started-with-codemagic/)
- [Flutter CI/CD with Bitrise](https://devcenter.bitrise.io/en/getting-started/quick-start-guides/getting-started-with-flutter-apps)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-21. [View source](https://github.com/flutter/website/blob/main/src/content/testing/overview.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/testing/overview&page-source=https://github.com/flutter/website/blob/main/src/content/testing/overview.md "Report an issue with this page").