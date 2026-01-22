---
name: debug-your-add-to-app-module
description: How to run, debug, and hot reload your add-to-app Flutter module.
metadata:
  url: https://docs.flutter.dev/add-to-app/debugging
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Debug your add-to-app module

Once you've integrated the Flutter module to your project and used
Flutter's platform APIs to run the Flutter engine and/or UI,
you can then build and run your Android or iOS app the same way
you run normal Android or iOS apps.


Flutter now powers the UI wherever your code includes
`FlutterActivity` or `FlutterViewController`.


## Overview

[#](#overview)

You might be used to having your suite of favorite Flutter debugging tools
available when running `flutter run` or an equivalent command from an IDE.
But you can also use all your Flutter [debugging functionalities](/testing/debugging)
such as
hot reload, performance overlays, DevTools, and setting breakpoints in
add-to-app scenarios.


The `flutter attach` command provides these functionalities.
To run this command, you can use the SDK's CLI tools, VS Code
or IntelliJ IDEA or Android Studio.


The `flutter attach` command connects once you run your `FlutterEngine`.
It remains attached until you dispose your `FlutterEngine`.
You can invoke `flutter attach` before starting your engine.
The `flutter attach` command waits for the next available Dart VM that
your engine hosts.


## Debug from the Terminal

[#](#debug-from-the-terminal)

To attach from the terminal, run `flutter attach`.
To select a specific target device, add `-d <deviceId>`.


```
$ flutter attach

```

content\_copy

The command should print output resembling the following:

```
Syncing files to device iPhone 15 Pro...
 7,738ms (!)

To hot reload the changes while running, press "r".
To hot restart (and rebuild state). press "R".

```

content\_copy

## Debug iOS extension in Xcode and VS Code

[#](#debug-ios-extension-in-xcode-and-vs-code)

#### Build the iOS version of the Flutter app in the Terminal

[#](#build-the-ios-version-of-the-flutter-app-in-the-terminal)

To generate the needed iOS platform dependencies,
run the `flutter build` command.


```
$ flutter build ios --config-only --no-codesign --debug

```

content\_copy

```
Warning: Building for device with codesigning disabled. You will have to manually codesign before deploying to device.
Building com.example.myApp for device (ios)...

```

content\_copy

- [Start from VS Code](#97-tab-panel)
- [Start from Xcode](#98-tab-panel)

#### Start debugging with VS Code first

[#](#vscode-ios)

If you use VS Code to debug most of your code, start with this section.

##### Start the Dart debugger in VS Code

[#](#start-the-dart-debugger-in-vs-code)

1. To open the Flutter app directory, go to
    **File** > **Open Folder...** and choose the `my_app` directory.

2. Open the `lib/main.dart` file.

3. If you can build an app for more than one device,
    you must select the device first.

Go to
    **View** > **Command Palette...**

You can also press `Ctrl` / `Cmd` +
    `Shift` \+ `P`.

4. Type `flutter select`.

5. Click the **Flutter: Select Device** command.

6. Choose your target device.

7. Click the debug icon
    (![VS Code's bug icon to trigger the debugging mode of a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/debug.png)).
    This opens the **Debug** pane and launches the app.
    Wait for the app to launch on the device and for the debug pane to
    indicate **Connected**.
    The debugger takes longer to launch the first time.
    Subsequent launches start faster.

This Flutter app contains two buttons:
   - **Launch in browser**: This button opens this page in the
      default browser of your device.
   - **Launch in app**: This button opens this page within your app.
      This button only works for iOS or Android. Desktop apps launch a browser.

##### Enable automatic attachment

[#](#enable-automatic-attachment)

You can configure VS Code to attach to your Flutter module project
whenever you start debugging.
To enable this feature,
create a `.vscode/launch.json` file in your Flutter module project.


1. Go to **View** > **Run**.

You can also press
    `Ctrl` / `Cmd` \+ `Shift` \+ `D`.

VS Code displays the **Run and Debug** sidebar.

2. In this sidebar, click **create a launch.json file**.

VS Code displays the **Select debugger** menu at the top.

3. Select **Dart & Flutter**.

VS Code creates then opens the `.vscode/launch.json` file.
Expand to see an example launch.json file



json

```
{
       // Use IntelliSense to learn about possible attributes.
       // Hover to view descriptions of existing attributes.
       // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
       "version": "0.2.0",
       "configurations": [
           {
               "name": "my_app",
               "request": "launch",
               "type": "dart"
           },
           {
               "name": "my_app (profile mode)",
               "request": "launch",
               "type": "dart",
               "flutterMode": "profile"
           },
           {
               "name": "my_app (release mode)",
               "request": "launch",
               "type": "dart",
               "flutterMode": "release"
           }
       ]
}

```

content\_copy

4. To attach, go to **Run** > **Start Debugging**.

You can also press `F5`.


##### Attach to the Flutter process in Xcode

[#](#attach-to-the-flutter-process-in-xcode)

To attach to the Flutter app in Xcode:

1. Go to **Debug** > **Attach to Process**.

2. Select **Runner**. It should be at the top of the
    **Attach to Process** menu under the **Likely Targets**
    heading.


#### Start debugging with Xcode first

[#](#xcode-ios)

If you use Xcode to debug most of your code, start with this section.

##### Start the Xcode debugger

[#](#start-the-xcode-debugger)

1. Open `ios/Runner.xcworkspace` from your Flutter app directory.

2. Select the correct device using the **Scheme** menu in the toolbar.

    If you have no preference, choose **iPhone Pro 14**.

3. Run this Runner as a normal app in Xcode.

    When the run completes, the **Debug** area at the bottom of Xcode displays
    a message with the Dart VM service URI. It resembles the following response:





```
2023-07-12 14:55:39.966191-0500 Runner[58361:53017145]
       flutter: The Dart VM service is listening on
       http://127.0.0.1:50642/00wEOvfyff8=/

```

content\_copy

4. Copy the Dart VM service URI.


##### Attach to the Dart VM in VS Code

[#](#attach-to-the-dart-vm-in-vs-code)

1. To open the command palette, go to
    **View** > **Command Palette...**

    You can also press `Cmd` \+ `Shift` \+ `P`.

2. Type `debug`.

3. Click the **Debug: Attach to Flutter on Device** command.

4. In the **Paste an VM Service URI** box, paste the URI you copied
    from Xcode and press `Enter`.


## Debug Android extension in Android Studio

[#](#debug-android-extension-in-android-studio)

1. To open the Flutter app directory, go to
    **File** > **Open...** and choose the `my_app` directory.

2. Open the `lib/main.dart` file.

3. Choose a virtual Android device.
    Go to the toolbar, open the leftmost dropdown menu, and click on
    **Open Android Emulator: <device>**.

   You can choose any installed emulator that's doesn't include `arm64`.

4. From that same menu, select the virtual Android device.

5. From the toolbar, click **Run 'main.dart'**.

   You can also press `Ctrl` \+ `Shift` \+ `R`.

   After the app displays in the emulator, continue to the next step.


## Debug without USB connection

[#](#wireless-debugging)

To debug your app over Wi-Fi on an iOS or Android device,
use `flutter attach`.


### Debug over Wi-Fi on iOS devices

[#](#debug-over-wi-fi-on-ios-devices)

For an iOS target, complete the follow steps:

1. Verify your device connects to Xcode over Wi-Fi
    as described in the [iOS setup guide](/platform-integration/ios/setup).

2. On your macOS development machine,
    open **Xcode** > **Product** > **Scheme** > **Edit Scheme...**.

   You can also press `Cmd` \+ `<`.

3. Click **Run**.

4. Click **Arguments**.

5. In **Arguments Passed On Launch**, Click **+**.


   1. If your dev machine uses IPv4, add `--vm-service-host=0.0.0.0`.

   2. If your dev machine uses IPv6, add `--vm-service-host=::0`.


<DashImage figure img-class="site-mobile-screenshot border" image="development/add-to-app/debugging/wireless-port.png" caption="Arguments Passed On Launch with an IPv4 network added", width="100%" />

#### To determine if you're on an IPv6 network

[#](#to-determine-if-youre-on-an-ipv6-network)

1. Open **Settings** > **Wi-Fi**.

2. Click on your connected network.

3. Click **Details...**

4. Click **TCP/IP**.

5. Check for an **IPv6 address** section.


   ![WiFi dialog box for macOS System Settings](/assets/images/docs/development/add-to-app/ipv6.png)

   WiFi dialog box for macOS System Settings


### Debug over Wi-Fi on Android devices

[#](#debug-over-wi-fi-on-android-devices)

Verify your device connects to Android Studio over Wi-Fi
as described in the [Android setup guide](/platform-integration/android/setup#set-up-devices).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/add-to-app/debugging.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/add-to-app/debugging&page-source=https://github.com/flutter/website/blob/main/src/content/add-to-app/debugging.md "Report an issue with this page").