---
name: uninstall-flutter
description: How to remove the Flutter SDK and clean up its configuration files.
metadata:
  url: https://docs.flutter.dev/install/uninstall
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Uninstall Flutter

To remove the Flutter SDK from your development machine,
delete the directories that store Flutter and its configuration files.


## Choose your development platform

[#](#dev-platform)

The instructions on this page are configured to cover
uninstall Flutter on a **Windows** device.


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

## Uninstall the Flutter SDK

[#](#uninstall)

1. ### Determine your Flutter SDK installation location


   Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Remove the installation directory


   To uninstall the Flutter SDK,
    delete the `flutter` directory you installed Flutter to.

   For example, if you downloaded Flutter into a
    `develop\flutter` folder inside your user directory,
    run the following command to delete the SDK:





   ```
   $ Remove-Item -Recurse -Force -Path (Join-Path $env:USERPROFILE "develop\flutter")

   ```

   content\_copy


1. ### Determine your Flutter SDK installation location


   Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

2. ### Remove the installation directory


   To uninstall the Flutter SDK,
    delete the `flutter` directory you installed Flutter to.

   For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    run the following command to delete the SDK:





   ```
   $ rm -rf ~/develop/flutter

   ```

   content\_copy


## Clean up installation and configuration files

[#](#cleanup)

Flutter and Dart add to additional directories in your home directory.
These contain configuration files and package downloads.
The following cleanup is optional.


1. ### Remove Flutter configuration directories


   If you don't want to preserve your Flutter tooling configuration,
    remove the following directories from your device.



- `%APPDATA%\.flutter-devtools`

To remove these directories, run the following command:

```
$ Remove-Item -Recurse -Force -Path (Join-Path $env:APPDATA ".flutter-devtools")

```

content\_copy

- `~/.flutter`
- `~/.flutter-devtools`
- `~/.flutter_settings`

To remove these directories, run the following command:

```
$ rm -rf  ~/.flutter ~/.flutter-devtools ~/.flutter_settings

```

content\_copy

2. ### Remove Dart configuration directories


   If you don't want to preserve your Dart tooling configuration,
    remove the following directories from your device.



- `%APPDATA%\.dart`
- `%APPDATA%\.dart-tool`
- `%LOCALAPPDATA%\.dartServer`

To remove these directories, run the following command:

```
$ Remove-Item -Recurse -Force -Path (Join-Path $env:APPDATA ".dart"), (Join-Path $env:APPDATA ".dart-tool"), (Join-Path $env:LOCALAPPDATA ".dartServer")

```

content\_copy

- `~/.dart`
- `~/.dart-tool`
- `~/.dartServer`

To remove these directories, run the following command:

```
$ rm -rf  ~/.dart ~/.dart-tool ~/.dartServer

```

content\_copy

3. ### Remove pub package directories


   If you don't want to preserve your locally installed pub packages,
    remove the [pub system cache](https://dart.dev/tools/pub/glossary#system-cache)
    directory from your device.



   If you didn't change the location of the pub system cache,
   run the following command to
   delete the `%LOCALAPPDATA%\Pub\Cache` directory:







   ```
   $ Remove-Item -Recurse -Force -Path (Join-Path $env:LOCALAPPDATA "Pub\Cache")

   ```

   content\_copy







   If you didn't change the location of the pub system cache,
   run the following command to delete the `~/.pub-cache` directory:







   ```
   $ rm -rf ~/.pub-cache

   ```

   content\_copy


## Reinstall Flutter

[#](#reinstall)

You can [reinstall Flutter](/install) or
[just Dart](https://dart.dev/get-dart) at any time.
If you removed any configuration directories,
reinstalling Flutter restores them to default settings.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/install/uninstall.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/uninstall&page-source=https://github.com/flutter/website/blob/main/src/content/install/uninstall.md "Report an issue with this page").