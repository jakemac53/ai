---
name: install-flutter-using-vs-code
description: Learn how to use VS Code to quickly install and set up the Flutter SDK.
metadata:
  url: https://docs.flutter.dev/install/with-vs-code
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Install Flutter using VS Code

Learn how to install and set up Flutter in a Code OSS-based editor.
This includes (but is not limited to),
[VS Code](https://code.visualstudio.com), [Antigravity](https://antigravity.google/),
[Cursor](https://cursor.com/), and [Windsurf](https://windsurf.com/).


lightbulbTip

If you've never set up or developed an app with Flutter before,
follow [Set up and test drive Flutter](/get-started/quick) instead.


## Choose your development platform

[#](#dev-platform)

The instructions on this page are configured to cover
installing Flutter on a **Windows** device.


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


1. ### Install the Xcode command-line tools


   Download the Xcode command-line tools to get access to
    the command-line tools that Flutter relies on, including Git.

   To download the tools, run the following command in your preferred terminal:





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


1. ### Install Git for Windows


   Download and install the latest version of [Git for Windows](https://git-scm.com/downloads/win).

   For help installing or troubleshooting Git,
    reference the [Git documentation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

2. ### Download and install Visual Studio Code


   To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview).


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


## Install and set up Flutter

[#](#install-flutter)

Now that you've installed Git and VS Code,
follow these steps to use VS Code to install and set up Flutter.


1. ### Launch VS Code


   If not already open, open VS Code by searching for it with Spotlight
    or opening it manually from the directory where it's installed.

2. ### Add the Flutter extension to VS Code


   To add the Dart and Flutter extensions to VS Code,
    visit the [Flutter extension's marketplace page](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter),
    and click **Install**.
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
4. ### Validate your setup


   To ensure you installed Flutter correctly,
    run `flutter doctor -v` in your preferred terminal.

   If the command isn't found or there's an error,
    check out [Flutter installation troubleshooting](/install/troubleshoot).


## Continue your Flutter journey

[#](#next-steps)

Now that you've successfully installed Flutter,
set up development for at least one target platform
to continue your journey with Flutter.


boltRecommended

If you don't yet have a preferred platform
to target during development,
the Flutter team recommends you first try out
[developing for the web](/platform-integration/web/setup)!


![A representation of Flutter on multiple devices.](/assets/images/decorative/flutter-on-phone.svg)

Set up a target platform

- [Target the web](/platform-integration/web/setup)
- [Target Android](/platform-integration/android/setup)
- [Target iOS](/platform-integration/ios/setup)
- [Target macOS](/platform-integration/macos/setup)
- [Target Windows](/platform-integration/windows/setup)
- [Target Linux](/platform-integration/linux/setup)

![Dash helping you explore Flutter learning resources.](/assets/images/decorative/pointing-the-way.png)

Learn Flutter development

- [Write your first app](/get-started/codelab)
- [Learn the fundamentals](/learn/pathway)
- [Explore Flutter widgets](https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

![Keep up to date with Flutter](/assets/images/decorative/up-to-date.png)

Stay up to date with Flutter

- [Update Flutter](/install/upgrade)
- [Find out what's new](/release/release-notes)
- [Subscribe on YouTube](https://www.youtube.com/@flutterdev)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/install/with-vs-code.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/with-vs-code&page-source=https://github.com/flutter/website/blob/main/src/content/install/with-vs-code.md "Report an issue with this page").