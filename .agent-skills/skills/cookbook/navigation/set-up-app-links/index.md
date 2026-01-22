---
name: set-up-app-links-for-android
description: Learn how to set up app links for an Android application built with Flutter.
metadata:
  url: https://docs.flutter.dev/cookbook/navigation/set-up-app-links
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up app links for Android

Deep linking is a mechanism for launching an app with a URI.
This URI contains scheme, host, and path,
and opens the app to a specific screen.


An _app link_ is a type of deep link that uses
`http` or `https` and is exclusive to Android devices.


Setting up app links requires one to own a web domain.
Otherwise, consider using [Firebase Hosting](https://firebase.google.com/docs/hosting)

or [GitHub Pages](https://pages.github.com) as a temporary solution.


Once you've set up your deep links, you can validate them.
To learn more, see [Validate deep links](/tools/devtools/deep-links).


## 1\. Customize a Flutter application

[#](#1-customize-a-flutter-application)

Write a Flutter app that can handle an incoming URL.
This example uses the [go\_router](https://pub.dev/packages/go_router) package to handle the routing.
The Flutter team maintains the `go_router` package.
It provides a simple API to handle complex routing scenarios.


1. To create a new application, type `flutter create <app-name>`:





   ```
   $ flutter create deeplink_cookbook

   ```

   content\_copy

2. To include `go_router` package in your app,
    add a dependency for `go_router` to the project:

   To add the `go_router` package as a dependency,
    run `flutter pub add`:





   ```
   $ flutter pub add go_router

   ```

   content\_copy

3. To handle the routing,
    create a `GoRouter` object in the `main.dart` file:



   main.dart



   dart

   ```
   import 'package:flutter/material.dart';
   import 'package:go_router/go_router.dart';
   ​
   void main() => runApp(MaterialApp.router(routerConfig: router));
   ​
   /// This handles '/' and '/details'.
   final router = GoRouter(
     routes: [
       GoRoute(
         path: '/',
         builder: (_, _) => Scaffold(
           appBar: AppBar(title: const Text('Home Screen')),
         ),
         routes: [
           GoRoute(
             path: 'details',
             builder: (_, _) => Scaffold(
               appBar: AppBar(title: const Text('Details Screen')),
             ),
           ),
         ],
       ),
     ],
   );

   ```

   content\_copy


## 2\. Modify AndroidManifest.xml

[#](#2-modify-androidmanifest-xml)

1. Open the Flutter project with VS Code or Android Studio.

2. Navigate to `android/app/src/main/AndroidManifest.xml` file.

3. Add the following metadata tag and intent filter inside the
    `<activity>` tag with `.MainActivity`.

   Replace `example.com` with your own web domain.



   xml

   ```
   <intent-filter android:autoVerify="true">
       <action android:name="android.intent.action.VIEW" />
       <category android:name="android.intent.category.DEFAULT" />
       <category android:name="android.intent.category.BROWSABLE" />
       <data android:scheme="http" android:host="example.com" />
       <data android:scheme="https" />
   </intent-filter>

   ```

   content\_copy




   merge\_typeVersion note





   If you use a Flutter version earlier than 3.27,
   you need to manually opt in to deep linking by
   adding the following metadata tag to `<activity>`:





   xml

   ```
   <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />

   ```

   content\_copy







   infoNote





   If you use a third-party plugin to handle deep links,
   such as [app\_links](https://pub.dev/packages/app_links),
   Flutter's default deeplink handler will
   break these plugins.



   To opt out of using Flutter's default deep link handler,
   add the following metadata tag to `<activity>`:





   xml

   ```
   <meta-data android:name="flutter_deeplinking_enabled" android:value="false" />

   ```

   content\_copy


## 3\. Hosting assetlinks.json file

[#](#3-hosting-assetlinks-json-file)

Host an `assetlinks.json` file in using a web server
with a domain that you own. This file tells the
mobile browser which Android application to open instead
of the browser. To create the file,
get the package name of the Flutter app you created in
the previous step and the sha256 fingerprint of the
signing key you will be using to build the APK.


### Package name

[#](#package-name)

Locate the package name in `AndroidManifest.xml`,
the `package` property under `<manifest>` tag.
Package names are usually in the format of `com.example.*`.


### sha256 fingerprint

[#](#sha256-fingerprint)

The process might differ depending on how the apk is signed.

#### Using google play app signing

[#](#using-google-play-app-signing)

You can find the sha256 fingerprint directly from play
developer console. Open your app in the play console,
under **Release> Setup > App Integrity> App Signing tab**:


![Screenshot of sha256 fingerprint in play developer console](/assets/images/docs/cookbook/set-up-app-links-pdc-signing-key.png)

#### Using local keystore

[#](#using-local-keystore)

If you are storing the key locally,
you can generate sha256 using the following command:


```
keytool -list -v -keystore <path-to-keystore>

```

content\_copy

### assetlinks.json

[#](#assetlinks-json)

The hosted file should look similar to this:

json

```
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example.deeplink_cookbook",
    "sha256_cert_fingerprints":
    ["FF:2A:CF:7B:DD:CC:F1:03:3E:E8:B2:27:7C:A2:E3:3C:DE:13:DB:AC:8E:EB:3A:B9:72:A1:0E:26:8A:F5:EC:AF"]
  }
}]

```

content\_copy

1. Set the `package_name` value to your Android application ID.

2. Set sha256\_cert\_fingerprints to the value you got
    from the previous step.

3. Host the file at a URL that resembles the following:
    `<webdomain>/.well-known/assetlinks.json`

4. Verify that your browser can access this file.


infoNote

If you have multiple flavors, you can have many sha256\_cert\_fingerprint
values in the sha256\_cert\_fingerprints field.
Just add it to the sha256\_cert\_fingerprints list


## Testing

[#](#testing)

You can use a real device or the Emulator to test an app link,
but first make sure you have executed `flutter run` at least once on
the devices. This ensures that the Flutter application is installed.


![Emulator screenshot](/assets/images/docs/cookbook/set-up-app-links-emulator-installed.png)

To test **only** the app setup, use the adb command:

```
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://<web-domain>/details"' \
    <package name>

```

content\_copy

infoNote

This doesn't test whether the web files are
hosted correctly,
the command launches the app even
if web files are not presented.


To test **both** web and app setup, you must click a link
directly through web browser or another app.
One way is to create a Google Doc, add the link, and tap on it.


infoNote

If you are debugging locally (and not downloading the app from the Play Store),
you might need to enable the toggle for **Supported web addresses**
manually.


If everything is set up correctly, the Flutter application
launches and displays the details screen:


![Deeplinked Emulator screenshot](/assets/images/docs/cookbook/set-up-app-links-emulator-deeplinked.png)

## Appendix

[#](#appendix)

Source code: [deeplink\_cookbook](https://github.com/flutter/codelabs/tree/main/deeplink_cookbook)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/set-up-app-links.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/navigation/set-up-app-links&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/navigation/set-up-app-links.md "Report an issue with this page").