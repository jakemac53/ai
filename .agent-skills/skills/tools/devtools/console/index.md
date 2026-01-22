---
name: use-the-debug-console
description: Learn how to use the DevTools console.
metadata:
  url: https://docs.flutter.dev/tools/devtools/console
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Use the Debug console

The DevTools Debug console allows you to watch an
application's standard output ( `stdout`),
evaluate expressions for a paused or running
app in debug mode, and analyze inbound and outbound
references for objects.


infoNote

This page is up to date for DevTools 2.23.0.

The Debug console is available from the [Inspector](/tools/devtools/inspector),
[Debugger](/tools/devtools/debugger), and [Memory](/tools/devtools/memory)
views.


## Watch application output

[#](#watch-application-output)

The console shows the application's standard output ( `stdout`):

![Screenshot of stdout in Console view](/assets/images/docs/tools/devtools/console-stdout.png)

## Explore inspected widgets

[#](#explore-inspected-widgets)

If you click a widget on the **Inspector** screen,
the variable for this widget displays in the **Console**:


![Screenshot of inspected widget in Console view](/assets/images/docs/tools/devtools/console-inspect-widget.png)

## Evaluate expressions

[#](#evaluate-expressions)

In the console, you can evaluate expressions for a paused
or running application, assuming that you are running
your app in debug mode:


![Screenshot showing evaluating an expression in the console](/assets/images/docs/tools/devtools/console-evaluate-expressions.png)

To assign an evaluated object to a variable,
use `$0`, `$1` (through `$5`) in the form of `var x = $0`:


![Screenshot showing how to evaluate variables](/assets/images/docs/tools/devtools/console-evaluate-variables.png)

## Browse heap snapshot

[#](#browse-heap-snapshot)

To drop a variable to the console from a heap snapshot,
do the following:


1. Navigate to **Devtools > Memory > Diff Snapshots**.
2. Record a memory heap snapshot.
3. Click on the context menu `[⋮]` to view the number of
    **Instances** for the desired **Class**.

4. Select whether you want to store a single instance as
    a console variable, or whether you want to store _all_
    currently alive instances in the app.


![Screenshot showing how to browse the heap snapshots](/assets/images/docs/tools/devtools/browse-heap-snapshot.png)

The Console screen displays both live and static
inbound and outbound references, as well as field values:


![Screenshot showing inbound and outbound references in Console](/assets/images/docs/tools/devtools/console-references.png)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/tools/devtools/console.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/tools/devtools/console&page-source=https://github.com/flutter/website/blob/main/src/content/tools/devtools/console.md "Report an issue with this page").