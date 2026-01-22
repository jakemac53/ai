---
name: report-errors-to-a-service
description: How to keep track of errors that users encounter.
metadata:
  url: https://docs.flutter.dev/cookbook/maintenance/error-reporting
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Report errors to a service

While one always tries to create apps that are free of bugs,
they're sure to crop up from time to time.
Since buggy apps lead to unhappy users and customers,
it's important to understand how often your users
experience bugs and where those bugs occur.
That way, you can prioritize the bugs with the
highest impact and work to fix them.


How can you determine how often your users experiences bugs?
Whenever an error occurs, create a report containing the
error that occurred and the associated stacktrace.
You can then send the report to an error tracking
service, such as [Bugsnag](https://www.bugsnag.com/platforms/flutter),
[Datadog](https://docs.datadoghq.com/real_user_monitoring/flutter/),
[Firebase Crashlytics](https://firebase.google.com/docs/crashlytics), [Rollbar](https://rollbar.com/), or Sentry.


The error tracking service aggregates all of the crashes your users
experience and groups them together. This allows you to know how often your
app fails and where the users run into trouble.


In this recipe, learn how to report errors to the
[Sentry](https://sentry.io/welcome/) crash reporting service using
the following steps:


1. Get a DSN from Sentry.
2. Import the Flutter Sentry package
3. Initialize the Sentry SDK
4. Capture errors programmatically

## 1\. Get a DSN from Sentry

[#](#1-get-a-dsn-from-sentry)

Before reporting errors to Sentry, you need a "DSN" to uniquely identify
your app with the Sentry.io service.


To get a DSN, use the following steps:

1. [Create an account with Sentry](https://sentry.io/signup/).
2. Log in to the account.
3. Create a new Flutter project.
4. Copy the code snippet that includes the DSN.

## 2\. Import the Sentry package

[#](#2-import-the-sentry-package)

Import the [`sentry_flutter`](https://pub.dev/packages/sentry_flutter) package into the app.
The sentry package makes it easier to send
error reports to the Sentry error tracking service.


To add the `sentry_flutter` package as a dependency,
run `flutter pub add`:


```
$ flutter pub add sentry_flutter

```

content\_copy

## 3\. Initialize the Sentry SDK

[#](#3-initialize-the-sentry-sdk)

Initialize the SDK to capture different unhandled errors automatically:

dart

```
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
​
Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = 'https://example@sentry.io/example',
    appRunner: () => runApp(const MyApp()),
  );
}

```

content\_copy

Alternatively, you can pass the DSN to Flutter using the `dart-define` tag:

sh

```
--dart-define SENTRY_DSN=https://example@sentry.io/example

```

content\_copy

### What does that give me?

[#](#what-does-that-give-me)

This is all you need for Sentry to
capture unhandled errors in Dart and native layers.
This includes Swift, Objective-C, C, and C++ on iOS, and
Java, Kotlin, C, and C++ on Android.


## 4\. Capture errors programmatically

[#](#4-capture-errors-programmatically)

Besides the automatic error reporting that Sentry generates by
importing and initializing the SDK,
you can use the API to report errors to Sentry:


dart

```
await Sentry.captureException(exception, stackTrace: stackTrace);

```

content\_copy

For more information, see the [Sentry API](https://pub.dev/documentation/sentry_flutter/latest/sentry_flutter/sentry_flutter-library.html)
docs on pub.dev.


## Learn more

[#](#learn-more)

Extensive documentation about using the Sentry SDK can be found on [Sentry's site](https://docs.sentry.io/platforms/flutter/).


## Complete example

[#](#complete-example)

To view a working example,
see the [Sentry flutter example](https://github.com/getsentry/sentry-dart/tree/main/flutter/example)
app.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/maintenance/error-reporting.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/maintenance/error-reporting&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/maintenance/error-reporting.md "Report an issue with this page").