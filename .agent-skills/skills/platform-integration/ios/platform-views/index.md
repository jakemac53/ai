---
name: host-native-ios-views-in-your-flutter-app-with-platform-views
description: Learn how to host native iOS views in your Flutter app with platform views.
metadata:
  url: https://docs.flutter.dev/platform-integration/ios/platform-views
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Host native iOS views in your Flutter app with platform views

Platform views allow you to embed native views in a Flutter app,
so you can apply transforms, clips, and opacity to the native view
from Dart.


This allows you, for example, to use the native
Google Maps from the Android and iOS SDKs
directly inside your Flutter app.


infoNote

This page discusses how to host your own native iOS views
within a Flutter app.
If you'd like to embed native Android views in your Flutter app,
see [Hosting native Android views](/platform-integration/android/platform-views).
If you'd like to embed native macOS views in your Flutter app,
see [Hosting native macOS views](/platform-integration/macos/platform-views).


iOS only uses Hybrid composition,
which means that the native
`UIView` is appended to the view hierarchy.


To create a platform view on iOS,
use the following instructions:


## On the Dart side

[#](#on-the-dart-side)

On the Dart side, create a `Widget`
and add the build implementation,
as shown in the following steps.


In the Dart widget file, make changes similar to those
shown in `native_view_example.dart`:


1. Add the following imports:



   dart

   ```
   import 'package:flutter/foundation.dart';
   import 'package:flutter/services.dart';

   ```

   content\_copy

2. Implement a `build()` method:



   dart

   ```
   Widget build(BuildContext context) {
     // This is used in the platform side to register the view.
     const String viewType = '<platform-view-type>';
     // Pass parameters to the platform side.
     final Map<String, dynamic> creationParams = <String, dynamic>{};
   ​
     return UiKitView(
       viewType: viewType,
       layoutDirection: TextDirection.ltr,
       creationParams: creationParams,
       creationParamsCodec: const StandardMessageCodec(),
     );
   }

   ```

   content\_copy


For more information, see the API docs for:
[`UIKitView`](https://api.flutter.dev/flutter/widgets/UiKitView-class.html).


## On the platform side

[#](#on-the-platform-side)

On the platform side, use either Swift or Objective-C:

- [Swift](#178-tab-panel)
- [Objective-C](#179-tab-panel)

Implement the factory and the platform view.
The `FLNativeViewFactory` creates the platform view,
and the platform view provides a reference to the `UIView`.
For example, `FLNativeView.swift`:


swift

```
import Flutter
import UIKit
​
class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
​
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
​
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
​
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}
​
class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
​
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }
​
    func view() -> UIView {
        return _view
    }
​
    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }
}

```

content\_copy

Finally, register the platform view.
This can be done in an app or a plugin.


For app registration,
modify the App's `AppDelegate.swift`:


swift

```
import Flutter
import UIKit
​
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
​
        guard let pluginRegistrar = self.registrar(forPlugin: "plugin-name") else { return false }
​
        let factory = FLNativeViewFactory(messenger: pluginRegistrar.messenger())
        pluginRegistrar.register(
            factory,
            withId: "<platform-view-type>")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

```

content\_copy

For plugin registration,
modify the plugin's main file
(for example, `FLPlugin.swift`):


swift

```
import Flutter
import UIKit
​
class FLPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "<platform-view-type>")
    }
}

```

content\_copy

In Objective-C, add the headers for the factory and the platform view.
For example, as shown in `FLNativeView.h`:


objc

```
#import <Flutter/Flutter.h>
​
@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
​
@interface FLNativeView : NSObject <FlutterPlatformView>
​
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
​
- (UIView*)view;
@end

```

content\_copy

Implement the factory and the platform view.
The `FLNativeViewFactory` creates the platform view,
and the platform view provides a reference to the
`UIView`. For example, `FLNativeView.m`:


objc

```
#import "FLNativeView.h"
​
@implementation FLNativeViewFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}
​
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}
​
- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FLNativeView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                             binaryMessenger:_messenger];
}
​
/// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}
​
@end
​
@implementation FLNativeView {
   UIView *_view;
}
​
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _view = [[UIView alloc] init];
  }
  return self;
}
​
- (UIView*)view {
  return _view;
}
​
@end

```

content\_copy

Finally, register the platform view.
This can be done in an app or a plugin.


For app registration,
modify the App's `AppDelegate.m`:


objc

```
#import "AppDelegate.h"
#import "FLNativeView.h"
#import "GeneratedPluginRegistrant.h"
​
@implementation AppDelegate
​
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
​
   NSObject<FlutterPluginRegistrar>* registrar =
      [self registrarForPlugin:@"plugin-name"];
​
  FLNativeViewFactory* factory =
      [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];
​
  [[self registrarForPlugin:@"<plugin-name>"] registerViewFactory:factory
                                                          withId:@"<platform-view-type>"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
​
@end

```

content\_copy

For plugin registration,
modify the main plugin file
(for example, `FLPlugin.m`):


objc

```
#import <Flutter/Flutter.h>
#import "FLNativeView.h"
​
@interface FLPlugin : NSObject<FlutterPlugin>
@end
​
@implementation FLPlugin
​
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FLNativeViewFactory* factory =
      [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:factory withId:@"<platform-view-type>"];
}
​
@end

```

content\_copy

For more information, see the API docs for:

- [`FlutterPlatformViewFactory`](https://api.flutter.dev/ios-embedder/protocol_flutter_platform_view_factory-p.html)
- [`FlutterPlatformView`](https://api.flutter.dev/ios-embedder/protocol_flutter_platform_view-p.html)
- [`PlatformView`](https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformView.html)

## Putting it together

[#](#putting-it-together)

When implementing the `build()` method in Dart,
you can use [`defaultTargetPlatform`](https://api.flutter.dev/flutter/foundation/defaultTargetPlatform.html)

to detect the platform, and decide which widget to use:


dart

```
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};
​
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    // return widget on Android.
    case TargetPlatform.iOS:
    // return widget on iOS.
    case TargetPlatform.macOS:
    // return widget on macOS.
    default:
      throw UnsupportedError('Unsupported platform view');
  }
}

```

content\_copy

## Performance

[#](#performance)

Platform views in Flutter come with performance trade-offs.

For complex cases, there are some techniques that can be used
to mitigate performance issues.


For example, you could use a placeholder texture while an
animation is happening in Dart.
In other words, if an animation is slow while a platform view is rendered,
then consider taking a screenshot of the native view and
rendering it as a texture.


## Composition limitations

[#](#composition-limitations)

There are some limitations when composing iOS Platform Views.

- The [`ShaderMask`](https://api.flutter.dev/flutter/foundation/ShaderMask.html) and
   [`ColorFiltered`](https://api.flutter.dev/flutter/foundation/ColorFiltered.html)
   widgets are not supported.

- The [`BackdropFilter`](https://api.flutter.dev/flutter/foundation/BackdropFilter.html)
   widget is supported,
   but there are some limitations on how it can be used.
   For more details, check out the
   [iOS Platform View Backdrop Filter Blur design doc](https://flutter.dev/go/ios-platformview-backdrop-filter-blur).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/platform-views.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/platform-integration/ios/platform-views&page-source=https://github.com/flutter/website/blob/main/src/content/platform-integration/ios/platform-views.md "Report an issue with this page").