---
name: using-flutter-in-china
description: How to use, access, and learn about Flutter in China.
metadata:
  url: https://docs.flutter.dev/community/china
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Using Flutter in China

infoNote

如果你正在中国的网络环境下配置 Flutter，
请参考 [在中国网络环境下使用 Flutter](https://docs.flutter.cn/community/china) 文档.


To speed the download and installation of Flutter in China,
consider using a [mirror site](https://en.wikipedia.org/wiki/Mirror_site)
or _mirror_.


feedbackImportant

Use mirror sites _only_ if you _trust_ the provider.
The Flutter team can't verify their reliability or security.


## Use a Flutter mirror site

[#](#use-a-flutter-mirror-site)

The [China Flutter User Group](https://github.com/cfug) (CFUG) maintains a Simplified Chinese
Flutter website [https://flutter.cn](https://flutter.cn) and a mirror.
Other mirrors can be found at the [end of this guide](#known-trusted-community-run-mirror-sites).


### Configure your machine to use a mirror site

[#](#configure-your-machine-to-use-a-mirror-site)

To install or use Flutter in China, use a trustworthy Flutter mirror.
This requires setting two environment variables on your machine.


_All examples that follow presume that you are using the CFUG mirror._

To set your machine to use a mirror site:

- [Windows](#19-tab-panel)
- [macOS](#20-tab-panel)
- [Linux](#21-tab-panel)

These steps require using PowerShell.

1. Open a new window in PowerShell to prepare to run shell commands.

2. Set `PUB_HOSTED_URL` to your mirror site.





```
$ $env:PUB_HOSTED_URL="https://pub.flutter-io.cn"

```

content\_copy

3. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.





```
$ $env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

```

content\_copy

4. Download the Flutter archive from your preferred mirror site.

For CFUG, visit their [Flutter SDK archive](https://docs.flutter.cn/install/archive/),
    and download the SDK for your platform and architecture.

5. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `$env:USERPROFILE\dev`.





```
$ New-Item -Path "$env:USERPROFILE\dev" -ItemType Directory; cd "$env:USERPROFILE\dev"

```

content\_copy

6. Extract the SDK from the zip archive file.

This example assumes you downloaded the Windows version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.





```
$ Expand-Archive .\flutter_windows_3.35.5-stable.zip

```

content\_copy

7. Add Flutter to your `PATH` environment variable.





```
$ $env:PATH = $pwd.PATH + "\flutter\bin",$env:PATH -join ";"

```

content\_copy

8. Begin developing with Flutter.

After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH](/install/add-to-path#windows),
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`
    variables.


1. Open a new window in your terminal to prepare to run shell commands.

2. Set `PUB_HOSTED_URL` to your mirror site.





```
$ export PUB_HOSTED_URL="https://pub.flutter-io.cn"

```

content\_copy

3. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.





```
$ export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

```

content\_copy

4. Download the Flutter archive from your preferred mirror site.

For CFUG, visit their [Flutter SDK archive](https://docs.flutter.cn/install/archive/),
    and download the SDK for your platform and architecture.

5. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `~/dev`.





```
$ mkdir ~/dev; cd ~/dev

```

content\_copy

6. Extract the SDK from the zip archive file.

This example assumes you downloaded the macOS version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.





```
$ unzip flutter_macos_3.35.5-stable.zip

```

content\_copy

7. Add Flutter to your `PATH` environment variable.





```
$ export PATH="$PWD/flutter/bin:$PATH"

```

content\_copy

8. Begin developing with Flutter.

After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH](/install/add-to-path#macos),
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`
    variables.


1. Open a new window in your terminal to prepare to run shell commands.

2. Set `PUB_HOSTED_URL` to your mirror site.





```
$ export PUB_HOSTED_URL="https://pub.flutter-io.cn"

```

content\_copy

3. Set `FLUTTER_STORAGE_BASE_URL` to your mirror site.





```
$ export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

```

content\_copy

4. Download the Flutter archive from your preferred mirror site.

For CFUG, visit their [Flutter SDK archive](https://docs.flutter.cn/install/archive/),
    and download the SDK for your platform and architecture.

5. Create a folder where you can install Flutter. Then change into it.
    Consider a path like `~/dev`.





```
$ mkdir ~/dev; cd ~/dev

```

content\_copy

6. Extract the SDK from the tar archive file.

This example assumes you downloaded the Linux version of the Flutter SDK.
    You'll need to replace the path to the archive with the
    path to the archive file and version you downloaded.





```
$ tar -xf flutter_linux_3.35.5-stable.tar.xz

```

content\_copy

7. Add Flutter to your `PATH` environment variable.





```
$ export PATH="$PWD/flutter/bin:$PATH"

```

content\_copy

8. Begin developing with Flutter.

After following these steps,
    Flutter fetches packages and artifacts from `flutter-io.cn`
    in the current terminal window.

To set these values permanently across terminals,
    follow the instructions on adding [Flutter to your PATH](/install/add-to-path#linux),
    also adding the `PUB_HOSTED_URL` and `FLUTTER_STORAGE_BASE_URL`
    variables.


### Download Flutter archives based on a mirror site

[#](#download-flutter-archives-based-on-a-mirror-site)

To download Flutter from the [SDK archive](/install/archive) from a mirror,
replace `storage.googleapis.com` with the URL of your trusted mirror.
Use your mirror site in the browser or in other applications
like IDM or Thunder.
This should improve download speed.


The following example shows how to change the URL for Flutter's download site
from Google's archive to CFUG's mirror.


- [Windows](#22-tab-panel)
- [macOS](#23-tab-panel)
- [Linux](#24-tab-panel)

To download the x64, Windows version of the Flutter SDK,
you would change the original URL from:


```
https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.35.5-stable.zip

```

content\_copy

to the mirror URL:

```
https://storage.flutter-io.cn/flutter_infra_release/releases/stable/windows/flutter_windows_3.35.5-stable.zip

```

content\_copy

To download the arm64, macOS version of the Flutter SDK,
you would change the original URL from:


```
https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.35.5-stable.zip

```

content\_copy

to the mirror URL:

```
https://storage.flutter-io.cn/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.35.5-stable.zip

```

content\_copy

To download the Linux version of the Flutter SDK,
you would change the original URL from:


```
https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.5-stable.tar.xz

```

content\_copy

to the mirror URL:

```
https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_3.35.5-stable.tar.xz

```

content\_copy

infoNote

Not every mirror supports downloading artifacts using their direct URL.

## Configure your machine to publish your package

[#](#configure-your-machine-to-publish-your-package)

To publish your packages to `pub.dev`,
you need to be able to access both Google Auth and the `pub.dev` site.


To enable access to `pub.dev`:

- [Windows](#25-tab-panel)
- [macOS](#26-tab-panel)
- [Linux](#27-tab-panel)

1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies](https://dart.dev/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall).

2. Verify that your `PUB_HOSTED_URL` environment variable is either unset
    or empty.





```
$ echo $env:PUB_HOSTED_URL

```

content\_copy



If this command returns any value, unset it.





```
$ Remove-Item $env:PUB_HOSTED_URL

```

content\_copy


1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies](https://dart.dev/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall).

2. Verify that your `PUB_HOSTED_URL` environment variable is
    either unset or empty.





```
$ echo $PUB_HOSTED_URL

```

content\_copy



If this command returns any value, unset it.





```
$ unset $PUB_HOSTED_URL

```

content\_copy


1. Configure a proxy.
    To configure a proxy, check out the
    [Dart documentation on proxies](https://dart.dev/tools/pub/troubleshoot#pub-get-fails-from-behind-a-corporate-firewall).

2. Verify that your `PUB_HOSTED_URL` environment variable is
    either unset or empty.





```
$ echo $PUB_HOSTED_URL

```

content\_copy



If this command returns any value, unset it.





```
$ unset $PUB_HOSTED_URL

```

content\_copy


To learn more about publishing packages, check out the
[Dart documentation on publishing packages](https://dart.dev/tools/pub/publishing).


## Known, trusted community-run mirror sites

[#](#known-trusted-community-run-mirror-sites)

The Flutter team can't guarantee the long-term availability of any mirrors.
You can use other mirrors if they become available.


* * *

### China Flutter User Group

[#](#china-flutter-user-group)

[China Flutter User Group](https://github.com/cfug) maintains the `flutter-io.cn`
mirror.
It includes the Flutter SDK and pub packages.


#### Configure your machine to use this mirror

[#](#configure-your-machine-to-use-this-mirror)

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

```

content\_copy

On Windows:

```
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

```

content\_copy

#### Get support for this mirror

[#](#get-support-for-this-mirror)

If you're running into issues that only occur when
using the `flutter-io.cn` mirror, report the issue to their
[issue tracker](https://github.com/cfug/flutter.cn/issues/new/choose).


* * *

### Shanghai Jiao Tong University \*nix User Group

[#](#shanghai-jiao-tong-university-nix-user-group)

[Shanghai Jiao Tong University \*nix User Group](https://github.com/sjtug) maintains the `mirror.sjtu.edu.cn`
mirror.
It includes the Flutter SDK and pub packages.


#### Configure your machine to use this mirror

[#](#configure-your-machine-to-use-this-mirror-1)

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```
export PUB_HOSTED_URL=https://mirror.sjtu.edu.cn/dart-pub
export FLUTTER_STORAGE_BASE_URL=https://mirror.sjtu.edu.cn

```

content\_copy

On Windows:

```
$env:PUB_HOSTED_URL="https://mirror.sjtu.edu.cn/dart-pub"
$env:FLUTTER_STORAGE_BASE_URL="https://mirror.sjtu.edu.cn"

```

content\_copy

#### Get support for this mirror

[#](#get-support-for-this-mirror-1)

If you're running into issues that only occur when
using the `mirror.sjtu.edu.cn` mirror, report the issue to their
[issue tracker](https://github.com/sjtug/mirror-requests).


* * *

### Tsinghua University TUNA Association

[#](#tsinghua-university-tuna-association)

[Tsinghua University TUNA Association](https://tuna.moe) maintains the `mirrors.tuna.tsinghua.edu.cn`
mirror.
It includes the Flutter SDK and pub packages.


#### Configure your machine to use this mirror

[#](#configure-your-machine-to-use-this-mirror-2)

To set your machine to use this mirror, use these commands.

On macOS, Linux, or ChromeOS:

```
export PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
export FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter

```

content\_copy

On Windows:

```
$env:PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub"
$env:FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"

```

content\_copy

#### Get support for this mirror

[#](#get-support-for-this-mirror-2)

If you're running into issues that only occur when
using the `mirrors.tuna.tsinghua.edu.cn` mirror, report the issue to their
[issue tracker](https://github.com/tuna/issues).


## Offer to host a new mirror site

[#](#offer-to-host-a-new-mirror-site)

If you're interested in setting up your own mirror,
contact [flutter-dev@googlegroups.com](mailto:flutter-dev@googlegroups.com)

for assistance.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-8. [View source](https://github.com/flutter/website/blob/main/src/content/community/china/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/community/china&page-source=https://github.com/flutter/website/blob/main/src/content/community/china/index.md "Report an issue with this page").