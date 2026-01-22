---
name: set-up-ios-development
description: Configure your development environment to run, build, and deploy Flutter apps for iOS devices.
metadata:
  url: https://docs.flutter.dev/platform-integration/ios/setup#set-up-devices
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up iOS development

Learn how to set up your development environment
to run, build, and deploy Flutter apps for iOS devices.


infoNote

If you haven't set up Flutter already,
visit and follow the [Get started with Flutter](/get-started) guide first.


If you've already installed Flutter,
ensure that it's [up to date](/install/upgrade).


## Set up iOS tooling

[#](#set-up-tooling)

With Xcode, you can run Flutter apps on
an iOS physical device or on the iOS Simulator.


1. ### Install Xcode


   If you haven't done so already,
    [install and set up the latest version of Xcode](https://developer.apple.com/xcode/).

   If you've already installed Xcode,
    update it to the latest version using the
    same installation method you used originally.

2. ### Set up Xcode command-line tools


   To configure the Xcode command-line tools to use
    the version of Xcode you installed,
    run the following command in your preferred terminal:





   ```
   $ sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'

   ```

   content\_copy



   If you downloaded Xcode elsewhere or need to use a different version,
    replace `/Applications/Xcode.app` with the path to there instead.

3. ### Agree to the Xcode licenses


   After you've set up Xcode and configured its command-line tools,
    agree to the Xcode licenses.
   1. Open your preferred terminal.

   2. Run the following command to review and sign the Xcode licenses.





      ```
      $ sudo xcodebuild -license

      ```

      content\_copy

   3. Read and agree to all necessary licenses.

      Before agreeing to the terms of each license,
       read each with care.
4. ### Download prerequisite tooling


   To download iOS platform support and
    the latest iOS Simulator runtimes,
    run the following command in your preferred terminal.





   ```
   $ xcodebuild -downloadPlatform iOS

   ```

   content\_copy

5. ### Install Rosetta


   If you're developing on an [Apple Silicon](https://support.apple.com/en-us/116943) (ARM) Mac,
    [install Rosetta 2](https://support.apple.com/en-us/102527):





   ```
   $ sudo softwareupdate --install-rosetta --agree-to-license

   ```

   content\_copy

6. ### Install CocoaPods


   To support [Flutter plugins](/packages-and-plugins/developing-packages#types) that use native iOS or macOS code,
    install the latest version of [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation).

   Install CocoaPods by following the
    [CocoaPods installation guide](https://guides.cocoapods.org/using/getting-started.html#installation).

   If you've already installed CocoaPods,
    update it by following the [CocoaPods update guide](https://guides.cocoapods.org/using/getting-started.html#updating-cocoapods).


## Set up an iOS device

[#](#set-up-devices)

We recommend starting with the iOS Simulator as
it's easier to get set up than a physical iOS device.
However, you should also test your app on an actual
physical device.


- [Simulator](#170-tab-panel)
- [Physical device](#171-tab-panel)

Start the iOS Simulator with the following command:

```
$ open -a Simulator

```

content\_copy

If you need to install a simulator for a different OS version,
check out [Downloading and installing additional Xcode components](https://developer.apple.com/documentation/xcode/downloading-and-installing-additional-xcode-components)

on the Apple Developer site.


warningWarning

An upcoming change to iOS has caused a temporary break in Flutter's debug mode
on physical devices running iOS 26 (currently in beta).
If your physical device is already on iOS 26, we recommend switching to the
**Simulator** tab and following the instructions.
See [Flutter on latest iOS](/platform-integration/ios/ios-latest)
for details.


Set up each iOS device on which you want to test.

1. ### Configure your physical iOS device

1. Attach your iOS device to the USB port on your Mac.

2. On first connecting an iOS device to your Mac,
       your device displays the **Trust this computer?** dialog.

3. Click **Trust**.

      ![Trust Mac](/assets/images/docs/setup/trust-computer.png)
2. ### Configure your physical iOS device


Apple requires enabling **[Developer Mode](https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device)**

    on the device to protect against malicious software.
1. Tap on **Settings** > **Privacy & Security** > **Developer Mode**.

2. Tap to toggle **Developer Mode** to **On**.

3. Restart the device.

4. When the **Turn on Developer Mode?** dialog appears,
       tap **Turn On**.
3. ### Create a developer code signing certificate


To send your app to a physical iOS device,
    _even_ for testing, you must establish trust
    between your Mac and the device.
    In addition to trusting the device when that
    popup appears, you must upload a signed
    developer certificate to your device.

To create a signed development certificate,
    you need an Apple ID.
    If you don't have one, [create one](https://support.apple.com/en-us/108647).
    You must also enroll in the [Apple Developer program](https://developer.apple.com/programs/)

    and create an [Apple Developer account](https://developer.apple.com/account).
    If you're just _testing_ your app on an iOS device,
    a personal Apple Developer account is free and works.


infoApple Developer program





When you want to _deploy_ your app to the App Store,
you'll need to upgrade your personal Apple Developer account to
a professional account.

4. ### Prepare the device

1. Find the **VPN & Device Management** menu under **Settings**.

      Toggle your certificate to **Enable**.


      infoNote





      If you can't find the **VPN & Device Management** menu,
      run your app on your iOS device once, then try again.

2. Under the **Developer App** heading,
       you should find your certificate.

3. Tap the certificate.

4. Tap **Trust "<certificate>"**.

5. When the dialog displays, tap **Trust**.

      If the **codesign wants to access key...** dialog appears:

      1. Enter your macOS password.

      2. Tap **Always Allow**.

* * *

## Start developing for iOS

[#](#start-developing)

**Congratulations.**
Now that you've set up iOS development for Flutter,
you can continue your Flutter learning journey while testing on iOS
or begin improving integration with iOS.


![Dash helping you explore Flutter learning resources.](/assets/images/decorative/pointing-the-way.png)

Continue learning Flutter

- [Write your first app](/get-started/codelab)
- [Learn the fundamentals](/learn/pathway)
- [Explore Flutter widgets](https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Check out samples](/reference/learning-resources)

![A representation of Flutter on multiple devices.](/assets/images/decorative/flutter-on-phone.svg)

Build for iOS

- [Build and deploy to iOS](/deployment/ios)
- [Bind to native iOS code](/platform-integration/ios/c-interop)
- [Leverage system frameworks](/platform-integration/ios/apple-frameworks)
- [Embed native iOS views](/platform-integration/ios/platform-views)
- [Use Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-16. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/setup.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/ios/setup&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/setup.md "Report an issue with this page").