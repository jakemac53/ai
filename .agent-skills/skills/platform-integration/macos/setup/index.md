---
name: set-up-macos-development
description: Configure your development environment to run, build, and deploy Flutter apps for macOS devices.
metadata:
  url: https://docs.flutter.dev/platform-integration/macos/setup#set-up-tooling
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up macOS development

Learn how to set up your development environment
to run, build, and deploy Flutter apps for the macOS desktop platform.


infoNote

If you haven't set up Flutter already,
visit and follow the [Get started with Flutter](/get-started) guide first.


If you've already installed Flutter,
ensure that it's [up to date](/install/upgrade).


## Set up tooling

[#](#set-up-tooling)

With Xcode, you can run Flutter apps on macOS as well as
compile and debug native Swift and Objective-C code.


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

      Once you've accepted all the necessary licenses successfully,
       the command should output how to review the licenses.
4. ### Install CocoaPods


   To support [Flutter plugins](/packages-and-plugins/developing-packages#types) that use native macOS code,
    install the latest version of [CocoaPods](https://cocoapods.org/).

   Install CocoaPods following the
    [CocoaPods installation guide](https://guides.cocoapods.org/using/getting-started.html#installation).

   If you've already installed CocoaPods,
    update it following the [CocoaPods update guide](https://guides.cocoapods.org/using/getting-started.html#updating-cocoapods).


## Validate your setup

[#](#validate-setup)

1. ### Check for toolchain issues


   To check for any issues with your macOS development setup,
    run the `flutter doctor` command in your preferred terminal:





   ```
   $ flutter doctor -v

   ```

   content\_copy



   If you see any errors or tasks to complete
    under the **Xcode** section,
    complete and resolve them, then
    run `flutter doctor -v` again to verify any changes.

2. ### Check for macOS devices


   To ensure Flutter can find and connect to your macOS device correctly,
    run `flutter devices` in your preferred terminal:





   ```
   $ flutter devices

   ```

   content\_copy



   If you set everything up correctly,
    there should be at least one entry with the platform marked as **macos**.

3. ### Troubleshoot setup issues


   If you need help resolving any setup issues,
    check out [Install and setup troubleshooting](/install/troubleshoot).

   If you still have issues or questions,
    reach out on one of the Flutter [community](https://flutter.dev/community)
    channels.


## Start developing for macOS

[#](#start-developing)

Congratulations!
Now that you've set up macOS desktop development for Flutter,
you can continue your Flutter learning journey while testing on macOS
or begin expanding integration with macOS.


![Dash helping you explore Flutter learning resources.](/assets/images/decorative/pointing-the-way.png)

Continue learning Flutter

- [Write your first app](/get-started/codelab)
- [Learn the fundamentals](/learn/pathway)
- [Explore Flutter widgets](https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Check out samples](/reference/learning-resources)

![An outline of Flutter desktop support.](/assets/images/decorative/flutter-on-desktop.svg)

Build for macOS

- [Build and deploy to macOS](/deployment/macos)
- [Bind to native macOS code](/platform-integration/macos/c-interop)
- [Embed native macOS views](/platform-integration/macos/platform-views)
- [Set up app flavors](/deployment/flavors-ios)
- [Use Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-16. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/macos/setup.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/macos/setup&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/macos/setup.md "Report an issue with this page").