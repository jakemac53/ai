---
name: use-a-native-language-debugger
description: How to connect a native debugger to your running Flutter app.
metadata:
  url: https://docs.flutter.dev/testing/native-debugging
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Use a native language debugger

infoNote

This guide presumes you understand general debugging,
have installed Flutter and git, and have familiarity
with the Dart language as well as one of the following
languages: Java, Kotlin, Swift, or Objective-C.


If you write Flutter apps only with Dart code,
you can debug your code using your IDE's debugger.
The Flutter team recommends VS Code.


If you write a platform-specific plugin or
use platform-specific libraries, you can debug
that portion of your code with a native debugger.


- To debug iOS or macOS code written in Swift or Objective-C,
   you can use Xcode.

- To debug Android code written in Java or Kotlin,
   you can use Android Studio.

- To debug Windows code written in C++, you can use Visual Studio.

This guide shows you how you can connect _two_
debuggers to your Dart app, one for Dart, and one for the native code.


## Debug Dart code

[#](#debug-dart-code)

This guide describes how to use VS Code to debug your Flutter app.
You can also use your preferred IDE with the
Flutter and Dart plugins installed and configured.


## Debug Dart code using VS Code

[#](#debug-dart-code-using-vs-code)

The following procedure explains how to use the Dart debugger
with the default sample Flutter app.
The featured components in VS Code work and appear when
debugging your own Flutter project as well.


1. Create a basic Flutter app.





   ```
   $ flutter create my_app

   ```

   content\_copy







   ```
   Creating project my_app...
   Resolving dependencies in my_app...
   Got dependencies in my_app.
   Wrote 129 files.

   All done!
   You can find general documentation for Flutter at: https://docs.flutter.dev/
   Detailed API documentation is available at: https://api.flutter.dev/
   If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

   In order to run your application, type:

     $ cd my_app
     $ flutter run

   Your application code is in my_app/lib/main.dart.

   ```

   content\_copy







   ```
   $ cd my_app

   ```

   content\_copy

2. Open the `lib\main.dart` file in the Flutter app using
    VS Code.

3. Click the bug icon
    (![VS Code's bug icon to trigger the debugging mode of a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/debug.png)).
    This opens the following panes in VS Code:


   - **Debug**
   - **Debug Console**
   - **Widget Inspector**

The first time you run the debugger takes the longest.

4. Test the debugger.

   a. In `main.dart`, click on this line:



   dart

   ```
   _counter++;

   ```

   content\_copy



   b. Press `Shift` \+ `F9`.
    This adds a breakpoint where the
    `_counter` variable increments.

   c. In the app, click the **+** button
    to increment the counter. The app pauses.

    d. At this point, VS Code displays:
   - In the **Editor Groups**:
     - The highlighted breakpoint in `main.dart`
     - The widget hierarchy for the Flutter app
        in the **Widget Tree** of the **Widget Inspector**
   - In the **side bar**:
     - The state of the app in the **Call Stack** section
     - The value of the `this` local variable in the **Variables** section
   - In the **panel**:
     - The log of the Flutter app in the **Debug console**

### VS Code Flutter debugger

[#](#vs-code-flutter-debugger)

The Flutter plugin for VS Code adds a number of components
to the VS Code user interface.


#### Changes to VS Code interface

[#](#changes-to-vs-code-interface)

When launched, the Flutter debugger adds debugging tools to the
VS Code interface.


The following screenshot and table explain the purpose of each tool.

![VS Code with the Flutter plugin UI additions](/assets/images/docs/testing/debugging/vscode-ui/screens/debugger-parts.png)

Highlight Color in ScreenshotBar, Panel, or TabContents**Yellow**VariablesList of current values of variables in the Flutter appWatchList of items you chose to track in the Flutter appCall StackStack of active subroutines in the Flutter appBreakpointsList of exceptions and set breakpoints that you set**Green**`<Flutter files>`Files that you are editing**Pink**Widget InspectorHierarchy of widgets in the running Flutter app**Blue**Layout ExplorerVisual of how Flutter placed the widget you selected in the Widget InspectorWidget Details TreeList of properties of the widget selected in the Widget Inspector**Orange**ProblemsList of issues the Dart analyzer found in the current Dart fileOutputResponse that the Flutter app returns when building an appDebug ConsoleLogs or error messages that the Flutter app generates while debuggingTerminalSystem shell prompt contained in VS Code

To change where the panel (in **orange**) appears in VS Code,
go to **View** \> **Appearance** \> **Panel Position**.


#### VS Code Flutter debugging toolbar

[#](#vs-code-flutter-debugging-toolbar)

The toolbar allows you to debug using any debugger.
You can step in, out, and over Dart statements, hot reload, or resume the app.


![Flutter debugger toolbar in VS Code](/assets/images/docs/testing/debugging/vscode-ui/screens/debug-toolbar.png)

IconActionDefault keyboard shortcut![Small blue vertical line with a blue triangle that indicates playing or resuming the Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/play-or-resume.png)Start or Resume`F5`![Small blue double vertical line that indicates pausing the Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/pause.png)Pause`F6`![Small blue arched arrow over a blue circle that indicates skipping the current block or statement in the Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/step-over.png)Step Over`F10`![Small blue downward arrow over a blue circle that indicates going into the next function in a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/step-into.png)Step Into`F11`![Small blue upward arrow over a blue circle that indicates exiting the current function after one passthrough in a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/step-out.png)Step Out`Shift` \+ `F11`![Small yellow lightning bolt that indicates reloading the UI of a Flutter app without resetting any state values](/assets/images/docs/testing/debugging/vscode-ui/icons/hot-reload.png)Hot Reload`Ctrl` \+ `F5`![Small green almost circular arrow that indicates reloading the UI of a Flutter app and resetting any state values](/assets/images/docs/testing/debugging/vscode-ui/icons/hot-restart.png)Hot Restart`Shift` \+ `Special` \+ `F5`![Red empty square that indicates you want to stop the running Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/stop.png)Stop`Shift` \+ `F5`![Small blue magnifying class with the Flutter logo inside it that opens the Widget inspector](/assets/images/docs/testing/debugging/vscode-ui/icons/inspector.png)Open Widget Inspector

## Update test Flutter app

[#](#update-test-flutter-app)

For the remainder of this guide, you need to update the
test Flutter app. This update adds native code to debug.


1. Open the `lib/main.dart` file using your preferred IDE.

2. Replace the contents of `main.dart` with the following code.
   Expand to see Flutter code for this example



   lib/main.dart



   dart

   ```
   // Copyright 2023 The Flutter Authors. All rights reserved.
   // Use of this source code is governed by a BSD-style license that can be
   // found in the LICENSE file.
   ​
   import 'package:flutter/material.dart';
   import 'package:url_launcher/url_launcher.dart';
   ​
   void main() {
     runApp(const MyApp());
   }
   ​
   class MyApp extends StatelessWidget {
     const MyApp({super.key});
   ​
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'URL Launcher',
         theme: ThemeData(
           colorSchemeSeed: Colors.purple,
           brightness: Brightness.light,
         ),
         home: const MyHomePage(title: 'URL Launcher'),
       );
     }
   }
   ​
   class MyHomePage extends StatefulWidget {
     const MyHomePage({super.key, required this.title});
     final String title;
   ​
     @override
     State<MyHomePage> createState() => _MyHomePageState();
   }
   ​
   class _MyHomePageState extends State<MyHomePage> {
     Future<void>? _launched;
   ​
     Future<void> _launchInBrowser(Uri url) async {
       if (!await launchUrl(
         url,
         mode: LaunchMode.externalApplication,
       )) {
         throw Exception('Could not launch $url');
       }
     }
   ​
     Future<void> _launchInWebView(Uri url) async {
       if (!await launchUrl(
         url,
         mode: LaunchMode.inAppWebView,
       )) {
         throw Exception('Could not launch $url');
       }
     }
   ​
     Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
       if (snapshot.hasError) {
         return Text('Error: ${snapshot.error}');
       } else {
         return const Text('');
       }
     }
   ​
     @override
     Widget build(BuildContext context) {
       final Uri toLaunch = Uri(
           scheme: 'https',
           host: 'docs.flutter.dev',
           path: 'testing/native-debugging');
       return Scaffold(
         appBar: AppBar(
           title: Text(widget.title),
         ),
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(16),
                 child: Text(toLaunch.toString()),
               ),
               FilledButton(
                 onPressed: () => setState(() {
                   _launched = _launchInBrowser(toLaunch);
                 }),
                 child: const Text('Launch in browser'),
               ),
               const Padding(padding: EdgeInsets.all(16)),
               FilledButton(
                 onPressed: () => setState(() {
                   _launched = _launchInWebView(toLaunch);
                 }),
                 child: const Text('Launch in app'),
               ),
               const Padding(padding: EdgeInsets.all(16.0)),
               FutureBuilder<void>(future: _launched, builder: _launchStatus),
             ],
           ),
         ),
       );
     }
   }

   ```

   content\_copy

3. To add the `url_launcher` package as a dependency,
    run `flutter pub add`:





   ```
   $ flutter pub add url_launcher

   ```

   content\_copy







   ```
   Resolving dependencies...
     collection 1.17.1 (1.17.2 available)
   + flutter_web_plugins 0.0.0 from sdk flutter
     matcher 0.12.15 (0.12.16 available)
     material_color_utilities 0.2.0 (0.8.0 available)
   + plugin_platform_interface 2.1.4
     source_span 1.9.1 (1.10.0 available)
     stream_channel 2.1.1 (2.1.2 available)
     test_api 0.5.1 (0.6.1 available)
   + url_launcher 6.1.11
   + url_launcher_android 6.0.36
   + url_launcher_ios 6.1.4
   + url_launcher_linux 3.0.5
   + url_launcher_macos 3.0.5
   + url_launcher_platform_interface 2.1.3
   + url_launcher_web 2.0.17
   + url_launcher_windows 3.0.6
   Changed 10 dependencies!

   ```

   content\_copy

4. To check what changed with the codebase:
   1. In Linux or macOS, run this `find` command.





      ```
      $ find ./ -mmin -120

      ```

      content\_copy







      ```
      ./ios/Flutter/Debug.xcconfig
      ./ios/Flutter/Release.xcconfig
      ./linux/flutter/generated_plugin_registrant.cc
      ./linux/flutter/generated_plugins.cmake
      ./macos/Flutter/Flutter-Debug.xcconfig
      ./macos/Flutter/Flutter-Release.xcconfig
      ./macos/Flutter/GeneratedPluginRegistrant.swift
      ./pubspec.lock
      ./pubspec.yaml
      ./windows/flutter/generated_plugin_registrant.cc
      ./windows/flutter/generated_plugins.cmake

      ```

      content\_copy

   2. In Windows, run this command in the command prompt.





      ```
      Get-ChildItem C:\dev\example\ -Rescurse | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}

      ```

      content\_copy







      ```
      C:\dev\example\ios\Flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                Debug.xcconfig
                      8/1/2025   9:15 AM                Release.xcconfig

      C:\dev\example\linux\flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                generated_plugin_registrant.cc
                      8/1/2025   9:15 AM                generated_plugins.cmake

      C:\dev\example\macos\Flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                Flutter-Debug.xcconfig
                      8/1/2025   9:15 AM                Flutter-Release.xcconfig
                      8/1/2025   9:15 AM                GeneratedPluginRegistrant.swift

      C:\dev\example\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                pubspec.lock
                      8/1/2025   9:15 AM                pubspec.yaml

      C:\dev\example\windows\flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                generated_plugin_registrant.cc
                      8/1/2025   9:15 AM                generated_plugins.cmake

      ```

      content\_copy

Installing `url_launcher` added config files and code files
for all target platforms in the Flutter app directory.


## Debug Dart and native language code at the same time

[#](#debug-dart-and-native-language-code-at-the-same-time)

This section explains how to debug the Dart code in your Flutter app
and any native code with its regular debugger.
This capability allows you to leverage Flutter's hot reload
when editing native code.


### Debug Dart and Android code using Android Studio

[#](#debug-dart-and-android-code-using-android-studio)

To debug native Android code, you need a Flutter app that contains
Android code. In this section, you learn how to connect
the Dart, Java, and Kotlin debuggers to your app.
You don't need VS Code to debug both Dart and Android code.
This guide includes the VS Code instructions to be consistent
with the Xcode and Visual Studio guides.


These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).


#### Build the Android version of the Flutter app in the Terminal

[#](#build-the-android-version-of-the-flutter-app-in-the-terminal)

To generate the needed Android platform dependencies,
run the `flutter build` command.


```
flutter build appbundle --debug

```

content\_copy

```
Running Gradle task 'bundleDebug'...                               27.1s
✓ Built build/app/outputs/bundle/debug/app-debug.aab.

```

content\_copy

- [Start from VS Code](#138-tab-panel)
- [Start from Android Studio](#139-tab-panel)

#### Start debugging with VS Code first

[#](#from-vscode-to-android-studio)

If you use VS Code to debug most of your code, start with this section.

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

#### Attach to the Flutter process in Android Studio

[#](#attach-to-the-flutter-process-in-android-studio)

1. Click the **Attach debugger to Android process** button.
    (![Tiny green bug superimposed with a light grey arrow](/assets/images/docs/testing/debugging/native/android-studio/attach-process-button.png))

    :::tip
    If this button doesn't appear in the **Projects** menu bar, verify that
    you opened Flutter _application_ project but _not a Flutter plugin_.
    :::

2. The **process** dialog displays one entry for each connected device.
    Select **show all processes** to display available processes for each
    device.

3. Choose the process to which you want to attach.
    For this guide, select the `com.example.my_app` process
    using the **Emulator Pixel\_5\_API\_33**.

4. Locate the tab for **Android Debugger** in the **Debug** pane.

5. In the **Project** pane, expand
    **my\_app\_android** > **android** > **app** > **src** > **main** > **java** > **io.flutter plugins**.

6. Double click **GeneratedProjectRegistrant** to open the
    Java code in the **Edit** pane.


At the end of this procedure, both the Dart and Android debuggers interact
with the same process.
Use either, or both, to set breakpoints, examine stack, resume execution
and the like. In other words, debug!


#### Start debugging with Android Studio first

[#](#from-android-studio)

If you use Android Studio to debug most of your code, start with this section.

01. To open the Flutter app directory, go to
     **File** > **Open...** and choose the `my_app` directory.

02. Open the `lib/main.dart` file.

03. Choose a virtual Android device.
     Go to the toolbar, open the leftmost dropdown menu, and click on
     **Open Android Emulator: <device>**.

    You can choose any installed emulator that's doesn't include `arm64`.

04. From that same menu, select the virtual Android device.

05. From the toolbar, click **Run 'main.dart'**.

    You can also press `Ctrl` \+ `Shift` \+ `R`.

    After the app displays in the emulator, continue to the next step.

06. Click the **Attach debugger to Android process** button.
     (![Tiny green bug superimposed with a light grey arrow](/assets/images/docs/testing/debugging/native/android-studio/attach-process-button.png))

     :::tip
     If this button doesn't appear in the **Projects** menu bar, verify that
     you opened Flutter _application_ project but _not a Flutter plugin_.
     :::

07. The **process** dialog displays one entry for each connected device.
     Select **show all processes** to display available processes for each
     device.

08. Choose the process to which you want to attach.
     For this guide, select the `com.example.my_app` process
     using the **Emulator Pixel\_5\_API\_33**.

09. Locate the tab for **Android Debugger** in the **Debug** pane.

10. In the **Project** pane, expand
     **my\_app\_android** > **android** > **app** > **src** > **main** > **java** > **io.flutter plugins**.

11. Double click **GeneratedProjectRegistrant** to open the
     Java code in the **Edit** pane.


At the end of this procedure, both the Dart and Android debuggers interact
with the same process.
Use either, or both, to set breakpoints, examine stack, resume execution
and the like. In other words, debug!


### Debug Dart and iOS code using Xcode

[#](#debug-dart-and-ios-code-using-xcode)

To debug iOS code, you need a Flutter app that contains iOS code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Xcode. You need to run both VS Code and Xcode.


These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).


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

- [Start from VS Code](#140-tab-panel)
- [Start from Xcode](#141-tab-panel)

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


### Debug Dart and macOS code using Xcode

[#](#debug-dart-and-macos-code-using-xcode)

To debug macOS code, you need a Flutter app that contains macOS code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Xcode. You need to run both VS Code and Xcode.


These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).


#### Build the macOS version of the Flutter app in the Terminal

[#](#build-the-macos-version-of-the-flutter-app-in-the-terminal)

To generate the needed macOS platform dependencies,
run the `flutter build` command.


```
flutter build macos --debug

```

content\_copy

```
Building macOS application...

```

content\_copy

- [Start from VS Code](#142-tab-panel)
- [Start from XCode](#143-tab-panel)

#### Start debugging with VS Code first

[#](#vscode-macos)

##### Start the debugger in VS Code

[#](#start-the-debugger-in-vs-code)

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

##### Attach to the Flutter process in Xcode

[#](#attach-to-the-flutter-process-in-xcode-1)

1. To attach to the Flutter app, go to
    **Debug** > **Attach to Process** > **Runner**.

**Runner** should be at the top of the **Attach to Process** menu
    under the **Likely Targets** heading.


#### Start debugging with Xcode first

[#](#xcode-macos)

##### Start the debugger in Xcode

[#](#start-the-debugger-in-xcode)

1. Open `macos/Runner.xcworkspace` from your Flutter app directory.

2. Run this Runner as a normal app in Xcode.

When the run completes, the **Debug** area at the bottom of Xcode displays
    a message with the Dart VM service URI. It resembles the following response:





```
2023-07-12 14:55:39.966191-0500 Runner[58361:53017145]
       flutter: The Dart VM service is listening on
       http://127.0.0.1:50642/00wEOvfyff8=/

```

content\_copy

3. Copy the Dart VM service URI.


##### Attach to the Dart VM in VS Code

[#](#attach-to-the-dart-vm-in-vs-code-1)

1. To open the command palette, go to **View** \> **Command Palette...**

You can also press `Cmd` \+ `Shift` \+ `P`.

2. Type `debug`.

3. Click the **Debug: Attach to Flutter on Device** command.

4. In the **Paste an VM Service URI** box, paste the URI you copied
    from Xcode and press `Enter`.


### Debug Dart and C++ code using Visual Studio

[#](#debug-dart-and-c-code-using-visual-studio)

To debug C++ code, you need a Flutter app that contains C++ code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Visual Studio.
You need to run both VS Code and Visual Studio.


These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).


#### Build the Windows version of the Flutter app in PowerShell or the Command Prompt

[#](#build-the-windows-version-of-the-flutter-app-in-powershell-or-the-command-prompt)

To generate the needed Windows platform dependencies,
run the `flutter build` command.


```
C:\> flutter build windows --debug

```

content\_copy

```
Building Windows application...                                    31.4s
√  Built build\windows\runner\Debug\my_app.exe.

```

content\_copy

- [Start from VS Code](#144-tab-panel)
- [Start from Visual Studio](#145-tab-panel)

#### Start debugging with VS Code first

[#](#vscode-windows)

If you use VS Code to debug most of your code, start with this section.

##### Start the debugger in VS Code

[#](#start-the-debugger-in-vs-code-1)

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

##### Attach to the Flutter process in Visual Studio

[#](#attach-to-the-flutter-process-in-visual-studio)

1. To open the project solution file, go to
    **File** > **Open** > **Project/Solution…**

You can also press `Ctrl` \+ `Shift` \+ `O`.

2. Choose the `build/windows/my_app.sln` file in your Flutter app directory.

3. Go to **Debug** \> **Attach to Process**.

You can also press `Ctrl` \+ `Alt` \+ `P`.

4. From the **Attach to Process** dialog box, choose `my_app.exe`.

Visual Studio starts monitoring the Flutter app.


#### Start debugging with Visual Studio first

[#](#start-debugging-with-visual-studio-first)

If you use Visual Studio to debug most of your code, start with this section.

##### Start the local Windows debugger

[#](#start-the-local-windows-debugger)

1. To open the project solution file, go to
    **File** > **Open** > **Project/Solution…**

You can also press `Ctrl` \+ `Shift` \+ `O`.

2. Choose the `build/windows/my_app.sln` file in your Flutter app directory.

3. Set `my_app` as the startup project.
    In the **Solution Explorer**, right-click on `my_app`
    and select
    **Set as Startup Project**.

4. Click **Local Windows Debugger** to start debugging.

You can also press `F5`.

When the Flutter app has started, a console window displays
    a message with the Dart VM service URI. It resembles the following response:





```
flutter: The Dart VM service is listening on http://127.0.0.1:62080/KPHEj2qPD1E=/

```

content\_copy

5. Copy the Dart VM service URI.


##### Attach to the Dart VM in VS Code

[#](#attach-to-the-dart-vm-in-vs-code-2)

1. To open the command palette, go to
    **View** > **Command Palette...**

You can also press `Cmd` \+ `Shift` \+ `P`.

2. Type `debug`.

3. Click the **Debug: Attach to Flutter on Device** command.

4. In the **Paste an VM Service URI** box, paste the URI you copied
    from Visual Studio and press `Enter`.


## Resources

[#](#resources)

Check out the following resources on debugging Flutter, iOS, Android,
macOS and Windows:


### Flutter

[#](#flutter)

- [Debugging Flutter apps](/testing/debugging)
- [Flutter inspector](/tools/devtools/inspector) and the [DevTools](/tools/devtools)
   docs

- [Performance profiling](/perf/ui-performance)

### Android

[#](#android)

You can find the following debugging resources on
[developer.android.com](https://developer.android.com).


- [Debug your app](https://developer.android.com/studio/debug)
- [Android Debug Bridge (adb)](https://developer.android.com/studio/command-line/adb)

### iOS and macOS

[#](#ios-and-macos)

You can find the following debugging resources on
[developer.apple.com](https://developer.apple.com).


- [Debugging](https://developer.apple.com/support/debugging/)
- [Instruments Help](https://help.apple.com/instruments/mac/current/)

### Windows

[#](#windows)

You can find debugging resources on [Microsoft Learn](https://learn.microsoft.com/visualstudio/).


- [Visual Studio Debugger](https://learn.microsoft.com/visualstudio/debugger/?view=vs-2022)
- [Learn to debug C++ code using Visual Studio](https://learn.microsoft.com/visualstudio/debugger/getting-started-with-the-debugger-cpp?view=vs-2022)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/testing/native-debugging.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/testing/native-debugging&page-source=https://github.com/flutter/website/blob/main/src/content/testing/native-debugging.md "Report an issue with this page").