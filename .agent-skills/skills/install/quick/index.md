---
name: set-up-and-test-drive-flutter
description: Set up Flutter on your device with a Code OSS-based editor, such as VS Code, and get started developing your first multi-platform app with Flutter!
metadata:
  url: https://docs.flutter.dev/install/quick
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Set up and test drive Flutter

Learn how to use any Code OSS-based editor, such as VS Code,
to set up your Flutter development environment and
test drive Flutter's developer experience.


If you've developed with Flutter before,
or you prefer to use a different editor or IDE,
you can follow the [custom setup instructions](/get-started/custom) instead.


infoWhat you'll achieve

- Install the software prerequisites for Flutter.
- Use VS Code to download and install Flutter.
- Create a new Flutter app from a sample template.
- Try out Flutter development features like stateful hot reload.

## Confirm your development platform

[#](#dev-platform)

The instructions on this page are configured to cover
installing and trying out Flutter on a **Windows**
device.


If you'd like to follow the instructions for a different OS,
please select one of the following.


![Windows logo](/assets/images/docs/brand-svg/windows.svg)

Windows

![macOS logo](/assets/images/docs/brand-svg/macos.svg)

macOS

![Linux logo](/assets/images/docs/brand-svg/linux.svg)

Linux

![ChromeOS logo](/assets/images/docs/brand-svg/chromeos.svg)

ChromeOS

## Download prerequisite software

[#](#download-prerequisites)

For the smoothest Flutter setup,
first install the following tools.


1. ### Set up Linux support


   If you haven't set up Linux support on your Chromebook before,
    [Turn on Linux support](https://support.google.com/chromebook/answer/9145439).

   If you've already turned on Linux support,
    ensure it's up to date following the
    [Fix problems with Linux](https://support.google.com/chromebook/answer/9145439?hl=en#:~:text=Fix%20problems%20with%20Linux)
    instructions.

2. ### Download and install prerequisite packages


   Using `apt-get` or your preferred installation mechanism,
    install the latest versions of the following packages:


   - `curl`
   - `git`
   - `unzip`
   - `xz-utils`
   - `zip`
   - `libglu1-mesa`

If you want to use `apt-get`,
 install these packages using the following commands:

```
$ sudo apt-get update -y && sudo apt-get upgrade -y
$ sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

```

content\_copy

3. ### Download and install Visual Studio Code


   To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).

   You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.


1. ### Install git


   **If you already have git installed, skip to the next**
   **step: Download and install Visual Studio Code.**

   There are a few ways to install git on your Mac,
    but the way we recommend is by using XCode.
    This will be important when you target your
    builds for iOS or macOS.





   ```
   $ xcode-select --install

   ```

   content\_copy



   If you haven't installed the tools already,
    a dialog should open that confirms you'd like to install them.
    Click **Install**, then once the installation is complete, click
    **Done**.

2. ### Download and install Visual Studio Code


   To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).

   You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.


1. ### Install Git for Windows


   Download and install the latest version of [Git for Windows](https://git-scm.com/downloads/win).

   For help installing or troubleshooting Git,
    reference the [Git documentation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

2. ### Download and install Visual Studio Code


   To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).

   You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.


1. ### Download and install prerequisite packages


   Using your preferred package manager or mechanism,
    install the latest versions of the following packages:


   - `curl`
   - `git`
   - `unzip`
   - `xz-utils`
   - `zip`
   - `libglu1-mesa`

On Debian-based distros with `apt-get`, such as Ubuntu,
 install these packages using the following commands:

```
$ sudo apt-get update -y && sudo apt-get upgrade -y
$ sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

```

content\_copy

2. ### Download and install Visual Studio Code


   To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).

   You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.


## Install and set up Flutter

[#](#install)

Now that you've installed Git and VS Code,
follow these steps to use VS Code to install and set up Flutter.


infoDownload manually

If you prefer to manually install Flutter,
follow the instructions in [Install Flutter manually](/install/manual).


1. ### Launch VS Code


   If not already open, open VS Code by searching for it with Spotlight
    or opening it manually from the directory where it's installed.

2. ### Add the Flutter extension to VS Code


   To add the Dart and Flutter extensions to VS Code,
    visit the [Flutter extension's marketplace page](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter),
    then click **Install**.
    If prompted by your browser, allow it to open VS Code.

3. ### Install Flutter with VS Code



   1. Open the command palette in VS Code.

      Go to **View** > **Command Palette**
       or press `Cmd/Ctrl` +
       `Shift` \+ `P`.

   2. In the command palette, type `flutter`.

   3. Select **Flutter: New Project**.

   4. VS Code prompts you to locate the Flutter SDK on your computer.
       Select **Download SDK**.

   5. When the **Select Folder for Flutter SDK** dialog displays,
       choose where you want to install Flutter.

   6. Click **Clone Flutter**.

      While downloading Flutter, VS Code displays this pop-up notification:





      ```
      Downloading the Flutter SDK. This may take a few minutes.

      ```

      content\_copy



      This download takes a few minutes.
       If you suspect that the download has hung, click **Cancel** then
       start the installation again.

   7. Click **Add SDK to PATH**.

      When successful, a notification displays:





      ```
      The Flutter SDK was added to your PATH

      ```

      content\_copy

   8. VS Code might display a Google Analytics notice.

      If you agree, click **OK**.

   9. To ensure that Flutter is available in all terminals:

      1. Close, then reopen all terminal windows.
      2. Restart VS Code.

infoNote

The VS Code setup process might check for Android Studio, which can result in a warning if it's not installed.
You can safely ignore this if you're targeting other platforms (like web, iOS, or macOS), as the installation will still succeed.
Afterward, run `flutter doctor` to verify your installation.

4. ### Troubleshoot installation issues


   If you encounter any issues during installation,
    check out [Flutter installation troubleshooting](/install/troubleshoot).


## Test drive Flutter

[#](#test-drive)

Now that you've set up VS Code and Flutter,
it's time to create an app and try out Flutter development!


1. ### Create a new Flutter app

   1. Open the command palette in VS Code.

      Go to **View** > **Command Palette**
       or press `Cmd/Ctrl` +
       `Shift` \+ `P`.

   2. In the command palette, start typing `flutter:`.

      VS Code should surface commands from the Flutter plugin.

   3. Select the **Flutter: New Project** command.

      Your OS or VS Code might ask for access to your documents,
       agree to continue to the next step.

   4. Choose the **Application** template.

      VS Code should prompt you with **Which Flutter template?**.
       Choose **Application** to bootstrap a simple counter app.

   5. Create or select the parent directory for your new app's folder.

      A file dialog should appear.

      1. Select or create the parent directory where
          you want the project to be created.
      2. To confirm your selection,
          click **Select a folder to create the project in**.
   6. Enter a name for your app.

      VS Code should prompt you to enter a name for your new app.
       Enter `trying_flutter` or a similar `lowercase_with_underscores`
       name.
       To confirm your selection, press `Enter`.

   7. Wait for project initialization to complete.

      Task progress is often surfaced as a notification in the bottom right
       and can also be accessed from the **Output** panel.

   8. Open the `lib` directory, then the `main.dart` file.

      If you're curious about what each portion of the code does,
       check out the preceding comments throughout the file.
2. ### Run your app on the web


   While Flutter apps can run on many platforms,
    try running your new app on the web.
   1. Open the command palette in VS Code.

      Go to **View** > **Command Palette**
       or press `Cmd/Ctrl` +
       `Shift` \+ `P`.

   2. In the command palette, start typing `flutter:`.

      VS Code should surface commands from the Flutter plugin.

   3. Select the **Flutter: Select Device** command.

   4. From the **Select Device** prompt, select **Chrome**.

   5. Run or start debugging your app.

      Go to **Run** > **Start Debugging** or press `F5`.

      `flutter run` is used to build and start your app,
       then a new instance of Chrome should open and
       start running your newly created app.
3. ### Try hot reload


   Flutter offers a fast development cycle with **stateful hot reload**,
    the ability to reload the code of a live running app without
    restarting or losing app state.

   You can change your app's source code,
    run the hot reload command in VS Code,
    then see the change in your running app.
   1. In the running app, try adding to the counter a few times by
       clicking the ![increment (+)](/assets/images/docs/get-started/increment-button.png)
       button.

   2. With your app still running, make a change in the `lib/main.dart` file.

      Change the `_counter++` line in the `_incrementCounter` method
       to instead decrement the `_counter` field.



      dart

      ```
      setState(() {
        // ...
        _counter++;
        _counter--;
      });

      ```

      content\_copy

   3. Save your changes
       ( **File** > **Save All**) or
       click the **Hot Reload**![hot reload icon](/assets/images/docs/get-started/hot-reload.svg)
       button.

      Flutter updates the running app without losing any existing state.
       Notice the existing value stayed the same.

   4. Try clicking the
       ![increment (+)](/assets/images/docs/get-started/increment-button.png)
       button again.
       Notice the value decreases instead of increases.
4. ### Explore the Flutter sidebar


   The Flutter plugin adds a dedicated sidebar to VS Code
    for managing Flutter debug sessions and devices,
    viewing an outline of your code and widgets,
    as well as accessing the Dart and Flutter DevTools.
   1. If your app isn't running, start debugging it again.

      Go to **Run** > **Start Debugging** or press `F5`.

   2. Open the Flutter sidebar in VS Code.

      Either open it with the Flutter ![Flutter logo](/assets/images/branding/flutter/logo/square.svg)
       button in
       the VS Code sidebar or open it from the command palette by
       running the **Flutter: Focus on Flutter Sidebar View** command.

   3. In the Flutter sidebar, under **DevTools**,
       click the **Flutter Inspector** button.

      A separate **Widget Inspector** panel should open in VS Code.

      In the widget inspector, you can view your app's widget tree,
       view the properties and layout of each widget, and more.

   4. In the widget inspector, try clicking the top-level `MyHomePage` widget.

      A view of its properties and layout should open, and
       the VS Code editor should navigate to and focus the line where
       the widget was included.

   5. Explore and try out other features in
       the widget inspector and Flutter sidebar.

## Continue your Flutter journey

[#](#next-steps)

**Congratulations!**
Now that you've installed and tried out Flutter,
follow the codelab on [Building your first app](/get-started/codelab),
set up development for an [additional target platform](/platform-integration#setup), or
explore some of these resources to continue your Flutter learning journey.


![A representation of Flutter on multiple devices.](/assets/images/decorative/flutter-on-phone.svg)

Build for other platforms

- [Target Android](/platform-integration/android/setup)
- [Target iOS](/platform-integration/ios/setup)
- [Target macOS](/platform-integration/macos/setup)
- [Target Windows](/platform-integration/windows/setup)
- [Target Linux](/platform-integration/linux/setup)

![Dash helping you explore Flutter learning resources.](/assets/images/decorative/pointing-the-way.png)

Learn Flutter development

- [Write your first app](/get-started/codelab)
- [Learn the fundamentals](/learn/pathway)
- [Discover Flutter widgets](https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Explore learning resources](/reference/learning-resources)
- [Learn Dart programmingopen\_in\_new](https://dart.dev/overview)

![Keep up to date with Flutter](/assets/images/decorative/up-to-date.png)

Stay up to date with Flutter

- [Update Flutter](/install/upgrade)
- [Find out what's new](/release/release-notes)
- [Check out the blogopen\_in\_new](https://medium.com/flutter)
- [Subscribe on YouTubeopen\_in\_new](https://www.youtube.com/@flutterdev)
- [Follow on Blueskyopen\_in\_new](https://bsky.app/profile/flutter.dev)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/install/quick.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/quick&page-source=https://github.com/flutter/website/blob/main/src/content/install/quick.md "Report an issue with this page").