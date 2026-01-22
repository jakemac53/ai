---
name: build-and-release-a-web-app
description: How to prepare for and release a web app.
metadata:
  url: https://docs.flutter.dev/deployment/web
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Build and release a web app

During a typical development cycle,
you test an app using `flutter run -d chrome`
(for example) at the command line.
This builds a _debug_ version of your app.


This page helps you prepare a _release_ version
of your app and covers the following topics:


- [Building the app for release](#building-the-app-for-release)
- [Deploying to the web](#deploying-to-the-web)
- [Deploying to Firebase Hosting](#deploying-to-firebase-hosting)
- [Handling images on the web](#handling-images-on-the-web)
- [Choosing a build mode and a renderer](#choosing-a-build-mode-and-a-renderer)
- [Minification](#minification)

## Building the app for release

[#](#building-the-app-for-release)

Build the app for deployment using the `flutter build web` command.

```
flutter build web

```

content\_copy

This
generates the app, including the assets, and places the files into the
`/build/web` directory of the project.


To validate the release build of your app,
launch a web server (for example,
`python -m http.server 8000`,
or by using the [dhttpd](https://pub.dev/packages/dhttpd) package),
and open the /build/web directory. Navigate to
`localhost:8000` in your browser
(given the python SimpleHTTPServer example)
to view the release version of your app.


## Additional build flags

[#](#additional-build-flags)

You might need to deploy a profile or debug build for testing.
To do this, pass the `--profile` or `--debug` flag
to the `flutter build web` command.
Profile builds are specialized for performance profiling using Chrome DevTools,
and debug builds can be used to configure dart2js
to respect assertions and change the optimization level (using the `-O`
flag.)


## Choosing a build mode and a renderer

[#](#choosing-a-build-mode-and-a-renderer)

Flutter web provides two build modes (default and WebAssembly) and two renderers
( `canvaskit` and `skwasm`).


For more information, see [Web renderers](/platform-integration/web/renderers).

## Deploying to the web

[#](#deploying-to-the-web)

When you are ready to deploy your app,
upload the release bundle
to Firebase, the cloud, or a similar service.
Here are a few possibilities, but there are
many others:


- [Firebase Hosting](https://firebase.google.com/docs/hosting/frameworks/flutter)
- [GitHub Pages](https://pages.github.com/)
- [Google Cloud Hosting](https://cloud.google.com/solutions/web-hosting)

## Deploying to Firebase Hosting

[#](#deploying-to-firebase-hosting)

You can use the Firebase CLI to build and release your Flutter app with Firebase
Hosting.


### Before you begin

[#](#before-you-begin)

To get started, [install or update](https://firebase.google.com/docs/cli#install_the_firebase_cli)
the Firebase CLI:


```
npm install -g firebase-tools

```

content\_copy

### Initialize Firebase

[#](#initialize-firebase)

1. Enable the web frameworks preview to the [Firebase framework-aware CLI](https://firebase.google.com/docs/hosting/frameworks/frameworks-overview):





   ```
   firebase experiments:enable webframeworks

   ```

   content\_copy

2. In an empty directory or an existing Flutter project, run the initialization
    command:





   ```
   firebase init hosting

   ```

   content\_copy

3. Answer `yes` when asked if you want to use a web framework.

4. If you're in an empty directory,
    you'll be asked to choose your web framework. Choose `Flutter Web`.

5. Choose your hosting source directory; this could be an existing flutter app.

6. Select a region to host your files.

7. Choose whether to set up automatic builds and deploys with GitHub.

8. Deploy the app to Firebase Hosting:





   ```
   firebase deploy

   ```

   content\_copy



    Running this command automatically runs `flutter build web --release`,
    so you don't have to build your app in a separate step.


To learn more, visit the official [Firebase Hosting](https://firebase.google.com/docs/hosting/frameworks/flutter)
documentation for
Flutter on the web.


## Handling images on the web

[#](#handling-images-on-the-web)

The web supports the standard `Image` widget to display images.
By design, web browsers run untrusted code without harming the host computer.
This limits what you can do with images compared to mobile and desktop platforms.


For more information, see [Displaying images on the web](/platform-integration/web/web-images).


## Minification

[#](#minification)

To improve app start-up the compiler reduces the size of the compiled code by
removing unused code (known as _tree shaking_), and by renaming code symbols to
shorter strings (e.g. by renaming `AlignmentGeometryTween` to something like
`ab`). Which of these two optimizations are applied depends on the build mode:


Type of web app buildCode minified?Tree shaking performed?debugNoNoprofileNoYesreleaseYesYes

## Embedding a Flutter app into an HTML page

[#](#embedding-a-flutter-app-into-an-html-page)

See [Embedding Flutter web](/platform-integration/web/embedding-flutter-web).

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/deployment/web.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/deployment/web&page-source=https://github.com/flutter/website/blob/main/src/content/deployment/web.md "Report an issue with this page").