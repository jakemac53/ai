---
name: add-a-flutter-view-to-an-android-app
description: Learn how to perform advanced integrations via Flutter Views.
metadata:
  url: https://docs.flutter.dev/add-to-app/android/add-flutter-view
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Add a Flutter View to an Android app

warningWarning

Integrating via a [FlutterView](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

is advanced usage and requires manually creating custom, application specific
bindings.


Integrating via a [FlutterView](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

requires a bit more work than via FlutterActivity and FlutterFragment previously
described.


Fundamentally, the Flutter framework on the Dart side requires access to various
activity-level events and lifecycles to function. Since the FlutterView (which
is an [android.view.View](https://developer.android.com/reference/android/view/View.html))
can be added to any activity which is owned by the developer's application
and since the FlutterView doesn't have access to activity level events, the
developer must bridge those connections manually to the [FlutterEngine](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html).


How you choose to feed your application's activities' events to the FlutterView
will be specific to your application.


## A sample

[#](#a-sample)

![Add Flutter View sample video](/assets/images/docs/development/add-to-app/android/add-flutter-view/add-view-sample.webp)

Unlike the guides for FlutterActivity and FlutterFragment, the FlutterView
integration could be better demonstrated with a sample project.


A sample project is at [https://github.com/flutter/samples/tree/main/add\_to\_app/android\_view](https://github.com/flutter/samples/tree/main/add_to_app/android_view)

to document a simple FlutterView integration where FlutterViews are used
for some of the cells in a RecycleView list of cards as seen in the gif above.


## General approach

[#](#general-approach)

The general gist of the FlutterView-level integration is that you
must recreate the various interactions between your Activity, the
[`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

and the
[`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html)

present in the [`FlutterActivityAndFragmentDelegate`](https://cs.opensource.google/flutter/engine/+/main:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)

in your own application's code.
The connections made in the
[`FlutterActivityAndFragmentDelegate`](https://cs.opensource.google/flutter/engine/+/main:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)

are done automatically when using a
[`FlutterActivity`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity.html)

or a
[`FlutterFragment`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.html),
but since the [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

in this case is being added to an `Activity` or `Fragment` in your application,
you must recreate the connections manually.
Otherwise, the [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

won't render anything or have other missing functionalities.


A sample
[`FlutterViewEngine`](https://github.com/flutter/samples/blob/main/add_to_app/android_view/android_view/app/src/main/java/dev/flutter/example/androidView/FlutterViewEngine.kt)

class shows one such possible implementation of an application-specific
connection between an `Activity`, a
[`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

and a [FlutterEngine](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html).


### APIs to implement

[#](#apis-to-implement)

The absolute minimum implementation needed for Flutter
to draw anything at all is to:


- Call [`attachToFlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html#attachToFlutterEngine-io.flutter.embedding.engine.FlutterEngine-)

   when the
   [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

   is added to a resumed `Activity`'s view hierarchy and is visible; and

- Call [`appIsResumed`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/LifecycleChannel.html#appIsResumed--)

   on the [`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html)'s
   `lifecycleChannel` field when the `Activity` hosting the
   [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html)

   is visible.


The reverse
[`detachFromFlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html#detachFromFlutterEngine--)

and other lifecycle methods on the
[`LifecycleChannel`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/systemchannels/LifecycleChannel.html)

class must also be called to not leak resources when the
`FlutterView` or `Activity` is no longer visible.


In addition, see the remaining implementation in the
[`FlutterViewEngine`](https://github.com/flutter/samples/blob/main/add_to_app/android_view/android_view/app/src/main/java/dev/flutter/example/androidView/FlutterViewEngine.kt)

demo class or in the
[`FlutterActivityAndFragmentDelegate`](https://cs.opensource.google/flutter/engine/+/main:shell/platform/android/io/flutter/embedding/android/FlutterActivityAndFragmentDelegate.java)

to ensure a correct functioning of other features such as clipboards,
system UI overlay, plugins, and so on.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-5. [View source](https://github.com/flutter/website/blob/main/src/content/add-to-app/android/add-flutter-view.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/add-to-app/android/add-flutter-view&page-source=https://github.com/flutter/website/blob/main/src/content/add-to-app/android/add-flutter-view.md "Report an issue with this page").