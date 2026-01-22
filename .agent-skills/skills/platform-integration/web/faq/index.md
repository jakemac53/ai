---
name: web-faq
description: Some gotchas and differences when writing or running web apps in Flutter.
metadata:
  url: https://docs.flutter.dev/platform-integration/web/faq
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Web FAQ

## Questions

[#](#questions)

### What scenarios are ideal for Flutter on the web?

[#](#what-scenarios-are-ideal-for-flutter-on-the-web)

Not every web page makes sense in Flutter, but we think Flutter is particularly
suited for app-centric experiences:


- Progressive Web Apps
- Single Page Apps
- Existing Flutter mobile apps

At this time, Flutter is not suitable for static websites with text-rich
flow-based content. For example, blog articles benefit from the document-centric
model that the web is built around, rather than the app-centric services that a
UI framework like Flutter can deliver. However, you _can_ use Flutter to embed
interactive experiences into these websites.


For more information on how you can use Flutter on the web,
see [Web support for Flutter](/platform-integration/web).


### Search Engine Optimization (SEO)

[#](#search-engine-optimization-seo)

In general, Flutter is geared towards dynamic application experiences. Flutter's
web support is no exception. Flutter web prioritizes performance, fidelity, and
consistency. This means application output does not align with what search
engines need to properly index. For web content that is static or document-like,
we recommend using HTML—just like we do on [flutter.dev](https://flutter.dev),
[dart.dev](https://dart.dev), and [pub.dev](https://pub.dev). You should also
consider separating your primary application experience—created in Flutter—from
your landing page, marketing content, and help content—created using
search-engine optimized HTML.


That said, as mentioned in the [roadmap](https://github.com/flutter/flutter/blob/master/docs/roadmap/Roadmap.md#web-platform), the Flutter team plans to
investigate search engine indexability of Flutter web.


### Does hot reload work with a web app?

[#](#does-hot-reload-work-with-a-web-app)

Yes! For more information, check out
[hot reload on the web](/platform-integration/web/building#hot-reload-web).


Hot restart is a fast way of seeing your
changes without having to relaunch your web app and wait for it
to compile and load. This works similarly to
the hot reload feature for Flutter mobile development.
The difference is that hot reload remembers your state and hot
restart doesn't.


### Which web browsers are supported by Flutter?

[#](#which-web-browsers-are-supported-by-flutter)

Flutter web apps can run on the following browsers:

- Chrome (mobile & desktop)
- Safari (mobile & desktop)
- Edge (mobile & desktop)
- Firefox (mobile & desktop)

During development, Chrome (on macOS, Windows, and Linux) and Edge (on Windows)
are supported as the default browsers for debugging your app.


### Can I build, run, and deploy web apps in any of the IDEs?

[#](#can-i-build-run-and-deploy-web-apps-in-any-of-the-ides)

You can select **Chrome** or **Edge** as the target device in
Android Studio/IntelliJ and VS Code.


The device pulldown should now include the **Chrome (web)**
option for all channels.


### How do I build a responsive app for the web?

[#](#how-do-i-build-a-responsive-app-for-the-web)

See [Creating responsive apps](/ui/adaptive-responsive).

### Can I use `dart:io` with a web app?

[#](#can-i-use-dart-io-with-a-web-app)

No. The file system is not accessible from the browser.
For network functionality, use the [`http`](https://pub.dev/packages/http)

package. Note that security works somewhat
differently because the browser (and not the app)
controls the headers on an HTTP request.


### How do I handle web-specific imports?

[#](#how-do-i-handle-web-specific-imports)

Some plugins require platform-specific imports, particularly if they use the
file system, which is not accessible from the browser. To use these plugins
in your app, see the [documentation for conditional imports](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files)

on [dart.dev](https://dart.dev).


### Does Flutter web support concurrency?

[#](#does-flutter-web-support-concurrency)

Dart's concurrency support via [isolates](https://dart.dev/guides/language/concurrency)
is not currently supported in Flutter web.


Flutter web apps can potentially work around this
by using [web workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers),
although no such support is built in.


### How do I deploy a web app?

[#](#how-do-i-deploy-a-web-app)

See [Preparing a web app for release](/deployment/web).

### Does `Platform.is` work on the web?

[#](#does-platform-is-work-on-the-web)

Not currently.

### Why doesn't my app update immediately after it's deployed?

[#](#why-doesnt-my-app-update-immediately-after-its-deployed)

You might need to configure the `Cache-Control` header returned by your web server.
For example, if this header is set to 3600, then the browser
and CDN will cache the asset for 1 hour, and your users might see an out-of-date
version of your app up to 1 hour after you deploy a new version. For
more information about caching on the web,
check out [Prevent unnecessary network requests with the HTTP Cache](https://web.dev/articles/http-cache).


It is a good idea to be aware of this behavior to avoid an undesirable user experience.
After you deploy your app, users might use a
cached version of your app (cached by the browser or CDN)
for the duration defined by your cache headers.
This can lead to users using a version of your app that
is incompatible with changes that have been deployed to backend services.


### How do I clear the web cache after a deployment and force an app download?

[#](#how-do-i-clear-the-web-cache-after-a-deployment-and-force-an-app-download)

If you wish to defeat these cache headers after each deployment, a common
technique is to append a build ID of some sort to the links of your static
resources, or update the filenames themselves.
For example, `logo.png` might become `logo.v123.png`.


html

```
<!-- Option 1, append build ID as a query parameter in your links -->
<script src="flutter_bootstrap.js?v=123" async></script>
​
<!-- Option 2, update the filename and update your links -->
<script src="flutter_bootstrap.v123.js" async></script>

```

content\_copy

Flutter does not currently support appending build IDs to resources
automatically.


### How do I configure my cache headers?

[#](#how-do-i-configure-my-cache-headers)

If you are using Firebase Hosting,
the shared cache (CDN) is invalidated when you deploy a new version of your
app. But you might choose to configure your cache headers as follows,
so that the browser cache doesn't cache application scripts,
but the shared cache does.


json

```
{
  "hosting": {
    "headers": [
      {
        "source":
          "**/*.@(jpg|jpeg|gif|png|svg|webp|css|eot|otf|ttf|ttc|woff|woff2|font.css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=3600,s-maxage=604800"
          }
        ]
      },
      {
        "source":
          "**/*.@(mjs|js|wasm|json)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=0,s-maxage=604800"
          }
        ]
      }
    ]
  }
}

```

content\_copy

### How do I configure a service worker?

[#](#how-do-i-configure-a-service-worker)

The service worker generated by `flutter build web` is deprecated,
and you can disable it by setting the `--pwa-strategy` flag to `none`

when running the `flutter build web` command.


```
flutter build web --pwa-strategy=none

```

content\_copy

If you would like to continue to use a service worker, you can
[build your own](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API/Using_Service_Workers)
or try third-party tools
such as [Workbox](https://github.com/GoogleChrome/workbox).


If your service worker is not refreshing,
configure your CDN and browser cache by setting
the `Cache-Control` header to a small value such as 0 or 60 seconds.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-11-26. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/web/faq.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/web/faq&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/web/faq.md "Report an issue with this page").