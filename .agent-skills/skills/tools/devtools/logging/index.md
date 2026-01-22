---
name: use-the-logging-view
description: Learn how to use the DevTools logging view.
metadata:
  url: https://docs.flutter.dev/tools/devtools/logging
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Use the Logging view

infoNote

The logging view works with all Flutter and Dart applications.

## What is it?

[#](#what-is-it)

The logging view displays events from the Dart runtime,
application frameworks (like Flutter), and application-level
logging events.


## Standard logging events

[#](#standard-logging-events)

By default, the logging view shows:

- Garbage collection events from the Dart runtime
- Flutter framework events, like frame creation events
- `stdout` and `stderr` from applications
- Custom logging events from applications

![Screenshot of a logging view](/assets/images/docs/tools/devtools/logging_log_entries.png)

## Logging from your application

[#](#logging-from-your-application)

To implement logging in your code,
see the [Logging](/testing/code-debugging#add-logging-to-your-application)
section in the
[Debugging Flutter apps programmatically](/testing/code-debugging)
page.


## Clearing logs

[#](#clearing-logs)

To clear the log entries in the logging view,
click the **Clear logs** button.


## Other resources

[#](#other-resources)

To learn about different methods of logging
and how to effectively use DevTools to
analyze and debug Flutter apps faster,
check out a guided [Logging View tutorial](https://medium.com/@fluttergems/mastering-dart-flutter-devtools-logging-view-part-5-of-8-b634f3a3af26).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2024-4-9. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/logging.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/logging&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/logging.md "Report an issue with this page").