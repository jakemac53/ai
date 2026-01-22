---
name: targeting-chromeos-with-android
description: Platform-specific considerations for building for ChromeOS with Flutter.
metadata:
  url: https://docs.flutter.dev/platform-integration/android/chromeos
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Targeting ChromeOS with Android

This page discusses considerations unique to building
Android apps that support ChromeOS with Flutter.


## Flutter & ChromeOS tips & tricks

[#](#flutter-chromeos-tips-tricks)

For the current versions of ChromeOS, only certain ports from
Linux are exposed to the rest of the environment.
Here's an example of how to launch
Flutter DevTools for an Android app with ports
that will work:


```
$ flutter pub global run devtools --port 8000
$ cd path/to/your/app
$ flutter run --observatory-port=8080

```

content\_copy

Then, navigate to http://127.0.0.1:8000/#
in your Chrome browser and enter the URL to your
application. The last `flutter run` command you
just ran should output a URL similar to the format
of `http://127.0.0.1:8080/auth_code=/`. Use this URL
and select "Connect" to start the Flutter DevTools
for your Android app.


#### Flutter ChromeOS lint analysis

[#](#flutter-chromeos-lint-analysis)

Flutter has ChromeOS-specific lint analysis checks
to make sure that the app that you're building
works well on ChromeOS. It looks for things
like required hardware in your Android Manifest
that aren't available on ChromeOS devices,
permissions that imply requests for unsupported
hardware, as well as other properties or code
that would bring a lesser experience on these devices.


To activate these,
you need to create a new analysis\_options.yaml
file in your project folder to include these options.
(If you have an existing analysis\_options.yaml file,
you can update it)


yaml

```
include: package:flutter/analysis_options_user.yaml
analyzer:
 optional-checks:
   chrome-os-manifest-checks

```

content\_copy

To run these from the command line, use the following command:

```
$ flutter analyze

```

content\_copy

Sample output for this command might look like:

```
Analyzing ...
warning • This hardware feature is not supported on ChromeOS •
android/app/src/main/AndroidManifest.xml:4:33 • unsupported_chrome_os_hardware

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2024-4-4. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/android/chromeos.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/android/chromeos&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/android/chromeos.md "Report an issue with this page").