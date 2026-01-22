---
name: install-flutter-manually
description: Learn how to install and set up the Flutter SDK manually.
metadata:
  url: https://docs.flutter.dev/install/manual
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Install Flutter manually

Learn how to install and manually set up
your Flutter development environment.


lightbulbTip

If you've never set up or developed an app with Flutter before,
follow [Get started with Flutter](/get-started) instead.


If you're just looking to quickly install Flutter,
consider [installing Flutter with VS Code](/install/with-vs-code) for
a streamlined setup experience.


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

Before installing the Flutter SDK,
first complete the following setup.


1. ### Install Git for Windows


   Download and install the latest version of [Git for Windows](https://git-scm.com/downloads/win).

   For help installing or troubleshooting Git,
    reference the [Git documentation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

2. ### Set up an editor or IDE


   For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support](/tools/editors).


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

2. ### Set up an editor or IDE


   For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support](/tools/editors).


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

2. ### Set up an editor or IDE


   For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support](/tools/editors).


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

3. ### Set up an editor or IDE


   For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support](/tools/editors).


## Install and set up Flutter

[#](#install-flutter)

To install the Flutter SDK,
download the latest bundle from the SDK archive,
then extract the SDK to where you want it stored.


1. ### Download the Flutter SDK bundle


   Download the following installation bundle to get the
    latest stable release of the Flutter SDK.
   (loading...)
2. ### Create a folder to store the SDK


   Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at
    `%USERPROFILE%\develop` ( `C:\Users\{username}\develop`).


   infoNote





   Select a location that
   doesn't have special characters or spaces in its path and
   doesn't require elevated privileges.

3. ### Extract the SDK


   Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.


   1. Copy the following command.
   2. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
   3. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
   4. Run the edited command in your preferred terminal.

```
$ Expand-Archive –Path <sdk_zip_path> -Destination <destination_directory_path>

```

content\_copy

For example, if you downloaded the bundle for Flutter 3.29.3 into
 the `%USERPROFILE%\Downloads` directory and want to
 store the extracted SDK in the `%USERPROFILE%\develop` directory:

```
$ Expand-Archive `
  -Path $env:USERPROFILE\Downloads\flutter_windows_3.29.3-stable.zip `
  -Destination $env:USERPROFILE\develop\

```

content\_copy

1. ### Download the Flutter SDK bundle


   Depending on your macOS device's cpu architecture,
    download one of the following installation bundles to get the
    latest stable release of the Flutter SDK.

   Apple Silicon (ARM64)Intel(loading...)(loading...)

2. ### Create a folder to store the SDK


   Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at `~/develop/`.

3. ### Extract the SDK


   Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.


   1. Copy the following command.
   2. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
   3. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
   4. Run the edited command in your preferred terminal.

```
$ unzip <sdk_zip_path> -d <destination_directory_path>

```

content\_copy

For example, if you downloaded the bundle for Flutter 3.29.3 into
 the `~/Downloads` directory and want to
 store the extracted SDK in the `~/develop` directory:

```
$ unzip ~/Downloads/flutter_macos_3.29.3-stable.zip -d ~/develop/

```

content\_copy

1. ### Download the Flutter SDK bundle


   Download the following installation bundle to get the
    latest stable release of the Flutter SDK.
   (loading...)
2. ### Create a folder to store the SDK


   Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at `~/develop/`.

3. ### Extract the SDK


   Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.


   1. Copy the following command.
   2. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
   3. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
   4. Run the edited command in your preferred terminal.

```
$ tar -xf <sdk_zip_path> -C <destination_directory_path>

```

content\_copy

For example, if you downloaded the bundle for Flutter 3.29.3 into
 the `~/Downloads` directory and want to
 store the extracted SDK in the `~/develop` directory:

```
$ tar -xf ~/Downloads/flutter_linux_3.29.3-stable.tar.xz -C ~/develop/

```

content\_copy

## Add Flutter to your PATH

[#](#add-to-path)

Now that you've downloaded the SDK,
add the Flutter SDK's `bin` directory to your `PATH` environment variable.
Adding Flutter to your `PATH` allows you to use the
`flutter` and `dart` command-line tools in terminals and IDEs.


1. ### Determine your Flutter SDK installation location


Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Navigate to the environment variables settings

1. Press `Windows` \+ `Pause`.

      If your keyboard lacks a `Pause` key,
       try `Windows` \+ `Fn` \+ `B`.

      The **System > About** dialog opens.

2. Click **Advanced System Settings** > **Advanced** > **Environment Variables...**.

      The **Environment Variables** dialog opens.
3. ### Add the Flutter SDK bin to your path

1. In the **User variables for (username)** section
       of the **Environment Variables** dialog,
       look for the **Path** entry.

2. If the **Path** entry exists, double-click it.

      The **Edit Environment Variable** dialog should open.

      1. Double-click inside an empty row.

      2. Type the path to the `bin` directory of your Flutter installation.

         For example, if you downloaded Flutter into a
          `develop\flutter` folder inside your user directory,
          you'd type the following:





         ```
         %USERPROFILE%\develop\flutter\bin

         ```

         content\_copy

      3. Click the Flutter entry you added to select it.

      4. Click **Move Up** until the Flutter entry sits at the top of the list.

      5. To confirm your changes, click **OK** three times.
3. If the entry doesn't exist, click **New...**.

      The **Edit Environment Variable** dialog should open.

      1. In the **Variable Name** box, type `Path`.

      2. In the **Variable Value** box,
          type the path to the `bin` directory of your Flutter installation.

         For example, if you downloaded Flutter into a
          `develop\flutter` folder inside your user directory,
          you'd type the following:





         ```
         %USERPROFILE%\develop\flutter\bin

         ```

         content\_copy

      3. To confirm your changes, click **OK** three times.
4. ### Apply your changes


To apply this change and get access to the `flutter` tool,
    close and reopen all open command prompts,
    sessions in your terminal apps, and IDEs.

5. ### Validate your setup


To ensure you successfully added the SDK to your `PATH`,
    open command prompt or your preferred terminal app,
    then try running the `flutter` and `dart` tools.





```
$ flutter --version
$ dart --version

```

content\_copy



If either command isn't found,
    check out [Flutter installation troubleshooting](/install/troubleshoot).


infoNote

The following steps assume you're
using the [default shell](https://support.apple.com/en-us/102360)
on macOS, Zsh.


If you use another shell besides Zsh,
check out [this tutorial on setting your PATH](https://www.cyberciti.biz/faq/unix-linux-adding-path/).


1. ### Determine your Flutter SDK installation location


Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Open or create the Zsh environment variable file


If it exists, open the [Zsh environment variable file](https://zsh.sourceforge.io/Intro/intro_3.html) `~/.zprofile` in your preferred text editor.
    If it doesn't exist, create the `~/.zprofile` file.

3. ### Add the Flutter SDK bin to your path


At the end of your `~/.zprofile` file,
    use the built-in `export` command to update the `PATH`
    variable
    to include the `bin` directory of your Flutter installation.

Replace `<path-to-sdk>` with the path to your Flutter SDK installation.



bash

```
export PATH="<path-to-sdk>/bin:$PATH"

```

content\_copy



For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    you'd add the following to the file:



bash

```
export PATH="$HOME/develop/flutter/bin:$PATH"

```

content\_copy

4. ### Save your changes


Save, then close, the `~/.zprofile` file you edited.

5. ### Apply your changes


To apply this change and get access to the `flutter` tool,
    close and reopen all open Zsh sessions in your terminal apps and IDEs.

6. ### Validate your setup


To ensure you successfully added the SDK to your `PATH`,
    open a Zsh session in your preferred terminal,
    then try running the `flutter` and `dart` tools.





```
$ flutter --version
$ dart --version

```

content\_copy



If either command isn't found,
    check out [Flutter installation troubleshooting](/install/troubleshoot).


1. ### Determine your Flutter SDK installation location


Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Determine your default shell


If you don't know what shell you use,
    check which shell starts when you open a new console window.





```
$ echo $SHELL

```

content\_copy

3. ### Add the Flutter SDK bin to your path


To add the `bin` directory of your Flutter installation to your `PATH`:


1. Expand the instructions for your default shell.
2. Copy the provided command.
3. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
4. Run the edited command in your preferred terminal with that shell.

* * *

Expand for `bash` instructions

```
$ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.bashrc

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.bashrc

```

content\_copy

Expand for `zsh` instructions

```
$ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.zshenv

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.zshenv

```

content\_copy

Expand for `fish` instructions

```
$ fish_add_path -g -p <path-to-sdk>/bin

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ fish_add_path -g -p ~/develop/flutter/bin

```

content\_copy

Expand for `csh` instructions

```
$ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.cshrc

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'setenv PATH "$HOME/develop/flutter/bin:$PATH"' >> ~/.cshrc

```

content\_copy

Expand for `tcsh` instructions

```
$ echo 'setenv PATH "<path-to-sdk>/bin:$PATH"' >> ~/.tcshrc

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'setenv PATH "$HOME/develop/flutter/bin:$PATH"' >> ~/.tcshrc

```

content\_copy

Expand for `ksh` instructions

```
$ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.profile

```

content\_copy

Expand for `sh` instructions

```
$ echo 'export PATH="<path-to-sdk>/bin:$PATH"' >> ~/.profile

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.profile

```

content\_copy

4. ### Apply your changes


To apply this change and get access to the `flutter` tool,
    close and reopen all open shell sessions in your terminal apps and IDEs.

5. ### Validate your setup


To ensure you successfully added the SDK to your `PATH`,
    open your preferred terminal with your default shell,
    then try running the `flutter` and `dart` tools.





```
$ flutter --version
$ dart --version

```

content\_copy



If either command isn't found,
    check out [Flutter installation troubleshooting](/install/troubleshoot).


infoNote

The following steps assume
you've already [turned on Linux support](https://support.google.com/chromebook/answer/9145439)
and that
you're using Bash or the default shell on ChromeOS.


If you're using a different shell besides the default or Bash, follow the
[add to path instructions for Linux](/install/add-to-path#linux)
instead.


1. ### Determine your Flutter SDK installation location


Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Add the Flutter SDK bin to your path


To add the `bin` directory of your Flutter installation to your `PATH`:


1. Copy the following command.
2. Replace `<path-to-sdk>` with the path to your Flutter SDK install.
3. Run the edited command in your preferred terminal.

```
$ echo 'export PATH="<path-to-sdk>:$PATH"' >> ~/.bash_profile

```

content\_copy

For example, if you downloaded Flutter into a
`develop/flutter` folder inside your user directory,
you'd run the following:

```
$ echo 'export PATH="$HOME/develop/flutter/bin:$PATH"' >> ~/.bash_profile

```

content\_copy

3. ### Apply your changes


To apply this change and get access to the `flutter` tool,
    close and reopen all open Zsh sessions in your terminal apps and IDEs.

4. ### Validate your setup


To ensure you successfully added the SDK to your `PATH`,
    open a Zsh session in your preferred terminal,
    then try running the `flutter` and `dart` tools.





```
$ flutter --version
$ dart --version

```

content\_copy



If either command isn't found,
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
[developing on the web](/platform-integration/web/setup)!


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

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/install/manual.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/manual&page-source=https://github.com/flutter/website/blob/main/src/content/install/manual.md "Report an issue with this page").