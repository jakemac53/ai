---
name: troubleshooting-installation
description: Get help with common installation issues that new Flutter developers might have run into.
metadata:
  url: https://docs.flutter.dev/install/troubleshoot
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Troubleshooting installation

This page describes some common installation issues that
new Flutter users have encountered and offers suggestions
on how to resolve them.


If you are still experiencing problems after
using this page, consider reaching out to any of
the resources listed under [community support channels](#community-support).
To add a topic to this page or make a correction,
you can [file an issue](https://github.com/flutter/website/issues/new) or
submit a [pull request](https://github.com/flutter/website/pulls) on GitHub.


## Get the Flutter SDK

[#](#get-the-flutter-sdk)

### Unable to find the `flutter` command

[#](#unable-to-find-the-flutter-command)

**What does this issue look like?**

When you try to run the `flutter` command,
the console fails to find it.
The error usually looks as follows:


```
'flutter' is not recognized as an internal or external command operable program or batch file

```

content\_copy

Error messages on macOS and Linux could look slightly different from
the one on Windows.


**Explanation and suggestions**

Did you add Flutter to the `PATH` environment variable for your platform?
On Windows, follow these [instructions for adding a command\
to your path](https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows).


If you've already [set up VS Code](/tools/vs-code#setup) for Flutter development,
you can use the Flutter extension's **Locate SDK** prompt
to identify the location of your `flutter` folder.


See also: [Configuring PATH and Environment Variables - Dart Code](https://dartcode.org/docs/configuring-path-and-environment-variables/)

### Flutter in special folders

[#](#flutter-in-special-folders)

**What does this issue look like?**

Running your Flutter project produces an error like the following:

```
The Flutter SDK is installed in a protected folder and may not function correctly.
Please move the SDK to a location that is user-writable without Administration permissions and restart.

```

content\_copy

**Explanation and suggestions**

On Windows, this usually happens when Flutter is installed
in a directory like
`C:\Program Files\` that requires elevated privileges.
Try relocating Flutter to a different folder,
such as `C:\src\flutter`.


### Invoke-Expression: You cannot call a method on a null-valued expression

[#](#invoke-expression-you-cannot-call-a-method-on-a-null-valued-expression)

**What does this issue look like?**

When running `flutter doctor` on Windows, you might see an error like:

```
Invoke-Expression : You cannot call a method on a null-valued expression.
At ...\update_engine_version.ps1:60 char:20

```

content\_copy

**Explanation and suggestions**

This error typically occurs when the `SystemRoot` environment variable is missing
or when the PowerShell execution policy prevents the script from running correctly.


To resolve this:

1. **Run as Administrator**:
    Open your PowerShell terminal as an Administrator.

2. **Check Environment Variables**:
    Ensure the `SystemRoot` environment variable is set (usually to `C:\Windows`). You can check its value by running
    `echo $env:SystemRoot` in your PowerShell terminal.

3. **Check Execution Policy**:
    If the issue persists, you might need to adjust your execution policy.
    Run the following command in an Administrator PowerShell window:



   powershell

   ```
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

   ```

   content\_copy


## Android setup

[#](#android-setup)

### Having multiple versions of Java installed

[#](#having-multiple-versions-of-java-installed)

**What does this issue look like?**

The command `flutter doctor --android-licenses` fails.
Running `flutter doctor --verbose` gives an error message
like the following:


```
java.lang.UnsupportedClassVersionError: com/android/prefs/AndroidLocationsProvider
has been compiled by a more recent version of the Java Runtime (class file version 55.0),
this version of the Java Runtime only recognizes class file versions up to 52.0

```

content\_copy

**Explanation and suggestions**

The error occurs when an older version of the
Java Development Kit (JDK)
is installed on your computer.


If you don't need multiple versions of Java,
uninstall existing JDKs from your computer.
Flutter automatically uses the JDK included in Android Studio.


If you do need another version of Java,
try the workaround described in
[this GitHub issue](https://github.com/flutter/flutter/issues/106416#issuecomment-1522198064)

until a long-term solution is implemented.
For more information,
check out the [Android Java Gradle migration guide](/release/breaking-changes/android-java-gradle-migration-guide)

or [flutter doctor --android-licenses not working due to\
java.lang.UnsupportedClassVersionError - Stack Overflow](https://stackoverflow.com/questions/75328050/).


### `cmdline-tools` component is missing

[#](#cmdline-tools-component-is-missing)

**What does this issue look like?**

The `flutter doctor` command complains that the
`cmdline-tools` are missing from the Android toolchain.
For example:


```
[!] Android toolchain - develop for Android devices (Android SDK version 33.0.2)
    • Android SDK at C:\Users\My PC\AppData\Local\Android\sdk
    X cmdline-tools component is missing

```

content\_copy

**Explanation and suggestions**

The easiest way to get the cmdline-tools is through the
SDK Manager in Android Studio.
To do this, use the following instructions:


1. Open the SDK Manager from Android Studio by
    selecting **Tools > SDK Manager** from the menu bar.

2. Select the latest Android SDK
    (or a specific version that your app requires),
    Android SDK Command-line Tools, and Android SDK Build-Tools.

3. Click **Apply** to install the selected artifacts.

![Android Studio SDK Manager](/assets/images/docs/get-started/install_android_tools.png)

If you're not using Android Studio,
you can download the tools using the
[sdkmanager](https://developer.android.com/studio/command-line/sdkmanager)
command-line tool.


## macOS setup

[#](#macos-setup)

### SocketException: Send failed, OS Error: No route to host, errno = 65

[#](#socketexception-send-failed-os-error-no-route-to-host-errno-65)

**What does this issue look like?**

On macOS, the `flutter run` command produces an error like:

```
$ flutter run
Launching lib/main.dart in debug mode...
...
Installing and launching...
Oops; flutter has exited unexpectedly: "SocketException: Send failed (OS Error: No route to host, errno = 65), address = 0.0.0.0, port = 5353".

```

content\_copy

**Explanation and suggestions**

This issue is related to macOS permissions.

To fix this:

1. Upgrade your Flutter SDK to the latest version.

2. Open **System Settings** \> **Privacy & Security** \> **Local Network**.
    Toggle on the permission for all the code editors and terminals you use to
    launch Flutter apps.
    You might need to restart your code editor, terminal, and physical device.


## Other problems

[#](#other-problems)

### Exit code 69

[#](#exit-code-69)

**What does this issue look like?**

Running a `flutter` command produces an "exit code: 69" error,
as shown in the following example:


```
Running "flutter pub get" in flutter_tools...
Resolving dependencies in .../flutter/packages/flutter_tools... (28.0s)
Got TLS error trying to find package test at https://pub.dev/.
pub get failed
command:
".../flutter/bin/cache/dart-sdk/bin/
dart __deprecated_pub --color --directory
.../flutter/packages/flutter_tools get --example"
pub env: {
  "FLUTTER_ROOT": ".../flutter",
  "PUB_ENVIRONMENT": "flutter_cli:get",
  "PUB_CACHE": ".../.pub-cache",
}
exit code: 69

```

content\_copy

**Explanation and suggestions**

This issue is related to networking.
Try the following instructions to troubleshoot:


- Check your internet connection.
   Make sure that you're connected to the
   internet and that your connection is stable.

- Restart your devices, including your computer
   and networking equipment.

- Use a VPN to help to bypass any restrictions that
   might prevent you from connecting to the network.

- If you have tried all of these steps and are
   still getting the error, print out verbose logs
   with the `flutter doctor -v` command and ask for help in
   one of the [community support channels](#community-support).


## Community support

[#](#community-support)

The Flutter community is helpful and welcoming.
If none of the above suggestions solves your installation issue,
consider asking for support from one of the following channels:


- [/r/flutterhelp](https://www.reddit.com/r/flutterhelp/) on Reddit
- [/r/flutterdev](https://discord.gg/rflutterdev) on Discord,
   particularly the `install-and-setup` channel on this server.

- [StackOverflow](https://stackoverflow.com),
   in particular, questions tagged with [#flutter](https://stackoverflow.com/questions/tagged/flutter)
   or [#dart](https://stackoverflow.com/questions/tagged/dart).


To be respectful of everyone's time,
search the archive for a similar issue before posting a new one.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-9. [View source](https://github.com/flutter/website/blob/main/src/content/install/troubleshoot.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/troubleshoot&page-source=https://github.com/flutter/website/blob/main/src/content/install/troubleshoot.md "Report an issue with this page").