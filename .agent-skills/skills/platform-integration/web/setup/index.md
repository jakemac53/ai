---
name: set-up-web-development
description: Configure your development environment to run, build, and deploy Flutter apps for the web platform.
metadata:
  url: https://docs.flutter.dev/platform-integration/web/setup
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up web development

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the web platform.


infoNote

If you haven't set up Flutter already,
visit and follow the [Get started with Flutter](/get-started) guide first.


If you've already installed Flutter,
ensure that it's [up to date](/install/upgrade).


## Install a web browser

[#](#install)

To run and debug your Flutter app on the web,
[download and install Google Chrome](https://www.google.com/chrome/)
or [install and use Microsoft Edge](https://www.microsoft.com/edge).


Expand for instructions for other browsers

If you want to debug your app in other web browsers,
you can use the `flutter run -d web-server` command,
and manually navigate to the specified URL in your preferred browser.

Note that debugging support in the `web-server` mode is limited.

## Validate your setup

[#](#validate-setup)

To ensure that you installed the browser successfully,
and that Flutter can find it,
run `flutter devices` in your preferred terminal.


You should at least see one connected device labeled
**Chrome (web)** or **Edge (web)**, similar to the following:


```
$ flutter devices

Found 1 connected devices:
  Chrome (web)    • chrome • web-javascript • Google Chrome

```

content\_copy

If the command isn't found, or you don't see Chrome listed,
check out [Set up troubleshooting](/install/troubleshoot).


## Start developing for the web

[#](#start-developing)

Now that you've set up web development for Flutter,
you can continue your Flutter learning journey while testing on the web
or begin expanding integration with the web.


![Dash helping you explore Flutter learning resources.](/assets/images/decorative/pointing-the-way.png)

Continue learning Flutter

- [Write your first app](/get-started/codelab)
- [Learn the fundamentals](/learn/pathway)
- [Explore Flutter widgets](https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Check out samples](/reference/learning-resources)

![A representation of Flutter on multiple devices.](/assets/images/decorative/flutter-on-phone.svg)

Build for the web

- [Build a web app with Flutter](/platform-integration/web/building)
- [Customize app initialization](/platform-integration/web/initialization)
- [Compile to Wasm](/platform-integration/web/wasm)
- [Integrate web content](/platform-integration/web/web-content-in-flutter)
- [Embed in another web app](/platform-integration/web/embedding-flutter-web)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-16. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/setup.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/setup&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/setup.md "Report an issue with this page").