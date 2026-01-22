---
name: add-flutter-to-your-path
description: Learn how to add Flutter to your PATH after downloading the Flutter SDK.
metadata:
  url: https://docs.flutter.dev/install/add-to-path
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Add Flutter to your PATH

Learn how to add Flutter to your `PATH` environment variable
after downloading the SDK.
Adding Flutter to your `PATH` allows you to use the
`flutter` and `dart` command-line tools in terminals and IDEs.


lightbulbTip

If you haven't downloaded Flutter yet,
follow [Set up and test drive Flutter](/get-started/quick) instead.


[Windows\
\
Add Flutter to your path on Windows.](#windows) [macOS\
\
Add Flutter to your path on macOS.](#macos) [Linux\
\
Add Flutter to your path on Linux.](#linux) [ChromeOS\
\
Add Flutter to your path on ChromeOS.](#chromeos)

## Windows

[#](#windows)

To run `flutter` and `dart` commands in a terminal on Windows,
add the Flutter SDK's `bin` directory to the `Path` environment variable.


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


## macOS

[#](#macos)

To run `flutter` and `dart` commands in a terminal on macOS,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.


infoNote

The following steps assume you're
using the [default shell](https://support.apple.com/en-us/102360) on macOS, Zsh.


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
    use the built-in `export` command to update the `PATH` variable
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


## Linux

[#](#linux)

To run `flutter` and `dart` commands in a terminal on Linux,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.


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


## ChromeOS

[#](#chromeos)

To run `flutter` and `dart` commands in a terminal on chromeOS,
add the Flutter SDK's `bin` directory to the `PATH` environment variable.


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


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/install/add-to-path.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/add-to-path&page-source=https://github.com/flutter/website/blob/main/src/content/install/add-to-path.md "Report an issue with this page").