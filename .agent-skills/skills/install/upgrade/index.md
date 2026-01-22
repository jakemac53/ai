---
name: upgrade-flutter
description: Learn how to upgrade Flutter and switch to another channel.
metadata:
  url: https://docs.flutter.dev/install/upgrade
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Upgrade Flutter

No matter which one of the Flutter release channels
you follow, you can use the `flutter` command to upgrade your
Flutter SDK or the packages that your app depends on.


## Upgrade the Flutter SDK

[#](#upgrade-the-flutter-sdk)

To update the Flutter SDK use the `flutter upgrade` command:

```
$ flutter upgrade

```

content\_copy

This command gets the most recent version of the Flutter SDK
that's available on your current Flutter channel.


If you are using the **stable** channel
and want an even more recent version of the Flutter SDK,
switch to the **beta** channel using `flutter channel beta`,
and then run `flutter upgrade`.


### Keep informed

[#](#keep-informed)

We publish [migration guides](/release/breaking-changes) for known breaking changes.

We send announcements regarding these changes to the
[Flutter announcements mailing list](https://groups.google.com/forum/#!forum/flutter-announce).


To avoid being broken by future versions of Flutter,
consider submitting your tests to our [test registry](https://github.com/flutter/tests).


## Switching Flutter channels

[#](#switching-flutter-channels)

Flutter has two release channels:
**stable** and **beta**.


### The **stable** channel

[#](#the-stable-channel)

We recommend the **stable** channel for new users
and for production app releases.
The team updates this channel about every three months.
The channel might receive occasional hot fixes
for high-severity or high-impact issues.


The continuous integration for the Flutter team's plugins and packages
includes testing against the latest **stable** release.


The latest documentation for the **stable** branch
is at: [https://api.flutter.dev](https://api.flutter.dev)

### The **beta** channel

[#](#the-beta-channel)

The **beta** channel has the latest stable release.
This is the most recent version of Flutter that we have heavily tested.
This channel has passed all our public testing,
has been verified against test suites for Google products that use Flutter,
and has been vetted against [contributed private test suites](https://github.com/flutter/tests).
The **beta** channel receives regular hot fixes
to address newly discovered important issues.


The **beta** channel is essentially the same as the **stable** channel
but updated monthly instead of quarterly.
Indeed, when the **stable** channel is updated,
it is updated to the latest **beta** release.


### Other channels

[#](#other-channels)

We currently have one other channel, **main** (previously known as **master**).
People who [contribute to Flutter](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)
use this channel.


This channel is not as thoroughly tested as
the **beta** and **stable** channels.


We do not recommend using this channel as
it is more likely to contain serious regressions.


The latest documentation for the **main** branch
is at: [https://main-api.flutter.dev](https://main-api.flutter.dev)

### Change channels

[#](#change-channels)

To view your current channel, use the following command:

```
$ flutter channel

```

content\_copy

To change to another channel, use `flutter channel <channel-name>`.
Once you've changed your channel, use `flutter upgrade`
to download the latest Flutter SDK and dependent packages for that channel.
For example:


```
$ flutter channel beta
$ flutter upgrade

```

content\_copy

## Switch to a specific Flutter version

[#](#switch-to-a-specific-flutter-version)

To switch to a specific Flutter version:

1. Find your desired **Flutter version** on the [Flutter SDK archive](/install/archive).

2. Navigate to the Flutter SDK:





   ```
   $ cd /path/to/flutter

   ```

   content\_copy




   lightbulbTip





   You can find the Flutter SDK's path using `flutter doctor --verbose`.

3. Use `git checkout` to switch to your desired **Flutter version**:





   ```
   $ git checkout <Flutter version>

   ```

   content\_copy


## Upgrade packages

[#](#upgrade-packages)

If you've modified your `pubspec.yaml` file, or you want to update
only the packages that your app depends upon
(instead of both the packages and Flutter itself),
then use one of the `flutter pub` commands.


To update to the _latest compatible versions_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade` command:


```
$ flutter pub upgrade

```

content\_copy

To update to the _latest possible version_ of
all the dependencies listed in the `pubspec.yaml` file,
use the `upgrade --major-versions` command:


```
$ flutter pub upgrade --major-versions

```

content\_copy

This also automatically update the constraints
in the `pubspec.yaml` file.


To identify out-of-date package dependencies and get advice
on how to update them, use the `outdated` command. For details, see
the Dart [`pub outdated` documentation](https://dart.dev/tools/pub/cmd/pub-outdated).


```
$ flutter pub outdated

```

content\_copy

## Troubleshooting

[#](#troubleshooting)

### Windows: "Filename too long" error

[#](#windows-filename-too-long-error)

When running `flutter upgrade` on Windows,
you might encounter an error like the following:


```
error: unable to create file ...: Filename too long

```

content\_copy

This occurs because the path to a file in the Flutter SDK exceeds the default
maximum path length limit on Windows.


To resolve this issue, consider installing the Flutter SDK
at a shorter path. For example, install Flutter at
`C:\Flutter` instead of something longer like
`C:\Users\<user name>\Documents\flutter`.


Otherwise, do the following:

1. Enable long paths support in Git:





   ```
   $ git config --system core.longpaths true

   ```

   content\_copy



   If the command fails with a permission error,
    try running your terminal as an administrator.

2. Enable long paths in Windows:





   ```
   New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force

   ```

   content\_copy



   This command requires administrator privileges.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-9. [View source](https://github.com/flutter/website/blob/main/src/content/install/upgrade.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/install/upgrade&page-source=https://github.com/flutter/website/blob/main/src/content/install/upgrade.md "Report an issue with this page").