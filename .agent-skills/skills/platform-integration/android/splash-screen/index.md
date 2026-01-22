---
name: adding-a-splash-screen-to-your-android-app
description: Learn how to add a splash screen to your Android app.
metadata:
  url: https://docs.flutter.dev/platform-integration/android/splash-screen
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Adding a splash screen to your Android app

![A graphic outlining the launch flow of an app including a splash screen](/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png)

## Overview

[#](#overview)

A splash screens (also known as a launch screen) provides
a simple initial experience while your Android app loads.
It sets the stage for your application,
while allowing time for the app engine
to load and your app to initialize.


You have a couple options for implementing a splash screen:

1. You can use one of the packages available on [pub.dev](https://pub.dev/packages?q=splash+screen).

2. You can implement it manually, as shown in the
    [splash screen sample app](https://github.com/flutter/samples/tree/main/android_splash_screen). The rest of this page
    assumes the manual approach.


## Initializing the app

[#](#initializing-the-app)

Every Android app requires initialization time while the
operating system sets up the app's process.
Android provides the concept of a [launch screen](https://developer.android.com/topic/performance/vitals/launch-time#themed)
to
display a `Drawable` while the app is initializing.


infoNote

For apps that embed one or more Flutter screens within an
existing Android app, consider
[pre-warming a `FlutterEngine`](/add-to-app/android/add-flutter-fragment#using-a-pre-warmed-flutterengine)
and reusing the
same engine throughout your app to minimize wait
time associated with initialization of the Flutter engine.


A `Drawable` is an Android graphic.
To learn how to add a `Drawable` to your
Flutter project in Android Studio,
check out [Import drawables into your project](https://developer.android.com/studio/write/resource-manager#import)\[\]
in the Android developer documentation.


The default Flutter project template includes a definition
of a launch theme and a launch background. You can customize
this by editing `styles.xml`, where you can define a theme
whose `windowBackground` is set to the
`Drawable` that should be displayed as the launch screen.


xml

```
<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowBackground">@drawable/launch_background</item>
</style>

```

content\_copy

In addition, `styles.xml` defines a _normal theme_
to be applied to `FlutterActivity` after the launch
screen is gone. The normal theme background only shows
for a very brief moment after the splash screen disappears,
and during orientation change and `Activity` restoration.
Therefore, it's recommended that the normal theme use a
solid background color that looks similar to the primary
background color of the Flutter UI.


xml

```
<style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowBackground">@drawable/normal_background</item>
</style>

```

content\_copy

## Set up the FlutterActivity in AndroidManifest.xml

[#](#set-up-the-flutteractivity-in-androidmanifest-xml)

In `AndroidManifest.xml`, set the `theme` of
`FlutterActivity` to the launch theme. Then,
add a metadata element to the desired `FlutterActivity`
to instruct Flutter to switch from the launch theme
to the normal theme at the appropriate time.


xml

```
<activity
    android:name=".MyActivity"
    android:theme="@style/LaunchTheme"
    // ...
    >
    <meta-data
        android:name="io.flutter.embedding.android.NormalTheme"
        android:resource="@style/NormalTheme"
        />
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
</activity>

```

content\_copy

The Android app now displays the desired launch screen
while the app initializes.


## SplashScreen API

[#](#splashscreen-api)

Android 12 introduced the [`SplashScreen`](https://developer.android.com/reference/android/window/SplashScreen)
API.
Use the `SplashScreen` API in your `styles.xml` file.
For example:


xml

```
<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowSplashScreenBackground">@color/bgColor</item>
    <item name="android:windowSplashScreenAnimatedIcon">@drawable/launch_background</item>
</style>

```

content\_copy

infoNote

If your Android app supports releases earlier than Android 12
_and_ post-Android 12 releases, consider using
two different resources in your `styles.xml` file.
Also, make sure that your background image is in line with
the icon guidelines. For more information,
visit [Android Splash Screens](https://developer.android.com/develop/ui/views/launch/splash-screen).


Some apps might want to continue showing the last frame of
the Android launch screen in Flutter. For example,
this preserves the illusion of a single frame
while additional loading continues in Dart.
To achieve this, the following
Android APIs might be helpful:


- [Kotlin](#168-tab-panel)
- [Java](#169-tab-panel)

MainActivity.kt

kotlin

```
import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
​
class MainActivity : FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    // Aligns the Flutter view vertically with the window.
    WindowCompat.setDecorFitsSystemWindows(getWindow(), false)
​
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
      // Disable the Android splash screen fade out animation to avoid
      // a flicker before the similar frame is drawn in Flutter.
      splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
    }
​
    super.onCreate(savedInstanceState)
  }
}

```

content\_copy

MainActivity.java

java

```
import android.os.Build;
import android.os.Bundle;
import android.window.SplashScreenView;
import androidx.core.view.WindowCompat;
import io.flutter.embedding.android.FlutterActivity;
​
public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);
​
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            getSplashScreen()
                .setOnExitAnimationListener(
                    (SplashScreenView splashScreenView) -> {
                        splashScreenView.remove();
                    });
        }
​
        super.onCreate(savedInstanceState);
    }
}

```

content\_copy

Then, you can reimplement the first frame in Flutter
that shows elements of your Android launch screen in
the same positions on screen.
For an example of this, check out the
[splash screen sample app](https://github.com/flutter/samples/tree/main/android_splash_screen).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/android/splash-screen.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/android/splash-screen&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/android/splash-screen.md "Report an issue with this page").