---
name: leveraging-apple-s-system-apis-and-frameworks
description: Learn about Flutter plugins that offer equivalent functionalities to Apple's frameworks.
metadata:
  url: https://docs.flutter.dev/platform-integration/ios/apple-frameworks
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Leveraging Apple's system APIs and frameworks

When you come from iOS development, you might need to find
Flutter plugins that offer the same abilities as Apple's system
libraries. This might include accessing device hardware or interacting
with specific frameworks like `HealthKit`.


For an overview of how the SwiftUI framework compares to Flutter,
see [Flutter for SwiftUI developers](/get-started/flutter-for/swiftui-devs).


## Introducing Flutter plugins

[#](#introducing-flutter-plugins)

Dart calls libraries that contain platform-specific code _plugins_,
short for "plugin package".
When developing an app with Flutter, you use _plugins_ to interact
with system libraries.


In your Dart code, you use the plugin's Dart API to call the native
code from the system library being used. This means that you can write
the code to call the Dart API. The API then makes it work for all
platforms that the plugin supports.


To learn more about plugins, see [Using packages](/packages-and-plugins/using-packages).
Though this page links to some popular plugins,
you can find thousands more, along with examples,
on [pub.dev](https://pub.dev/packages).
The following table does not endorse any particular plugin.
If you can't find a package that meets your needs,
you can create your own or
use platform channels directly in your project.
To learn more, check out [Writing platform-specific code](/platform-integration/platform-channels).


## Adding a plugin to your project

[#](#adding-a-plugin-to-your-project)

To use an Apple framework within your native project,
import it into your Swift or Objective-C file.


To add a Flutter plugin, run `flutter pub add package_name`
from the root of your project.
This adds the dependency to your [`pubspec.yaml`](/tools/pubspec)
file.
After you add the dependency, add an `import` statement for the package
in your Dart file.


You might need to change app settings or initialization logic.
If that's needed, the package's "Readme" page on [pub.dev](https://pub.dev/packages)

should provide details.


### Flutter Plugins and Apple Frameworks

[#](#flutter-plugins-and-apple-frameworks)

Use CaseApple Framework or ClassFlutter PluginAccess the photo library`PhotoKit`
using the
`Photos`
and
`PhotosUI `
frameworks and
`UIImagePickerController`[`image_picker`](https://pub.dev/packages/image_picker)Access the camera`UIImagePickerController` using the `.camera` `sourceType`[`image_picker`](https://pub.dev/packages/image_picker)Use advanced camera features`AVFoundation`[`camera`](https://pub.dev/packages/camera)Offer In-app purchases`StoreKit`[`in_app_purchase`](https://pub.dev/packages/in_app_purchase) [1](#fn-1)Process payments`PassKit`[`pay`](https://pub.dev/packages/pay) [2](#fn-2)Send push notifications`UserNotifications`[`firebase_messaging`](https://pub.dev/packages/firebase_messaging) [3](#fn-3)Access GPS coordinates`CoreLocation`[`geolocator`](https://pub.dev/packages/geolocator)Access sensor data[4](#fn-4)`CoreMotion`[`sensors_plus`](https://pub.dev/packages/sensors_plus)Make network requests`URLSession`[`http`](https://pub.dev/packages/http)Store key-values`@AppStorage` property wrapper and `NSUserDefaults`[`shared_preferences`](https://pub.dev/packages/shared_preferences)Persist to a database`CoreData` or SQLite[`sqflite`](https://pub.dev/packages/sqflite)Access health data`HealthKit`[`health`](https://pub.dev/packages/health)Use machine learning`CoreML`[`google_ml_kit`](https://pub.dev/packages/google_ml_kit) [5](#fn-5)Recognize text`VisionKit`[`google_ml_kit`](https://pub.dev/packages/google_ml_kit) [5](#fn-5)Recognize speech`Speech`[`speech_to_text`](https://pub.dev/packages/speech_to_text)Use augmented reality`ARKit`[`ar_flutter_plugin`](https://pub.dev/packages/ar_flutter_plugin)Access weather data`WeatherKit`[`weather`](https://pub.dev/packages/weather) [6](#fn-6)Access and manage contacts`Contacts`[`contacts_service`](https://pub.dev/packages/contacts_service)Expose quick actions on the home screen`UIApplicationShortcutItem`[`quick_actions`](https://pub.dev/packages/quick_actions)Index items in Spotlight search`CoreSpotlight`[`flutter_core_spotlight`](https://pub.dev/packages/flutter_core_spotlight)Configure, update and communicate with Widgets`WidgetKit`[`home_widget`](https://pub.dev/packages/home_widget)Automate app actions with Siri/Shortcuts`AppIntents`[`intelligence`](https://pub.dev/packages/intelligence)

1. Supports both Google Play Store on Android and Apple App Store on iOS. [↩](#fnref-1)

2. Adds Google Pay payments on Android and Apple Pay payments on iOS. [↩](#fnref-2)

3. Uses Firebase Cloud Messaging and integrates with APNs. [↩](#fnref-3)

4. Includes sensors like accelerometer, gyroscope, etc. [↩](#fnref-4)

5. Uses Google's ML Kit and supports various features like text recognition, face detection, image labeling, landmark recognition, and barcode scanning. You can also create a custom model with Firebase. To learn more, see
    [Use a custom TensorFlow Lite model with Flutter](https://firebase.google.com/docs/ml/flutter/use-custom-models).
    [↩](#fnref-5) [↩2](#fnref-5-2)

6. Uses the [OpenWeatherMap API](https://openweathermap.org/api). Other packages exist that can pull from different weather APIs.
    [↩](#fnref-6)


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-25. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/apple-frameworks.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/ios/apple-frameworks&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/apple-frameworks.md "Report an issue with this page").