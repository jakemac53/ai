---
name: web-support-for-flutter
description: Details of how Flutter supports the creation of web experiences.
metadata:
  url: https://docs.flutter.dev/platform-integration/web
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Web support for Flutter

Flutter delivers the same experiences on the web as on mobile.

Building on the portability of Dart, the power of the web platform, the
flexibility of the Flutter framework, and the performance of WebAssembly,
you can build apps for iOS, Android, and the browser from the same codebase.
The web is just another device target for your app.


To get started, visit [Building a web application with Flutter](/platform-integration/web/building).


## Powered by WebAssembly

[#](#powered-by-webassembly)

Dart and Flutter can compile to WebAssembly,
a binary instruction format that enables fast apps on all major browsers.


For a glimpse into the benefits of using WebAssembly,
check out the following video.


[Watch on YouTube in a new tab: "What's new in Flutter - WebAssembly"](https://www.youtube.com/watch/lpnKWK-KEYs)

## How it works

[#](#how-it-works)

Adding web support to Flutter involved implementing Flutter's
core drawing layer on top of standard browser APIs, in addition
to compiling Dart to JavaScript, instead of the ARM machine code that
is used for mobile applications. Using a combination of DOM, Canvas,
and WebAssembly, Flutter can provide a portable, high-quality,
and performant user experience across modern browsers.
We implemented the core drawing layer completely in Dart
and used Dart's optimized JavaScript compiler to compile the
Flutter core and framework along with your application
into a single, minified source file that can be deployed to
any web server.


![Flutter architecture for web](/assets/images/docs/arch-overview/web-framework-diagram.png)

## What types of apps can I build?

[#](#what-types-of-apps-can-i-build)

While you can do a lot on the web,
Flutter's web support is most valuable in the
following scenarios:


**Single Page Application**

Flutter's web support enables complex standalone web apps that are rich with
graphics and interactive content to reach end users on a wide variety of
devices.


**Existing mobile applications**

Web support for Flutter provides a browser-based delivery model for existing
Flutter mobile apps.


Not every HTML scenario is ideally suited for Flutter at this time.
For example, text-rich, flow-based, static content such as blog articles
benefit from the document-centric model that the web is built around,
rather than the app-centric services that a UI framework like Flutter
can deliver. However, you _can_ use Flutter to embed interactive
experiences into these websites.


## Get started

[#](#get-started)

The following resources can help you get started:

- To add web support to an existing app, or to create a
   new app that includes web support, see
   [Building a web application with Flutter](/platform-integration/web/building).

- To configure web development server settings in a centralized file, see [Set up a web development configuration file](/platform-integration/web/web-dev-config-file).

- To learn about Flutter's different web renderers (CanvasKit and Skwasm), see
   [Web renderers](/platform-integration/web/renderers).

- To learn how to create a responsive Flutter
   app, see [Creating responsive apps](/ui/adaptive-responsive).

- To view commonly asked questions and answers, see the
   [web FAQ](/platform-integration/web/faq).

- To see code examples,
   check out the [web samples for Flutter](https://github.com/flutter/samples/#?platform=web).

- To see a Flutter web app demo, check out the [Wonderous app](https://wonderous.app//web).
- To learn about deploying a web app, see
   [Preparing an app for web release](/deployment/web).

- [File an issue](https://goo.gle/flutter_web_issue) on the main Flutter repo.
- You can chat and ask web-related questions on the
   **#help** channel on [Discord](https://discordapp.com/invite/yeZ6s7k).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/index.md "Report an issue with this page").