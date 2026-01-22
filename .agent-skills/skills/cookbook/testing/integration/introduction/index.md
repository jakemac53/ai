---
name: integration-testing-concepts
description: Learn about integration testing in Flutter.
metadata:
  url: https://docs.flutter.dev/cookbook/testing/integration/introduction
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Integration testing concepts

Unit tests and widget tests validate individual classes,
functions, or widgets.
They don't validate how individual pieces work
together in whole or capture the performance
of an app running on a real device.
To perform these tasks, use _integration tests_.


Integration tests verify the behavior of the complete app.
This test can also be called end-to-end testing or GUI testing.


The Flutter SDK includes the [integration\_test](https://github.com/flutter/flutter/tree/main/packages/integration_test)
package.


## Terminology

[#](#terminology)

**host machine**

The system on which you develop your app, like a desktop computer.

**target device**

The mobile device, browser, or desktop application that
runs your Flutter app.


If you run your app in a web browser or as a desktop application,
the host machine and the target device are the same.


## Dependent package

[#](#dependent-package)

To run integration tests, add the `integration_test` package
as a dependency for your Flutter app test file.


To migrate existing projects that use `flutter_driver`,
consult the [Migrating from flutter\_driver](/release/breaking-changes/flutter-driver-migration)
guide.


Tests written with the `integration_test` package
can perform the following tasks.


- Run on the target device.
   To test multiple Android or iOS devices, use Firebase Test Lab.

- Run from the host machine with `flutter test integration_test`.
- Use `flutter_test` APIs. This makes integration tests
   similar to writing [widget tests](/testing/overview#widget-tests).


## Use cases for integration testing

[#](#use-cases-for-integration-testing)

The other guides in this section explain how to use integration tests to validate
[functionality](/testing/integration-tests/) and [performance](/cookbook/testing/integration/profiling/).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/testing/integration/introduction.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/testing/integration/introduction&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/testing/integration/introduction.md "Report an issue with this page").