---
name: accessibility-technologies
description: Information about accessibility technologies for Flutter developers.
metadata:
  url: https://docs.flutter.dev/ui/accessibility/assistive-technologies
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Accessibility technologies

## Summary

[#](#summary)

Assistive technologies are essential for making digital content accessible to
individuals with disabilities. This document provides an overview of two key
categories of assistive technologies relevant to Flutter development: screen
readers for users with visual impairments and mobility support tools for
those with motor limitations. By understanding and testing with these
technologies, you can ensure your Flutter application provides a more inclusive
and user-friendly experience for everyone.


## Screen readers

[#](#screen-readers)

For mobile, screen readers ( [TalkBack](https://support.google.com/accessibility/android/answer/6283677?hl=en),
[VoiceOver](https://www.apple.com/lae/accessibility/iphone/vision/))
enable visually impaired users to get spoken feedback about
the contents of the screen and interact with the UI by using
gestures on mobile and keyboard shortcuts on desktop.
Turn on VoiceOver or TalkBack on your mobile device and
navigate around your app.


**To turn on the screen reader on your device, complete the following steps:**

- [Android](#6-tab-panel)
- [iOS or iPadOS](#7-tab-panel)
- [Browsers](#8-tab-panel)
- [Desktop](#9-tab-panel)

1. On your device, open **Settings**.
2. Select **Accessibility** and then **TalkBack**.
3. Turn 'Use TalkBack' on or off.
4. Select Ok.

To learn how to find and customize Android's
accessibility features, view the following video.


[Watch on YouTube in a new tab: "Customize Pixel and Android accessibility features"](https://www.youtube.com/watch/FQyj_XTl01w)

1. On your device, open **Settings > Accessibility > VoiceOver**
2. Turn the VoiceOver setting on or off

To learn how to find and customize iOS
accessibility features, view the following video.


[Watch on YouTube in a new tab: "How to navigate your iPhone or iPad with VoiceOver"](https://www.youtube.com/watch/ROIe49kXOc8)

For web, the following screen readers are currently supported:

Mobile browsers:

- iOS - VoiceOver
- Android - TalkBack

Desktop browsers:

- macOS - VoiceOver
- Windows - JAWs & NVDA

Screen readers users on web must toggle the
"Enable accessibility" button to build the semantics tree.
Users can skip this step if you programmatically auto-enable
accessibility for your app using this API:


dart

```
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
​
void main() {
  runApp(const MyApp());
  SemanticsBinding.instance.ensureSemantics();
}

```

content\_copy

Windows comes with a screen reader called Narrator
but some developers recommend using the more popular
NVDA screen reader. To learn about using NVDA to test
Windows apps, check out
[Screen Readers 101 For Front-End Developers (Windows)](https://get-evinced.com/blog/screen-readers-101-for-front-end-developers-windows).


On a Mac, you can use the desktop version of VoiceOver,
which is included in macOS.


[Watch on YouTube in a new tab: "Screen reader basics: VoiceOver"](https://www.youtube.com/watch/5R-6WvAihms)

On Linux, a popular screen reader is called Orca.
It comes pre-installed with some distributions
and is available on package repositories such as `apt`.
To learn about using Orca, check out
[Getting started with Orca screen reader on Gnome desktop](https://www.a11yproject.com/posts/getting-started-with-orca).


Check out the following [video demo](https://www.youtube.com/watch?v=A6Sx0lBP8PI) to see how to
use VoiceOver with the now-archived [Flutter Gallery](https://flutter-gallery-archive.web.app)
web app.


Flutter's standard widgets generate an accessibility tree automatically.
However, if your app needs something different,
it can be customized using the [`Semantics` widget](https://api.flutter.dev/flutter/widgets/Semantics-class.html).


When there is text in your app that should be voiced
with a specific voice, inform the screen reader
which voice to use by calling [`TextSpan.locale`](https://api.flutter.dev/flutter/painting/TextSpan/locale.html).
`MaterialApp.locale` and `Localizations.override`
will affect screen reader voices starting from flutter 3.38 release.
Usually, the screen reader uses the system voice
except where you explicitly set it with `TextSpan.locale`.


## Mobility support

[#](#mobility-support)

For users with limited dexterity or hand strength, mobility support features
can be helpful. Both Android and iOS offer a range of tools designed to make
navigation and control easier.
These features allow users to operate their devices through external switches,
voice commands, or simplified on-screen menus.


Android provides Switch Access, Voice Access and Accessibility Menu,
while iOS offers Switch Control, Voice Control, and AssistiveTouch.
Understanding these tools helps in creating
apps that are usable by people with diverse physical abilities.


OSFeatures FunctionsAndroid**Switch Access**As an alternate input method, you can use Switch Access and Camera SwitchesAndroid**Voice Access**Control your device with your voiceAndroid**Accessibility Menu**A floating, on-screen menu that provides simplified buttons to control essential phone functions.iOS**Switch Control**Use switches as an alternate input methodsiOS**Voice Control**Control your device with your voiceiOS**AssistiveTouch**Use AssistiveTouch to replace multi-finger gestures or hardware button actions

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-11-20. [View source](https://github.com/flutter/website/blob/main/src/content/ui/accessibility/assistive-technologies.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/accessibility/assistive-technologies&page-source=https://github.com/flutter/website/blob/main/src/content/ui/accessibility/assistive-technologies.md "Report an issue with this page").