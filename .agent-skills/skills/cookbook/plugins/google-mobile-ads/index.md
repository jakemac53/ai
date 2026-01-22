---
name: add-ads-to-your-mobile-flutter-app-or-game
description: How to use the google_mobile_ads package to show ads in Flutter.
metadata:
  url: https://docs.flutter.dev/cookbook/plugins/google-mobile-ads
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Add ads to your mobile Flutter app or game

Many developers use advertising to monetize their mobile apps and games.
This allows their app to be downloaded free of charge,
which improves the app's popularity.


![An illustration of a smartphone showing an ad](/assets/images/docs/cookbook/ads-device.jpg)

To add ads to your Flutter project, use
[AdMob](https://admob.google.com/home/),
Google's mobile advertising platform.
This recipe demonstrates how to use the
[`google_mobile_ads`](https://pub.dev/packages/google_mobile_ads)

package to add a banner ad to your app or game.


infoNote

Apart from AdMob, the `google_mobile_ads` package also supports
Ad Manager, a platform intended for large publishers. Integrating Ad
Manager resembles integrating AdMob, but it won't be covered in this
cookbook recipe. To use Ad Manager, follow the
[Ad Manager documentation](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start).


## 1\. Get AdMob App IDs

[#](#1-get-admob-app-ids)

1. Go to [AdMob](https://admob.google.com/) and set up an
    account. This could take some time because you need to provide
    banking information, sign contracts, and so on.

2. With the AdMob account ready, create two _Apps_ in AdMob: one for
    Android and one for iOS.

3. Open the **App settings** section.

4. Get the AdMob _App IDs_ for both the Android app and the iOS app.
    They resemble `ca-app-pub-1234567890123456~1234567890`. Note the
    tilde ( `~`) between the two numbers.

   ![Screenshot from AdMob showing the location of the App ID](/assets/images/docs/cookbook/ads-app-id.png)


## 2\. Platform-specific setup

[#](#2-platform-specific-setup)

Update your Android and iOS configurations to include your App IDs.

### Android

[#](#android)

Add your AdMob app ID to your Android app.

1. Open the app's `android/app/src/main/AndroidManifest.xml` file.

2. Add a new `<meta-data>` tag.

3. Set the `android:name` element with a value of
    `com.google.android.gms.ads.APPLICATION_ID`.

4. Set the `android:value` element with the value to your own AdMob app
    ID that you got in the previous step.
    Include them in quotes as shown:



   xml

   ```
   <manifest>
       <application>
           ...
   ​
           <!-- Sample AdMob app ID: ca-app-pub-3940256099942544~3347511713 -->
           <meta-data
               android:name="com.google.android.gms.ads.APPLICATION_ID"
               android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
       </application>
   </manifest>

   ```

   content\_copy


### iOS

[#](#ios)

Add your AdMob app ID to your iOS app.

1. Open your app's `ios/Runner/Info.plist` file.

2. Enclose `GADApplicationIdentifier` with a `key` tag.

3. Enclose your AdMob app ID with a `string` tag. You created this AdMob
    App ID in [step 1](#1-get-admob-app-ids).



   xml

   ```
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-################~##########</string>

   ```

   content\_copy


## 3\. Add the `google_mobile_ads` plugin

[#](#3-add-the-google-mobile-ads-plugin)

To add the `google_mobile_ads` plugin as a dependency, run
`flutter pub add`:


```
$ flutter pub add google_mobile_ads

```

content\_copy

infoNote

Once you add the plugin, your Android app might fail to build with a
`DexArchiveMergerException`:


```
Error while merging dex archives:
The number of method references in a .dex file cannot exceed 64K.

```

content\_copy

To resolve this, execute the `flutter run` command in the terminal, not
through an IDE plugin. The `flutter` tool can detect the issue and ask
whether it should try to solve it. Answer `y`, and the problem goes away.
You can return to running your app from an IDE after that.


![Screenshot of the flutter tool asking about multidex support](/assets/images/docs/cookbook/ads-multidex.png)

## 4\. Initialize the Mobile Ads SDK

[#](#4-initialize-the-mobile-ads-sdk)

You need to initialize the Mobile Ads SDK before loading ads.

1. Call `MobileAds.instance.initialize()` to initialize the Mobile Ads
    SDK.



   dart

   ```
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     unawaited(MobileAds.instance.initialize());
   ​
     runApp(const MyApp());
   }

   ```

   content\_copy


Run the initialization step at startup, as shown above,
so that the AdMob SDK has enough time to initialize before it is needed.


infoNote

`MobileAds.instance.initialize()` returns a `Future` but, the
way the SDK is built, you don't need to `await` it.
If you try to load an ad before that `Future` is completed,
the SDK will gracefully wait until the initialization, and _then_ load the ad.
You can await the `Future`
if you want to know the exact time when the AdMob SDK is ready.


## 5\. Load a banner ad

[#](#5-load-a-banner-ad)

To show an ad, you need to request it from AdMob.

To load a banner ad, construct a `BannerAd` instance, and
call `load()` on it.


infoNote

The following code snippet refers to fields such a `adSize`, `adUnitId`
and `_bannerAd`. This will all make more sense in a later step.


dart

```
/// Loads a banner ad.
void _loadAd() {
  final bannerAd = BannerAd(
    size: widget.adSize,
    adUnitId: widget.adUnitId,
    request: const AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        if (!mounted) {
          ad.dispose();
          return;
        }
        setState(() {
          _bannerAd = ad as BannerAd;
        });
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (ad, error) {
        debugPrint('BannerAd failed to load: $error');
        ad.dispose();
      },
    ),
  );
​
  // Start loading.
  bannerAd.load();
}

```

content\_copy

To view a complete example, check out the last step of this recipe.

## 6\. Show banner ad

[#](#6-show-banner-ad)

Once you have a loaded instance of `BannerAd`, use `AdWidget` to show it.

dart

```
AdWidget(ad: _bannerAd)

```

content\_copy

It's a good idea to wrap the widget in a `SafeArea` (so that no part of
the ad is obstructed by device notches) and a `SizedBox` (so that it has
its specified, constant size before and after loading).


dart

```
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: SizedBox(
      width: widget.adSize.width.toDouble(),
      height: widget.adSize.height.toDouble(),
      child: _bannerAd == null
          // Nothing to render yet.
          ? const SizedBox()
          // The actual ad.
          : AdWidget(ad: _bannerAd!),
    ),
  );
}

```

content\_copy

You must dispose of an ad when you no longer need to access it. The best
practice for when to call `dispose()` is either after the `AdWidget`
is
removed from the widget tree or in the
`BannerAdListener.onAdFailedToLoad()` callback.


dart

```
_bannerAd?.dispose();

```

content\_copy

## 7\. Configure ads

[#](#7-configure-ads)

To show anything beyond test ads, you have to register ad units.

1. Open [AdMob](https://admob.google.com/).

2. Create an _Ad unit_ for each of the AdMob apps.

   ![Screenshot of the location of Ad Units in AdMob web UI](/assets/images/docs/cookbook/ads-ad-unit.png)

   This asks for the Ad unit's format. AdMob provides many formats
    beyond banner ads --- interstitials, rewarded ads, app open ads, and
    so on.
    The API for those is similar, and documented in the
    [AdMob documentation](https://developers.google.com/admob/flutter/quick-start)

    and through
    [official samples](https://github.com/googleads/googleads-mobile-flutter/tree/main/samples/admob).

3. Choose banner ads.

4. Get the _Ad unit IDs_ for both the Android app and the iOS app.
    You can find these in the **Ad units** section. They look something
    like `ca-app-pub-1234567890123456/1234567890`. The format resembles
    the _App ID_ but with a slash ( `/`) between the two numbers. This
    distinguishes an _Ad unit ID_ from an _App ID_.

   ![Screenshot of an Ad Unit ID in AdMob web UI](/assets/images/docs/cookbook/ads-ad-unit-id.png)

5. Add these _Ad unit IDs_ to the constructor of `BannerAd`,
    depending on the target app platform.



   dart

   ```
   final String adUnitId = Platform.isAndroid
       // Use this ad unit on Android...
       ? 'ca-app-pub-3940256099942544/6300978111'
       // ... or this one on iOS.
       : 'ca-app-pub-3940256099942544/2934735716';

   ```

   content\_copy


## 8\. Final touches

[#](#8-final-touches)

To display the ads in a published app or game (as opposed to debug or
testing scenarios), your app must meet additional requirements:


1. Your app must be reviewed and approved before it can fully serve
    ads.
    Follow AdMob's [app readiness guidelines](https://support.google.com/admob/answer/10564477).
    For example, your app must be listed on at least one of the
    supported stores such as Google Play Store or Apple App Store.

2. You must [create an `app-ads.txt`](https://support.google.com/admob/answer/9363762)

    file and publish it on your developer website.


![An illustration of a smartphone showing an ad](/assets/images/docs/cookbook/ads-device.jpg)

To learn more about app and game monetization,
visit the official sites
of [AdMob](https://admob.google.com/)
and [Ad Manager](https://admanager.google.com/).


## 9\. Complete example

[#](#9-complete-example)

The following code implements a simple stateful widget that loads a
banner ad and shows it.


dart

```
import 'dart:io';
​
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
​
class MyBannerAdWidget extends StatefulWidget {
  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;
​
  /// The AdMob ad unit to show.
  ///
  /// TODO: replace this test ad unit with your own ad unit
  final String adUnitId = Platform.isAndroid
      // Use this ad unit on Android...
      ? 'ca-app-pub-3940256099942544/6300978111'
      // ... or this one on iOS.
      : 'ca-app-pub-3940256099942544/2934735716';
​
  MyBannerAdWidget({super.key, this.adSize = AdSize.banner});
​
  @override
  State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
}
​
class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;
​
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null
            // Nothing to render yet.
            ? const SizedBox()
            // The actual ad.
            : AdWidget(ad: _bannerAd!),
      ),
    );
  }
​
  @override
  void initState() {
    super.initState();
    _loadAd();
  }
​
  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
​
  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );
​
    // Start loading.
    bannerAd.load();
  }
​
}

```

content\_copy

lightbulbTip

In many cases, you will want to load the ad _outside_ a widget.

For example, you can load it in a `ChangeNotifier`, a BLoC, a controller,
or whatever else you are using for app-level state. This way, you can
preload a banner ad in advance, and have it ready to show for when the
user navigates to a new screen.


Verify that you have loaded the `BannerAd` instance before showing it with
an `AdWidget`, and that you dispose of the instance when it is no longer
needed.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/plugins/google-mobile-ads.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/plugins/google-mobile-ads&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/plugins/google-mobile-ads.md "Report an issue with this page").