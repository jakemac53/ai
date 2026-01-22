---
name: build-and-release-an-ios-app
description: How to release a Flutter app to the App Store.
metadata:
  url: https://docs.flutter.dev/deployment/ios#update-the-apps-build-and-version-numbers
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Build and release an iOS app

This guide provides a step-by-step walkthrough of releasing a
Flutter app to the [App Store](https://developer.apple.com/app-store/submissions/)
and [TestFlight](https://developer.apple.com/testflight/).


## Preliminaries

[#](#preliminaries)

Xcode is required to build and release your app. You
must use a device running macOS to follow this guide.


Before beginning the process of releasing your app,
ensure that it meets Apple's [App Review Guidelines](https://developer.apple.com/app-store/review/).


To publish your app to the App Store,
you must first enroll in the [Apple Developer Program](https://developer.apple.com/programs/).
You can read more about the various membership options in Apple's
[Choosing a Membership](https://developer.apple.com/support/compare-memberships/)
guide.


## Video overview

[#](#video-overview)

For those who prefer video over text,
the following video covers the same material as this guide.


[Watch on YouTube in a new tab: "Release an iOS app built with Flutter in 7 steps"](https://www.youtube.com/watch/iE2bpP56QKc)

## Register your app on App Store Connect

[#](#register-your-app-on-app-store-connect)

Manage your app's life cycle on
[App Store Connect](https://developer.apple.com/support/app-store-connect/)
(formerly iTunes Connect).
You define your app name and description, add screenshots,
set pricing, and manage releases to the App Store and TestFlight.


Registering your app involves two steps: registering a unique
Bundle ID, and creating an application record on App Store Connect.


For a detailed overview of App Store Connect, see the
[App Store Connect](https://developer.apple.com/support/app-store-connect/)
guide.


### Register a Bundle ID

[#](#register-a-bundle-id)

Every iOS application is associated with a Bundle ID,
a unique identifier registered with Apple.
To register a Bundle ID for your app, follow these steps:


1. Open the [App IDs](https://developer.apple.com/account/ios/identifier/bundle) page of your developer account.

2. Click **+** to create a new Bundle ID.
3. Enter an app name, select **Explicit App ID**, and enter an ID.
4. Select the services your app uses, then click **Continue**.
5. On the next page, confirm the details and click **Register**
    to register your Bundle ID.


### Create an application record on App Store Connect

[#](#create-an-application-record-on-app-store-connect)

Register your app on App Store Connect:

1. Open [App Store Connect](https://appstoreconnect.apple.com/) in your browser.
2. On the App Store Connect landing page, click **Apps**.
3. Click **+** in the top-left corner,
    then select **New App**.

4. Fill in your app details in the form that appears.
    In the Platforms section, ensure that iOS is checked.
    Since Flutter does not currently support tvOS,
    leave that checkbox unchecked. Click **Create**.

5. Navigate to the application details for your app and select
    **App Information** from the sidebar.

6. In the General Information section, select the Bundle ID
    you registered in the preceding step.


For a detailed overview, see
[Add an app to your account](https://help.apple.com/app-store-connect/#/dev2cd126805).


## Review Xcode project settings

[#](#review-xcode-project-settings)

This step covers reviewing the most important settings
in the Xcode workspace.
For detailed procedures and descriptions, see
[Prepare for app distribution](https://help.apple.com/xcode/mac/current/#/dev91fe7130a).


Navigate to your target's settings in Xcode:

1. Open the default Xcode workspace in your project by running
    `open ios/Runner.xcworkspace` in a terminal window from your
    Flutter project directory.

2. To view your app's settings, select the **Runner** target in the
    Xcode navigator.


Verify the most important settings.

In the **Identity** section of the **General** tab:

`Display Name`

The display name of your app.

`Bundle Identifier`

The App ID you registered on App Store Connect.

In the **Signing & Capabilities** tab:

`Automatically manage signing`

Whether Xcode should automatically manage app signing
and provisioning. This is set `true` by default, which should
be sufficient for most apps. For more complex scenarios,
see the [Code Signing Guide](https://developer.apple.com/library/content/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html).


`Team`

Select the team associated with your registered Apple Developer
account. If required, select **Add Account...**,
then update this setting.


In the **Deployment** section of the **Build Settings** tab:

`iOS Deployment Target`

The minimum iOS version that your app supports.
Flutter supports iOS 13 and later. If your app or plugins
include Objective-C or Swift code that makes use of APIs newer
than iOS 12, update this setting to the highest required version.


The **General** tab of your project settings should resemble
the following:


![Xcode Project Settings](/assets/images/docs/releaseguide/xcode_settings.png)

For a detailed overview of app signing, see
[Create, export, and delete signing certificates](https://help.apple.com/xcode/mac/current/#/dev154b28f09).


## Add an app icon

[#](#add-an-app-icon)

When a new Flutter app is created, a placeholder icon set is created.
This step covers replacing these placeholder icons with your
app's icons:


1. Review the [iOS App Icon](https://developer.apple.com/design/human-interface-guidelines/app-icons/)
    guidelines and,
    in particular, the advice on
    [creating light, dark, and tinted](https://developer.apple.com/design/human-interface-guidelines/app-icons#iOS-iPadOS)
    icons for your app.

2. In the Xcode project navigator, select `Assets.xcassets` in the
    `Runner` folder. Update the placeholder icons with your own app icons.

3. Verify the icon has been replaced by running your app using
    `flutter run`.


## Add a launch image

[#](#add-a-launch-image)

Similar to the app icon,
you can also replace the placeholder launch image:


1. In the Xcode project navigator,
    select `Assets.xcassets` in the `Runner` folder.
    Update the placeholder launch image with your own launch image.

2. Verify the new launch image by hot restarting your app.
    (Don't use `hot reload`.)


## Create a build archive and upload to App Store Connect

[#](#create-a-build-archive-and-upload-to-app-store-connect)

During development, you've been building, debugging, and testing
with _debug_ builds. When you're ready to ship your app to users
on the App Store or TestFlight, you need to prepare a _release_ build.


### Update the app's build and version numbers

[#](#update-the-apps-build-and-version-numbers)

The default version number of the app is `1.0.0`.
To update it, navigate to the `pubspec.yaml` file
and update the following line:


yaml

```
version: 1.0.0+1

```

content\_copy

The version number is three numbers separated by dots,
such as `1.0.0` in the example above, followed by an optional
build number such as `1` in the example above, separated by a `+`.


Both the version and the build number can be overridden in
`flutter build ipa` by specifying `--build-name` and `--build-number`,
respectively.


In iOS, `build-name` uses `CFBundleShortVersionString`
while `build-number` uses `CFBundleVersion`.
Read more about iOS versioning at [Core Foundation Keys](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html)

on the Apple Developer's site.


You can also override the `pubspec.yaml` build name and number in Xcode:

1. Open `Runner.xcworkspace` in your app's `ios` folder.
2. Select **Runner** in the Xcode project navigator, then select the
    **Runner** target in the settings view sidebar.

3. In the Identity section, update the **Version** to the user-facing
    version number you wish to publish.

4. In the Identity section, update the **Build** identifier to a unique
    build number used to track this build on App Store Connect.
    Each upload requires a unique build number.


### Create an app bundle

[#](#create-an-app-bundle)

Run `flutter build ipa` to produce an Xcode build archive ( `.xcarchive` file)
in your project's `build/ios/archive/` directory and an App Store app
bundle ( `.ipa` file) in `build/ios/ipa`.


Consider adding the `--obfuscate` and `--split-debug-info` flags to
[obfuscate your Dart code](/deployment/obfuscate) to make it more difficult
to reverse engineer.


If you are not distributing to the App Store, you can optionally
choose a different [export method](https://help.apple.com/xcode/mac/current/#/dev31de635e5)
by
adding the option `--export-method ad-hoc`,
`--export-method development` or `--export-method enterprise`.


infoNote

On versions of Flutter where `flutter build ipa --export-method` is unavailable,
open `build/ios/archive/MyApp.xcarchive` and follow the instructions below
to validate and distribute the app from Xcode.


### Upload the app bundle to App Store Connect

[#](#upload-the-app-bundle-to-app-store-connect)

Once the app bundle is created, upload it to
[App Store Connect](https://appstoreconnect.apple.com/) by either:


1. Install and open the [Apple Transport macOS app](https://apps.apple.com/us/app/transporter/id1450874784).
   Drag and drop the `build/ios/ipa/*.ipa` app bundle into the app.

2. Or upload the app bundle from the command line by running:



   bash

   ```
   xcrun altool --upload-app --type ios -f build/ios/ipa/*.ipa --apiKey your_api_key --apiIssuer your_issuer_id

   ```

   content\_copy



   Run `man altool` for details about how to authenticate with the App Store Connect API key.

3. Or open `build/ios/archive/MyApp.xcarchive` in Xcode.

   Click the **Validate App** button. If any issues are reported,
   address them and produce another build. You can reuse the same
   build ID until you upload an archive.

   After the archive has been successfully validated, click
   **Distribute App**.


   infoNote





   When you export your app at the end of **Distribute App**,
   Xcode will create a directory containing
   an IPA of your app and an `ExportOptions.plist` file.
   You can create new IPAs with the same options without launching
   Xcode by running
   `flutter build ipa --export-options-plist=path/to/ExportOptions.plist`.
   See `xcodebuild -h` for details about the keys in this property list.


You can follow the status of your build in the
Activities tab of your app's details page on
[App Store Connect](https://appstoreconnect.apple.com/).
You should receive an email within 30 minutes notifying you that
your build has been validated and is available to release to testers
on TestFlight. At this point you can choose whether to release
on TestFlight, or go ahead and release your app to the App Store.


For more details, see
[Upload an app to App Store Connect](https://help.apple.com/xcode/mac/current/#/dev442d7f2ca).


## Create a build archive with Codemagic CLI tools

[#](#create-a-build-archive-with-codemagic-cli-tools)

This step covers creating a build archive and uploading
your build to App Store Connect using Flutter build commands
and [Codemagic CLI Tools](https://github.com/codemagic-ci-cd/cli-tools)
executed in a terminal
in the Flutter project directory. This allows you to create a build archive
with full control of distribution certificates in a temporary keychain
isolated from your login keychain.


01. Install the Codemagic CLI tools:



    bash

    ```
    pip3 install codemagic-cli-tools

    ```

    content\_copy

02. You'll need to generate an [App Store Connect API Key](https://appstoreconnect.apple.com/access/api)
    with App Manager access to automate operations with App Store Connect. To make
    subsequent commands more concise, set the following environment variables from
    the new key: issuer id, key id, and API key file.



    bash

    ```
    export APP_STORE_CONNECT_ISSUER_ID=aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
    export APP_STORE_CONNECT_KEY_IDENTIFIER=ABC1234567
    export APP_STORE_CONNECT_PRIVATE_KEY=`cat /path/to/api/key/AuthKey_XXXYYYZZZ.p8`

    ```

    content\_copy

03. You need to export or create an iOS Distribution certificate to code sign and package a build archive.

    If you have existing [certificates](https://developer.apple.com/account/resources/certificates), you can export the
    private keys by executing the following command for each certificate:



    bash

    ```
    openssl pkcs12 -in <certificate_name>.p12 -nodes -nocerts | openssl rsa -out cert_key

    ```

    content\_copy



    Or you can create a new private key by executing the following command:



    bash

    ```
    ssh-keygen -t rsa -b 2048 -m PEM -f cert_key -q -N ""

    ```

    content\_copy



    Later, you can have CLI tools automatically create a new iOS Distribution from the private key.

04. Set up a new temporary keychain to be used for code signing:



    bash

    ```
    keychain initialize

    ```

    content\_copy




    infoRestore Login Keychain!





    After running `keychain initialize` you **must** run the following:





    `keychain use-login`



    This sets your login keychain as the default to avoid potential
    authentication issues with apps on your machine.

05. Fetch the code signing files from App Store Connect:



    bash

    ```
    app-store-connect fetch-signing-files $(xcode-project detect-bundle-id) \
        --platform IOS \
        --type IOS_APP_STORE \
        --certificate-key=@file:/path/to/cert_key \
        --create

    ```

    content\_copy



    Where `cert_key` is either your exported iOS Distribution certificate private key
    or a new private key which automatically generates a new certificate. The certificate
    will be created from the private key if it doesn't exist in App Store Connect.

06. Now add the fetched certificates to your keychain:



    bash

    ```
    keychain add-certificates

    ```

    content\_copy

07. Update the Xcode project settings to use fetched code signing profiles:



    bash

    ```
    xcode-project use-profiles

    ```

    content\_copy

08. Install Flutter dependencies:



    bash

    ```
    flutter packages pub get

    ```

    content\_copy

09. Install CocoaPods dependencies:



    bash

    ```
    find . -name "Podfile" -execdir pod install \;

    ```

    content\_copy

10. Build the Flutter the iOS project:



    bash

    ```
    flutter build ipa --release \
        --export-options-plist=$HOME/export_options.plist

    ```

    content\_copy



    Note that `export_options.plist` is the output of the `xcode-project use-profiles` command.

11. Publish the app to App Store Connect:



    bash

    ```
    app-store-connect publish \
        --path $(find $(pwd) -name "*.ipa")

    ```

    content\_copy

12. As mentioned earlier, don't forget to set your login keychain
    as the default to avoid authentication issues
    with apps on your machine:



    bash

    ```
    keychain use-login

    ```

    content\_copy


You should receive an email within 30 minutes notifying you that
your build has been validated and is available to release to testers
on TestFlight. At this point you can choose whether to release
on TestFlight, or go ahead and release your app to the App Store.


## Release your app on TestFlight

[#](#release-your-app-on-testflight)

[TestFlight](https://developer.apple.com/testflight/) allows developers to push their apps
to internal and external testers. This optional step
covers releasing your build on TestFlight.


1. Navigate to the TestFlight tab of your app's application
    details page on [App Store Connect](https://appstoreconnect.apple.com/).

2. Select **Internal Testing** in the sidebar.
3. Select the build to publish to testers, then click **Save**.
4. Add the email addresses of any internal testers.
    You can add additional internal users in the **Users and Roles**
    page of App Store Connect,
    available from the dropdown menu at the top of the page.


For more details, see
[Distribute an app using TestFlight](https://help.apple.com/xcode/mac/current/#/dev2539d985f).


## Release your app to the App Store

[#](#release-your-app-to-the-app-store)

When you're ready to release your app to the world,
follow these steps to submit your app for review and
release to the App Store:


1. Select **Pricing and Availability** from the sidebar of your app's
    application details page on
    [App Store Connect](https://appstoreconnect.apple.com/) and complete the
    required information.

2. Select the status from the sidebar. If this is the first
    release of this app, its status is
    **1.0 Prepare for Submission**. Complete all required fields.

3. Click **Submit for Review**.

Apple notifies you when their app review process is complete.
Your app is released according to the instructions you
specified in the **Version Release** section.


For more details, see
[Distribute an app through the App Store](https://help.apple.com/xcode/mac/current/#/dev067853c94).


## Troubleshooting

[#](#troubleshooting)

The [Distribute your app](https://help.apple.com/xcode/mac/current/#/devac02c5ab8) guide provides a
detailed overview of the process of releasing an app to the App Store.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-15. [View source](https://github.com/flutter/website/blob/main/src/content/deployment/ios.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/deployment/ios&page-source=https://github.com/flutter/website/blob/main/src/content/deployment/ios.md "Report an issue with this page").