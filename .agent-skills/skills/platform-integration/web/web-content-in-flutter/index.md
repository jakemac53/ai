---
name: embedding-web-content-into-a-flutter-web-app
description: Learn how to load and display images on the web.
metadata:
  url: https://docs.flutter.dev/platform-integration/web/web-content-in-flutter
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Embedding web content into a Flutter web app

In some cases, Flutter web applications need to embed web content not
rendered by Flutter. For example, embedding a `google_maps_flutter` view
(which uses the Google Maps JavaScript SDK) or a `video_player`
(which uses a standard `video` element).


Flutter web can render arbitrary web content within the boundaries of a `Widget`,
and the primitives used to implement the example packages mentioned previously,
are available to all Flutter web applications.


## `HtmlElementView`

[#](#htmlelementview)

The `HtmlElementView` Flutter widget reserves a space in the layout to be
filled with any HTML Element. It has two constructors:


- `HtmlElementView.fromTagName`.
- `HtmlElementView` and `registerViewFactory`.

### `HtmlElementView.fromTagName`

[#](#htmlelementview-fromtagname)

The [`HtmlElementView.fromTagName` constructor](https://api.flutter.dev/flutter/widgets/HtmlElementView/HtmlElementView.fromTagName.html)
creates an HTML Element from
its `tagName`, and provides an `onElementCreated` method to configure that
element before it's injected into the DOM:


dart

```
// Create a `video` tag, and set its `src` and some `style` properties...
HtmlElementView.fromTag('video', onElementCreated: (Object video) {
  video as web.HTMLVideoElement;
  video.src = 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4';
  video.style.width = '100%';
  video.style.height = '100%';
  // other customizations to the element...
});

```

content\_copy

To learn more about the way to interact with DOM APIs,
check out the [`HTMLVideoElement` class](https://pub.dev/documentation/web/latest/web/HTMLVideoElement-extension-type.html)
in [`package:web`](https://pub.dev/packages/web).


To learn more about the video `Object` that is cast to `web.HTMLVideoElement`,
check out Dart's [JS Interoperability](https://dart.dev/interop/js-interop)
documentation.


### `HtmlElementView` and `registerViewFactory`

[#](#htmlelementview-and-registerviewfactory)

If you need more control over generating the HTML code you inject, you can use
the primitives that Flutter uses to implement the `fromTagName` constructor. In
this scenario, register your own HTML Element factory for each type of HTML
content that needs to be added to your app.


The resulting code is more verbose, and has two steps per platform view type:

1. Register the HTML Element Factory using
    `platformViewRegistry.registerViewFactory` provided by `dart:ui_web.`
2. Place the widget with the desired `viewType` with
    `HtmlElementView('viewType')` in your app's widget tree.


For more details about this approach, check out
[`HtmlElementView` widget](https://api.flutter.dev/flutter/widgets/HtmlElementView-class.html)
docs.


## `package:webview_flutter`

[#](#package-webview-flutter)

Embedding a full HTML page inside a Flutter app is such a common feature, that
the Flutter team offers a plugin to do so:


- [`package:webview_flutter`](https://pub.dev/packages/webview_flutter)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/web-content-in-flutter.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/web-content-in-flutter&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/web-content-in-flutter.md "Report an issue with this page").