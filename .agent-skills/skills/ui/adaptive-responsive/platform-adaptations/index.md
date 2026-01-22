---
name: automatic-platform-adaptations
description: Learn more about Flutter's platform adaptiveness.
metadata:
  url: https://docs.flutter.dev/ui/adaptive-responsive/platform-adaptations
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Automatic platform adaptations

## Adaptation philosophy

[#](#adaptation-philosophy)

In general, two cases of platform adaptiveness exist:

1. Things that are behaviors of the OS environment
    (such as text editing and scrolling) and that
    would be 'wrong' if a different behavior took place.

2. Things that are conventionally implemented in apps using
    the OEM's SDKs (such as using parallel tabs on iOS or
    showing an [`android.app.AlertDialog`](https://developer.android.com/reference/android/app/AlertDialog.html)
    on Android).


This article mainly covers the automatic adaptations
provided by Flutter in case 1 on Android and iOS.


For case 2, Flutter bundles the means to produce the
appropriate effects of the platform conventions but doesn't
adapt automatically when app design choices are needed.
For a discussion, see [issue #8410](https://github.com/flutter/flutter/issues/8410#issuecomment-468034023)
and the
[Material/Cupertino adaptive widget problem definition](https://bit.ly/flutter-adaptive-widget-problem).


For an example of an app using different information
architecture structures on Android and iOS but sharing
the same content code, see the [platform\_design code samples](https://github.com/flutter/samples/tree/main/platform_design).


Preliminary guides addressing case 2
are being added to the UI components section.
You can request additional guides by commenting on [issue #8427](https://github.com/flutter/website/issues/8427).


## Page navigation

[#](#page-navigation)

Flutter provides the navigation patterns seen on Android
and iOS and also automatically adapts the navigation animation
to the current platform.


### Navigation transitions

[#](#navigation-transitions)

On **Android**, the default [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)
transition
is modeled after [`startActivity()`](https://developer.android.com/reference/kotlin/android/app/Activity#startactivity),
which generally has one bottom-up animation variant.


On **iOS**:

- The default [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)
   API produces an
   iOS Show/Push style transition that animates from
   end-to-start depending on the locale's RTL setting.
   The page behind the new route also parallax-slides
   in the same direction as in iOS.

- A separate bottom-up transition style exists when
   pushing a page route where [`PageRoute.fullscreenDialog`](https://api.flutter.dev/flutter/widgets/PageRoute-class.html)

   is true. This represents iOS's Present/Modal style
   transition and is typically used on fullscreen modal pages.


![An animation of the bottom-up page transition on Android](/assets/images/docs/platform-adaptations/navigation-android.webp)

Android page transition

![An animation of the end-start style push page transition on iOS](/assets/images/docs/platform-adaptations/navigation-ios.webp)

iOS push transition

![An animation of the bottom-up style present page transition on iOS](/assets/images/docs/platform-adaptations/navigation-ios-modal.webp)

iOS present transition

### Platform-specific transition details

[#](#platform-specific-transition-details)

On **Android**, Flutter uses the [`ZoomPageTransitionsBuilder`](https://api.flutter.dev/flutter/material/ZoomPageTransitionsBuilder-class.html)
animation.
When the user taps on an item, the UI zooms in to a screen that features that item.
When the user taps to go back, the UI zooms out to the previous screen.


On **iOS** when the push style transition is used,
Flutter's bundled [`CupertinoNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoNavigationBar-class.html)

and [`CupertinoSliverNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar-class.html)
nav bars
automatically animate each subcomponent to its corresponding
subcomponent on the next or previous page's
`CupertinoNavigationBar` or `CupertinoSliverNavigationBar`.


![An animation of the page transition on Android](/assets/images/docs/platform-adaptations/android-zoom-animation.png)

Android

![An animation of the nav bar transitions during a page transition on iOS](/assets/images/docs/platform-adaptations/navigation-ios-nav-bar.webp)

iOS Nav Bar

### Back navigation

[#](#back-navigation)

On **Android**,
the OS back button, by default, is sent to Flutter
and pops the top route of the [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html)'s Navigator.


On **iOS**,
an edge swipe gesture can be used to pop the top route.


![A page transition triggered by the Android back button](/assets/images/docs/platform-adaptations/navigation-android-back.webp)

Android back button

![A page transition triggered by an iOS back swipe gesture](/assets/images/docs/platform-adaptations/navigation-ios-back.webp)

iOS back swipe gesture

## Scrolling

[#](#scrolling)

Scrolling is an important part of the platform's
look and feel, and Flutter automatically adjusts
the scrolling behavior to match the current platform.


### Physics simulation

[#](#physics-simulation)

Android and iOS both have complex scrolling physics
simulations that are difficult to describe verbally.
Generally, iOS's scrollable has more weight and
dynamic friction but Android has more static friction.
Therefore iOS gains high speed more gradually but stops
less abruptly and is more slippery at slow speeds.


![A soft fling where the iOS scrollable slid longer at lower speed than Android](/assets/images/docs/platform-adaptations/scroll-soft.webp)

Soft fling comparison

![A medium force fling where the Android scrollable reaches speed faster and stopped more abruptly after reaching a longer distance](/assets/images/docs/platform-adaptations/scroll-medium.webp)

Medium fling comparison

![A strong fling where the Android scrollable reaches speed faster and covered significantly more distance](/assets/images/docs/platform-adaptations/scroll-strong.webp)

Strong fling comparison

### Overscroll behavior

[#](#overscroll-behavior)

On **Android**,
scrolling past the edge of a scrollable shows an
[overscroll glow indicator](https://api.flutter.dev/flutter/widgets/GlowingOverscrollIndicator-class.html)
(based on the color
of the current Material theme).


On **iOS**, scrolling past the edge of a scrollable
[overscrolls](https://api.flutter.dev/flutter/widgets/BouncingScrollPhysics-class.html)
with increasing resistance and snaps back.


![Android and iOS scrollables being flung past their edge and exhibiting platform specific overscroll behavior](/assets/images/docs/platform-adaptations/scroll-overscroll.webp)

Dynamic overscroll comparison

![Android and iOS scrollables being overscrolled from a resting position and exhibiting platform specific overscroll behavior](/assets/images/docs/platform-adaptations/scroll-static-overscroll.webp)

Static overscroll comparison

### Scrollbars

[#](#scrollbars)

On **Material-based platforms** (such as Android and web),
scrollbars are typically visible during scrolling
and may remain visible depending on the platform and theme.


On **Cupertino-based platforms** (such as iOS),
scrollbars are more minimal and generally only appear briefly
while the user is actively scrolling, fading out when interaction stops.


This difference reflects each platform’s visual conventions
and helps maintain a native look and feel across devices.


### Momentum

[#](#momentum)

On **iOS**,
repeated flings in the same direction stacks momentum
and builds more speed with each successive fling.
There is no equivalent behavior on Android.


![Repeated scroll flings building momentum on iOS](/assets/images/docs/platform-adaptations/scroll-momentum-ios.webp)

iOS scroll momentum

### Return to top

[#](#return-to-top)

On **iOS**,
tapping the OS status bar scrolls the primary
scroll controller to the top position.
There is no equivalent behavior on Android.


![Tapping the status bar scrolls the primary scrollable back to the top](/assets/images/docs/platform-adaptations/scroll-tap-to-top-ios.webp)

iOS status bar tap to top

## Typography

[#](#typography)

When using the Material package,
the typography automatically defaults to the
font family appropriate for the platform.
Android uses the Roboto font.
iOS uses the San Francisco font.


When using the Cupertino package, the [default theme](https://github.com/flutter/flutter/blob/main/packages/flutter/lib/src/cupertino/text_theme.dart)

uses the San Francisco font.


The San Francisco font license limits its usage to
software running on iOS, macOS, or tvOS only.
Therefore a fallback font is used when running on Android
if the platform is debug-overridden to iOS or the
default Cupertino theme is used.


You might choose to adapt the text styling of Material
widgets to match the default text styling on iOS.
You can see widget-specific examples in the
[UI Component section](#ui-components).


![Roboto font typography scale on Android](/assets/images/docs/platform-adaptations/typography-android.png)

Roboto on Android

![San Francisco typography scale on iOS](/assets/images/docs/platform-adaptations/typography-ios.png)

San Francisco on iOS

## Iconography

[#](#iconography)

When using the Material package,
certain icons automatically show different
graphics depending on the platform.
For instance, the overflow button's three dots
are horizontal on iOS and vertical on Android.
The back button is a simple chevron on iOS and
has a stem/shaft on Android.


![Android appropriate icons](/assets/images/docs/platform-adaptations/iconography-android.png)

Icons on Android

![iOS appropriate icons](/assets/images/docs/platform-adaptations/iconography-ios.png)

Icons on iOS

The material library also provides a set of
platform-adaptive icons through [`Icons.adaptive`](https://api.flutter.dev/flutter/material/PlatformAdaptiveIcons-class.html).


## Haptic feedback

[#](#haptic-feedback)

The Material and Cupertino packages automatically
trigger the platform appropriate haptic feedback in
certain scenarios.


For instance,
a word selection via text field long-press triggers a 'buzz'
vibrate on Android and not on iOS.


Scrolling through picker items on iOS triggers a
'light impact' knock and no feedback on Android.


## Text editing

[#](#text-editing)

Both the Material and Cupertino Text Input fields
support spellcheck and adapt to use the proper
spellcheck configuration for the platform,
and the proper spell check menu and highlight colors.


Flutter also makes the below adaptations while editing
the content of text fields to match the current platform.


### Keyboard gesture navigation

[#](#keyboard-gesture-navigation)

On **Android**,
horizontal swipes can be made on the soft keyboard's `space` key
to move the cursor in Material and Cupertino text fields.


On **iOS** devices with 3D Touch capabilities,
a force-press-drag gesture could be made on the soft
keyboard to move the cursor in 2D via a floating cursor.
This works on both Material and Cupertino text fields.


![Moving the cursor via the space key on Android](/assets/images/docs/platform-adaptations/text-keyboard-move-android.webp)

Android space key cursor move

![Moving the cursor via 3D Touch drag on the keyboard on iOS](/assets/images/docs/platform-adaptations/text-keyboard-move-ios.webp)

iOS 3D Touch drag cursor move

### Text selection toolbar

[#](#text-selection-toolbar)

With **Material on Android**,
the Android style selection toolbar is shown when
a text selection is made in a text field.


With **Material on iOS** or when using **Cupertino**,
the iOS style selection toolbar is shown when a text
selection is made in a text field.


![Android appropriate text toolbar](/assets/images/docs/platform-adaptations/text-toolbar-android.png)

Android text selection toolbar

![iOS appropriate text toolbar](/assets/images/docs/platform-adaptations/text-toolbar-ios.png)

iOS text selection toolbar

### Single tap gesture

[#](#single-tap-gesture)

With **Material on Android**,
a single tap in a text field puts the cursor at the
location of the tap.


A collapsed text selection also shows a draggable
handle to subsequently move the cursor.


With **Material on iOS** or when using **Cupertino**,
a single tap in a text field puts the cursor at the
nearest edge of the word tapped.


Collapsed text selections don't have draggable handles on iOS.

![Moving the cursor to the tapped position on Android](/assets/images/docs/platform-adaptations/text-single-tap-android.webp)

Android tap

![Moving the cursor to the nearest edge of the tapped word on iOS](/assets/images/docs/platform-adaptations/text-single-tap-ios.webp)

iOS tap

### Long-press gesture

[#](#long-press-gesture)

With **Material on Android**,
a long press selects the word under the long press.
The selection toolbar is shown upon release.


With **Material on iOS** or when using **Cupertino**,
a long press places the cursor at the location of the
long press. The selection toolbar is shown upon release.


![Selecting a word with long press on Android](/assets/images/docs/platform-adaptations/text-long-press-android.webp)

Android long press

![Selecting a position with long press on iOS](/assets/images/docs/platform-adaptations/text-long-press-ios.webp)

iOS long press

### Long-press drag gesture

[#](#long-press-drag-gesture)

With **Material on Android**,
dragging while holding the long press expands the words selected.


With **Material on iOS** or when using **Cupertino**,
dragging while holding the long press moves the cursor.


![Expanding word selection with a long-press drag on Android](/assets/images/docs/platform-adaptations/text-long-press-drag-android.webp)

Android long-press drag

![Moving the cursor with a long-press drag on iOS](/assets/images/docs/platform-adaptations/text-long-press-drag-ios.webp)

iOS long-press drag

### Double tap gesture

[#](#double-tap-gesture)

On both Android and iOS,
a double tap selects the word receiving the
double tap and shows the selection toolbar.


![Selecting a word via double tap on Android](/assets/images/docs/platform-adaptations/text-double-tap-android.webp)

Android double tap

![Selecting a word via double tap on iOS](/assets/images/docs/platform-adaptations/text-double-tap-ios.webp)

iOS double tap

## UI components

[#](#ui-components)

This section includes preliminary recommendations on how to adapt
Material widgets to deliver a natural and compelling experience on iOS.
Your feedback is welcomed on [issue #8427](https://github.com/flutter/website/issues/8427).


### Widgets with .adaptive() constructors

[#](#widgets-with-adaptive-constructors)

Several widgets support `.adaptive()` constructors.
The following table lists these widgets.
Adaptive constructors substitute the corresponding Cupertino components
when the app is run on an iOS device.


Widgets in the following table are used primarily for input,
selection, and to display system information.
Because these controls are tightly integrated with the operating system,
users have been trained to recognize and respond to them.
Therefore, we recommend that you follow platform conventions.


Material widgetCupertino widgetAdaptive constructor![Switch in Material 3](/assets/images/docs/platform-adaptations/m3-switch.png)

`Switch`![Switch in HIG](/assets/images/docs/platform-adaptations/hig-switch.png)

`CupertinoSwitch`[`Switch.adaptive()`](https://api.flutter.dev/flutter/material/Switch/Switch.adaptive.html)![Slider in Material 3](/assets/images/docs/platform-adaptations/m3-slider.png)

`Slider`![Slider in HIG](/assets/images/docs/platform-adaptations/hig-slider.png)

`CupertinoSlider`[`Slider.adaptive()`](https://api.flutter.dev/flutter/material/Slider/Slider.adaptive.html)![Circular progress indicator in Material 3](/assets/images/docs/platform-adaptations/m3-progress.png)

`CircularProgressIndicator`![Activity indicator in HIG](/assets/images/docs/platform-adaptations/hig-progress.png)

`CupertinoActivityIndicator`[`CircularProgressIndicator.adaptive()`](https://api.flutter.dev/flutter/material/CircularProgressIndicator/CircularProgressIndicator.adaptive.html)![Refresh indicator in Material 3](/assets/images/docs/platform-adaptations/m3-refresh.png)

`RefreshProgressIndicator`![Refresh indicator in HIG](/assets/images/docs/platform-adaptations/hig-refresh.png)

`CupertinoActivityIndicator`[`RefreshIndicator.adaptive()`](https://api.flutter.dev/flutter/material/RefreshIndicator/RefreshIndicator.adaptive.html)![ Checkbox in Material 3](/assets/images/docs/platform-adaptations/m3-checkbox.png)

`Checkbox`![Checkbox in HIG](/assets/images/docs/platform-adaptations/hig-checkbox.png)

`CupertinoCheckbox`[`Checkbox.adaptive()`](https://api.flutter.dev/flutter/material/Checkbox/Checkbox.adaptive.html)![Radio in Material 3](/assets/images/docs/platform-adaptations/m3-radio.png)

`Radio`![Radio in HIG](/assets/images/docs/platform-adaptations/hig-radio.png)

`CupertinoRadio`[`Radio.adaptive()`](https://api.flutter.dev/flutter/material/Radio/Radio.adaptive.html)![AlertDialog in Material 3](/assets/images/docs/platform-adaptations/m3-alert.png)

`AlertDialog`![AlertDialog in HIG](/assets/images/docs/platform-adaptations/cupertino-alert.png)

`CupertinoAlertDialog`[`AlertDialog.adaptive()`](https://api.flutter.dev/flutter/material/AlertDialog/AlertDialog.adaptive.html)

### Top app bar and navigation bar

[#](#top-app-bar-and-navigation-bar)

Since Android 12, the default UI for top app
bars follows the design guidelines defined in [Material 3](https://m3.material.io/components/top-app-bar/overview).
On iOS, an equivalent component called "Navigation Bars"
is defined in [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/navigation-bars/)
(HIG).


![Top App Bar in Material 3](/assets/images/docs/platform-adaptations/mat-appbar.png)

Top App Bar in Material 3

![Navigation Bar in Human Interface Guidelines](/assets/images/docs/platform-adaptations/hig-appbar.png)

Navigation Bar in Human Interface Guidelines

Certain properties of app bars in Flutter apps should be adapted,
like system icons and page transitions.
These are already automatically adapted when using
the Material `AppBar` and `SliverAppBar` widgets.
You can also further customize the properties of these widgets to better
match iOS platform styles, as shown below.


dart

```
// Map the text theme to iOS styles
TextTheme cupertinoTextTheme = TextTheme(
    headlineMedium: CupertinoThemeData()
        .textTheme
        .navLargeTitleTextStyle
         // fixes a small bug with spacing
        .copyWith(letterSpacing: -1.5),
    titleLarge: CupertinoThemeData().textTheme.navTitleTextStyle)
...
​
// Use iOS text theme on iOS devices
ThemeData(
      textTheme: Platform.isIOS ? cupertinoTextTheme : null,
      ...
)
...
​
// Modify AppBar properties
AppBar(
        surfaceTintColor: Platform.isIOS ? Colors.transparent : null,
        shadowColor: Platform.isIOS ? CupertinoColors.darkBackgroundGray : null,
        scrolledUnderElevation: Platform.isIOS ? .1 : null,
        toolbarHeight: Platform.isIOS ? 44 : null,
        ...
      ),

```

content\_copy

But, because app bars are displayed alongside
other content in your page, it's only recommended to adapt the styling
so long as it's cohesive with the rest of your application. You can see
additional code samples and a further explanation in
[the GitHub discussion on app bar adaptations](https://github.com/flutter/uxr/discussions/93).


### Bottom navigation bars

[#](#bottom-navigation-bars)

Since Android 12, the default UI for bottom navigation
bars follow the design guidelines defined in [Material 3](https://m3.material.io/components/navigation-bar/overview).
On iOS, an equivalent component called "Tab Bars"
is defined in [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/tab-bars/)
(HIG).


![Bottom Navigation Bar in Material 3](/assets/images/docs/platform-adaptations/mat-navbar.png)

Bottom Navigation Bar in Material 3

![Tab Bar in Human Interface Guidelines](/assets/images/docs/platform-adaptations/hig-tabbar.png)

Tab Bar in Human Interface Guidelines

Since tab bars are persistent across your app, they should match your
own branding. However, if you choose to use Material's default
styling on Android, you might consider adapting to the default iOS
tab bars.


To implement platform-specific bottom navigation bars,
you can use Flutter's `NavigationBar` widget on Android
and the `CupertinoTabBar` widget on iOS.
Below is a code snippet you can
adapt to show a platform-specific navigation bars.


dart

```
final Map<String, Icon> _navigationItems = {
    'Menu': Platform.isIOS ? Icon(CupertinoIcons.house_fill) : Icon(Icons.home),
    'Order': Icon(Icons.adaptive.share),
  };
​
...
​
Scaffold(
  body: _currentWidget,
  bottomNavigationBar: Platform.isIOS
          ? CupertinoTabBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
                _loadScreen();
              },
              items: _navigationItems.entries
                  .map<BottomNavigationBarItem>(
                      (entry) => BottomNavigationBarItem(
                            icon: entry.value,
                            label: entry.key,
                          ))
                  .toList(),
            )
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
                _loadScreen();
              },
              destinations: _navigationItems.entries
                  .map<Widget>((entry) => NavigationDestination(
                        icon: entry.value,
                        label: entry.key,
                      ))
                  .toList(),
            ));

```

content\_copy

### Text fields

[#](#text-fields)

Since Android 12, text fields follow the
[Material 3](https://m3.material.io/components/text-fields/overview) (M3) design guidelines.
On iOS, Apple's [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/text-fields)
(HIG) define
an equivalent component.


![Text Field in Material 3](/assets/images/docs/platform-adaptations/m3-text-field.png)

Text Field in Material 3

![Text Field in Human Interface Guidelines](/assets/images/docs/platform-adaptations/hig-text-field.png)

Text Field in HIG

Since text fields require user input,
their design should follow platform conventions.


To implement a platform-specific `TextField`
in Flutter, you can adapt the styling of the
Material `TextField`.


dart

```
Widget _createAdaptiveTextField() {
  final _border = OutlineInputBorder(
    borderSide: BorderSide(color: CupertinoColors.lightBackgroundGray),
  );
​
  final iOSDecoration = InputDecoration(
    border: _border,
    enabledBorder: _border,
    focusedBorder: _border,
    filled: true,
    fillColor: CupertinoColors.white,
    hoverColor: CupertinoColors.white,
    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  );
​
  return Platform.isIOS
      ? SizedBox(
          height: 36.0,
          child: TextField(
            decoration: iOSDecoration,
          ),
        )
      : TextField();
}

```

content\_copy

To learn more about adapting text fields, check out
[the GitHub discussion on text fields](https://github.com/flutter/uxr/discussions/95).
You can leave feedback or ask questions in the discussion.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-8. [View source](https://github.com/flutter/website/blob/main/src/content/ui/adaptive-responsive/platform-adaptations.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/adaptive-responsive/platform-adaptations&page-source=https://github.com/flutter/website/blob/main/src/content/ui/adaptive-responsive/platform-adaptations.md "Report an issue with this page").