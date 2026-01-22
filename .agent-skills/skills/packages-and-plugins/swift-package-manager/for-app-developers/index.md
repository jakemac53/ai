---
name: swift-package-manager-for-app-developers
description: How to use Swift Package Manager for native iOS or macOS dependencies
metadata:
  url: https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Swift Package Manager for app developers

warningWarning

Flutter is migrating to [Swift Package Manager](https://www.swift.org/documentation/package-manager/)
to manage iOS and macOS native
dependencies.
Flutter's support of Swift Package Manager is under development.
If you find a bug in Flutter's Swift Package Manager support,
[open an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml).
Swift Package Manager support is [off by default](#how-to-turn-on-swift-package-manager).
Flutter continues to support CocoaPods.


Flutter's Swift Package Manager integration has several benefits:

1. **Provides access to the Swift package ecosystem**.
    Flutter plugins can use the growing ecosystem of [Swift packages](https://swiftpackageindex.com/).

2. **Simplifies Flutter installation**.
    Xcode includes Swift Package Manager.
    You don't need to install Ruby and CocoaPods if your project uses
    Swift Package Manager.


## How to turn on Swift Package Manager

[#](#how-to-turn-on-swift-package-manager)

Flutter's Swift Package Manager support is turned off by default.
To turn it on:


1. Upgrade to the latest Flutter SDK:



   sh

   ```
   flutter upgrade

   ```

   content\_copy

2. Turn on the Swift Package Manager feature:



   sh

   ```
   flutter config --enable-swift-package-manager

   ```

   content\_copy


Using the Flutter CLI to run an app [migrates the project](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-add-swift-package-manager-integration)
to add
Swift Package Manager integration.
This makes your project download the Swift packages that
your Flutter plugins depend on.
An app with Swift Package Manager integration requires Flutter version 3.24 or
higher.
To use an older Flutter version,
you will need to [remove Swift Package Manager integration](/packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration)

from the app.


Flutter falls back to CocoaPods for dependencies that do not support Swift
Package Manager yet.


## How to turn off Swift Package Manager

[#](#how-to-turn-off-swift-package-manager)

Plugin authors

Plugin authors need to turn on and off Flutter's Swift Package Manager
support for testing.
App developers do not need to disable Swift Package Manager support,
unless they are running into issues.


If you find a bug in Flutter's Swift Package Manager support,
[open an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml).


Disabling Swift Package Manager causes Flutter to use CocoaPods for all
dependencies.
However, Swift Package Manager remains integrated with your project.
To remove Swift Package Manager integration completely from your project,
follow the [How to remove Swift Package Manager integration](/packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration)

instructions.


### Turn off for a single project

[#](#turn-off-for-a-single-project)

In the project's `pubspec.yaml` file, under the `flutter` section,
set `enable-swift-package-manager` to `false` in the `config`
subsection.


pubspec.yaml

yaml

```
# The following section is specific to Flutter packages.
flutter:
  config:
    enable-swift-package-manager: false

```

content\_copy

This turns off Swift Package Manager for all contributors to this project.

infoMigrating from deprecated syntax

If you were previously using `disable-swift-package-manager: true`,
update your `pubspec.yaml` to use the new `config` section format shown above.
The old syntax is deprecated and will produce an error in Flutter 3.38 and later.


### Turn off globally for all projects

[#](#turn-off-globally-for-all-projects)

Run the following command:

sh

```
flutter config --no-enable-swift-package-manager

```

content\_copy

This turns off Swift Package Manager for the current user.

If a project is incompatible with Swift Package Manager, all contributors
need to run this command.


## How to add Swift Package Manager integration

[#](#how-to-add-swift-package-manager-integration)

### Add to a Flutter app

[#](#add-to-a-flutter-app)

- [iOS project](#10-tab-panel)
- [macOS project](#11-tab-panel)

Once you [turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager), the Flutter CLI tries to migrate
your project the next time you run your app using the CLI.
This migration updates your Xcode project to use Swift Package Manager to
add Flutter plugin dependencies.


To migrate your project:

1. [Turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager).

2. Run the iOS app using the Flutter CLI.

If your iOS project doesn't have Swift Package Manager integration yet, the
    Flutter CLI tries to migrate your project and outputs something like:





```
$ flutter run
Adding Swift Package Manager integration...

```

content\_copy



The automatic iOS migration modifies the
    `ios/Runner.xcodeproj/project.pbxproj` and
    `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
    files.

3. If the Flutter CLI's automatic migration fails, follow the steps in
    [add Swift Package Manager integration manually](/packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually).


\[Optional\] To check if your project is migrated:

1. Run the app in Xcode.

2. Ensure that **Run Prepare Flutter Framework Script** runs as a pre-action
    and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.
![Ensure **Run Prepare Flutter Framework Script** runs as a pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png)

Ensure **Run Prepare Flutter Framework Script** runs as a pre-action


Once you [turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager), the Flutter CLI tries to migrate
your project the next time you run your app using the CLI.
This migration updates your Xcode project to use Swift Package Manager to
add Flutter plugin dependencies.


To migrate your project:

1. [Turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager).

2. Run the macOS app using the Flutter CLI.

If your macOS project doesn't have Swift Package Manager integration yet, the
    Flutter CLI tries to migrate your project and outputs something like:





```
$ flutter run -d macos
Adding Swift Package Manager integration...

```

content\_copy



The automatic iOS migration modifies the
    `macos/Runner.xcodeproj/project.pbxproj` and
    `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
    files.

3. If the Flutter CLI's automatic migration fails, follow the steps in
    [add Swift Package Manager integration manually](/packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually).


\[Optional\] To check if your project is migrated:

1. Run the app in Xcode.

2. Ensure that **Run Prepare Flutter Framework Script** runs as a pre-action
    and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.
![Ensure **Run Prepare Flutter Framework Script** runs as a pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png)

Ensure **Run Prepare Flutter Framework Script** runs as a pre-action


### Add to a Flutter app _manually_

[#](#add-to-a-flutter-app-manually)

- [iOS project](#12-tab-panel)
- [macOS project](#13-tab-panel)

Once you [turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager), the Flutter CLI tries to migrate
your project to use Swift Package Manager the next time you run your app
using the CLI.


However, the Flutter CLI tool might be unable to migrate your project
automatically if there are unexpected modifications.


If the automatic migration fails, use the steps below to add Swift Package
Manager integration to a project manually.


Before migrating manually, [file an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml); this helps the Flutter team
improve the automatic migration process.
Include the error message and, if possible, include a copy of
the following files in your issue:


- `ios/Runner.xcodeproj/project.pbxproj`
- `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
(or the xcsheme for the flavor used)


### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency

[#](#step-1-add-fluttergeneratedpluginswiftpackage-package-dependency)

1. Open your app ( `ios/Runner.xcworkspace`) in Xcode.

2. Navigate to **Package Dependencies** for the project.
![The project's package dependencies](/assets/images/docs/development/packages-and-plugins/swift-package-manager/package-dependencies.png)

The project's package dependencies

3. Click the add button.

4. In the dialog that opens, click **Add Local...**.

5. Navigate to `ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
    and click **Add Package**.

6. Ensure that it's added to the `Runner` target and click **Add Package**.
![Ensure that the package is added to the `Runner` target](/assets/images/docs/development/packages-and-plugins/swift-package-manager/choose-package-products.png)

Ensure that the package is added to the `Runner` target

7. Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks,**
**Libraries, and Embedded Content**.
![Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**](/assets/images/docs/development/packages-and-plugins/swift-package-manager/add-generated-framework.png)

Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**


### Step 2: Add Run Prepare Flutter Framework Script Pre-Action

[#](#step-2-add-run-prepare-flutter-framework-script-pre-action)

**The following steps must be completed for each flavor.**

1. Go to **Product > Scheme > Edit Scheme**.

2. Expand the **Build** section in the left side bar.

3. Click **Pre-actions**.

4. Click the add button and
    select **New Run Script Action** from the menu.

5. Click the **Run Script** title and change it to:





```
Run Prepare Flutter Framework Script

```

content\_copy

6. Change the **Provide build settings from** to the `Runner` app.

7. Input the following in the text box:



sh

```
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" prepare

```

content\_copy


![Add **Run Prepare Flutter Framework Script** build pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/add-flutter-pre-action.png)

Add **Run Prepare Flutter Framework Script** build pre-action


### Step 3: Run app

[#](#step-3-run-app)

1. Run the app in Xcode.

2. Ensure that **Run Prepare Flutter Framework Script** runs as a pre-action
    and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.
![Ensure **Run Prepare Flutter Framework Script** runs as a pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png)

Ensure **Run Prepare Flutter Framework Script** runs as a pre-action

3. Ensure that the app runs on the command line with `flutter run`.


Once you [turn on Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager), the Flutter CLI tries to migrate
your project to use Swift Package Manager the next time you run your app
using the CLI.


However, the Flutter CLI tool might be unable to migrate your project
automatically if there are unexpected modifications.


If the automatic migration fails, use the steps below to add Swift Package
Manager integration to a project manually.


Before migrating manually, [file an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml); this helps the Flutter team
improve the automatic migration process.
Include the error message and, if possible, include a copy of
the following files in your issue:


- `macos/Runner.xcodeproj/project.pbxproj`
- `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
(or the xcscheme for the flavor used)


### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency

[#](#step-1-add-fluttergeneratedpluginswiftpackage-package-dependency-1)

1. Open your app ( `macos/Runner.xcworkspace`) in Xcode.

2. Navigate to **Package Dependencies** for the project.
![The project's package dependencies](/assets/images/docs/development/packages-and-plugins/swift-package-manager/package-dependencies.png)

The project's package dependencies

3. Click the add button.

4. In the dialog that opens, click the **Add Local...**.

5. Navigate to `macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
    and click the **Add Package**.

6. Ensure that it's added to the Runner Target and click **Add Package**.
![Ensure that the package is added to the `Runner` target](/assets/images/docs/development/packages-and-plugins/swift-package-manager/choose-package-products.png)

Ensure that the package is added to the `Runner` target

7. Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks,**
**Libraries, and Embedded Content**.
![Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**](/assets/images/docs/development/packages-and-plugins/swift-package-manager/add-generated-framework.png)

Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**


### Step 2: Add Run Prepare Flutter Framework Script Pre-Action

[#](#step-2-add-run-prepare-flutter-framework-script-pre-action-1)

**The following steps must be completed for each flavor.**

1. Go to **Product > Scheme > Edit Scheme**.

2. Expand the **Build** section in the left side bar.

3. Click **Pre-actions**.

4. Click the add button
    and select **New Run Script Action** from the menu.

5. Click the **Run Script** title and change it to:





```
Run Prepare Flutter Framework Script

```

content\_copy

6. Change the **Provide build settings from** to the `Runner` target.

7. Input the following in the text box:



sh

```
"$FLUTTER_ROOT"/packages/flutter_tools/bin/macos_assemble.sh prepare

```

content\_copy


![Add **Run Prepare Flutter Framework Script** build pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/add-flutter-pre-action.png)

Add **Run Prepare Flutter Framework Script** build pre-action


### Step 3: Run app

[#](#step-3-run-app-1)

1. Run the app in Xcode.

2. Ensure that **Run Prepare Flutter Framework Script** runs as a pre-action
    and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.
![Ensure `Run Prepare Flutter Framework Script` runs as a pre-action](/assets/images/docs/development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png)

Ensure `Run Prepare Flutter Framework Script` runs as a pre-action

3. Ensure that the app runs on the command line with `flutter run`.


### Add to an existing app (add-to-app)

[#](#add-to-an-existing-app-add-to-app)

Flutter's Swift Package Manager support doesn't work with add-to-app scenarios.

To keep current on status updates, consult [flutter#146957](https://github.com/flutter/flutter/issues/146957).


### Add to a custom Xcode target

[#](#add-to-a-custom-xcode-target)

Your Flutter Xcode project can have custom [Xcode targets](https://developer.apple.com/documentation/xcode/configuring-a-new-target-in-your-project)
to build additional
products, like frameworks or unit tests.
You can add Swift Package Manager integration to these custom Xcode targets.


Follow the steps in
[How to add Swift Package Manager integration to a project _manually_](/packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually).


In [Step 1](/packages-and-plugins/swift-package-manager/for-app-developers/#step-1-add-fluttergeneratedpluginswiftpackage-package-dependency), list item 6 use your custom target instead
of the `Flutter` target.


In [Step 2](/packages-and-plugins/swift-package-manager/for-app-developers/#step-2-add-run-prepare-flutter-framework-script-pre-action), list item 6 use your custom target instead
of the `Flutter` target.


## How to remove Swift Package Manager integration

[#](#how-to-remove-swift-package-manager-integration)

To add Swift Package Manager integration, the Flutter CLI migrates your project.
This migration updates your Xcode project to add Flutter plugin dependencies.


To undo this migration:

01. [Turn off Swift Package Manager](/packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-off-swift-package-manager).

02. Clean your project:



    sh

    ```
    flutter clean

    ```

    content\_copy

03. Open your app ( `ios/Runner.xcworkspace` or `macos/Runner.xcworkspace`) in
     Xcode.

04. Navigate to **Package Dependencies** for the project.

05. Click the `FlutterGeneratedPluginSwiftPackage` package, then click
     the remove
     button.
    ![The `FlutterGeneratedPluginSwiftPackage` to remove](/assets/images/docs/development/packages-and-plugins/swift-package-manager/remove-generated-package.png)

    The `FlutterGeneratedPluginSwiftPackage` to remove

06. Navigate to **Frameworks, Libraries, and Embedded Content** for the `Runner`
     target.

07. Click `FlutterGeneratedPluginSwiftPackage`, then click
     the remove
     button.
    ![The `FlutterGeneratedPluginSwiftPackage` to remove](/assets/images/docs/development/packages-and-plugins/swift-package-manager/remove-generated-framework.png)

    The `FlutterGeneratedPluginSwiftPackage` to remove

08. Go to **Product > Scheme > Edit Scheme**.

09. Expand the **Build** section in the left side bar.

10. Click **Pre-actions**.

11. Expand **Run Prepare Flutter Framework Script**.

12. Click the delete button.
    ![The build pre-action to remove](/assets/images/docs/development/packages-and-plugins/swift-package-manager/remove-flutter-pre-action.png)

    The build pre-action to remove


## How to use a Swift Package Manager Flutter plugin that requires a higher OS version

[#](#how-to-use-a-swift-package-manager-flutter-plugin-that-requires-a-higher-os-version)

If a Swift Package Flutter Manager plugin requires a higher OS version than
the project, you might get an error like this:


```
Target Integrity (Xcode): The package product 'plugin_name_ios' requires minimum platform version 14.0 for the iOS platform, but this target supports 12.0

```

content\_copy

To use the plugin:

1. Open your app ( `ios/Runner.xcworkspace` or `macos/Runner.xcworkspace`) in
    Xcode.

2. Increase your app's target **Minimum Deployments**.
   ![The target's **Minimum Deployments** setting](/assets/images/docs/development/packages-and-plugins/swift-package-manager/minimum-deployments.png)

   The target's **Minimum Deployments** setting

3. If you updated your iOS app's **Minimum Deployments**,
    regenerate the iOS project's configuration files:



   sh

   ```
   flutter build ios --config-only

   ```

   content\_copy

4. If you updated your macOS app's **Minimum Deployments**,
    regenerate the macOS project's configuration files:



   sh

   ```
   flutter build macos --config-only

   ```

   content\_copy


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-8. [View source](https://github.com/flutter/website/blob/main/src/content/packages-and-plugins/swift-package-manager/for-app-developers.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers&page-source=https://github.com/flutter/website/blob/main/src/content/packages-and-plugins/swift-package-manager/for-app-developers.md "Report an issue with this page").