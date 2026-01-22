---
name: take-a-picture-using-the-camera
description: How to use a camera plugin on mobile.
metadata:
  url: https://docs.flutter.dev/cookbook/plugins/picture-using-camera
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Take a picture using the camera

Many apps require working with the device's cameras to
take photos and videos. Flutter provides the [`camera`](https://pub.dev/packages/camera)
plugin
for this purpose. The `camera` plugin provides tools to get a list of the
available cameras, display a preview coming from a specific camera,
and take photos or videos.


infoNote

The [`camera_android_camerax`](https://pub.dev/packages/camera_android_camerax)
plugin,
built on top of the [CameraX](https://developer.android.com/training/camerax)
Android library,
improves image resolution with automatic selection
of the resolution based on the device's capability.
This plugin also helps deal with _device quirks_,
defined as camera hardware that might
not work as expected.


For more information,
check out the Google I/O 2024 talk,
[Building picture perfect camera experiences in Flutter with CameraX](https://youtube.com/watch?v=d1sRCa5k2Sg&t=1s).


This recipe demonstrates how to use the `camera` plugin to display a preview,
take a photo, and display it using the following steps:


1. Add the required dependencies.
2. Get a list of the available cameras.
3. Create and initialize the `CameraController`.
4. Use a `CameraPreview` to display the camera's feed.
5. Take a picture with the `CameraController`.
6. Display the picture with an `Image` widget.

## 1\. Add the required dependencies

[#](#1-add-the-required-dependencies)

To complete this recipe, you need to add three dependencies to your app:

[`camera`](https://pub.dev/packages/camera)

Provides tools to work with the cameras on the device.

[`path_provider`](https://pub.dev/packages/path_provider)

Finds the correct paths to store images.

[`path`](https://pub.dev/packages/path)

Creates paths that work on any platform.

To add the packages as dependencies, run `flutter pub add`:

```
$ flutter pub add camera path_provider path

```

content\_copy

lightbulbTip

- For android, You must update `minSdkVersion` to 21 (or higher).

- On iOS, the following lines must be added inside
`ios/Runner/Info.plist` to the access the camera and microphone.



xml

```
<key>NSCameraUsageDescription</key>
<string>Explanation on why the camera access is needed.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Explanation on why the microphone access is needed.</string>

```

content\_copy


## 2\. Get a list of the available cameras

[#](#2-get-a-list-of-the-available-cameras)

Next, get a list of available cameras using the `camera` plugin.

dart

```
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
WidgetsFlutterBinding.ensureInitialized();
​
// Obtain a list of the available cameras on the device.
final cameras = await availableCameras();
​
// Get a specific camera from the list of available cameras.
final firstCamera = cameras.first;

```

content\_copy

## 3\. Create and initialize the `CameraController`

[#](#3-create-and-initialize-the-cameracontroller)

Once you have a camera, use the following steps to
create and initialize a `CameraController`.
This process establishes a connection to
the device's camera that allows you to control the camera
and display a preview of the camera's feed.


1. Create a `StatefulWidget` with a companion `State` class.
2. Add a variable to the `State` class to store the `CameraController`.
3. Add a variable to the `State` class to store the `Future`
    returned from `CameraController.initialize()`.

4. Create and initialize the controller in the `initState()` method.
5. Dispose of the controller in the `dispose()` method.

dart

```
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});
​
  final CameraDescription camera;
​
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}
​
class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
​
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
​
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }
​
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
​
  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Container();
  }
}

```

content\_copy

warningWarning

If you don't initialize the `CameraController`,
you _cannot_ use the camera to display a preview and take pictures.


## 4\. Use a `CameraPreview` to display the camera's feed

[#](#4-use-a-camerapreview-to-display-the-cameras-feed)

Next, use the `CameraPreview` widget from the `camera` package to
display a preview of the camera's feed.


infoRemember

You must wait until the controller has finished
initializing before working with the camera. Therefore,
you must wait for the `_initializeControllerFuture()`, created
in the previous step, to complete before showing a `CameraPreview`.


Use a [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
for exactly this purpose.


dart

```
// You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the
// controller has finished initializing.
FutureBuilder<void>(
  future: _initializeControllerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // If the Future is complete, display the preview.
      return CameraPreview(_controller);
    } else {
      // Otherwise, display a loading indicator.
      return const Center(child: CircularProgressIndicator());
    }
  },
)

```

content\_copy

## 5\. Take a picture with the `CameraController`

[#](#5-take-a-picture-with-the-cameracontroller)

You can use the `CameraController` to take pictures using the
[`takePicture()`](https://pub.dev/documentation/camera/latest/camera/CameraController/takePicture.html)
method, which returns an [`XFile`](https://pub.dev/documentation/cross_file/latest/cross_file/XFile-class.html),
a cross-platform, simplified `File` abstraction.
On both Android and IOS, the new image is stored in their
respective cache directories,
and the `path` to that location is returned in the `XFile`.


In this example, create a `FloatingActionButton` that takes a picture
using the `CameraController` when a user taps on the button.


Taking a picture requires 2 steps:

1. Ensure that the camera is initialized.
2. Use the controller to take a picture and ensure
    that it returns a `Future<XFile>`.


It is good practice to wrap these operations in a `try / catch` block in order
to handle any errors that might occur.


dart

```
FloatingActionButton(
  // Provide an onPressed callback.
  onPressed: () async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;
​
      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  },
  child: const Icon(Icons.camera_alt),
)

```

content\_copy

## 6\. Display the picture with an `Image` widget

[#](#6-display-the-picture-with-an-image-widget)

If you take the picture successfully, you can then display the saved picture
using an `Image` widget. In this case, the picture is stored as a file on
the device.


Therefore, you must provide a `File` to the `Image.file` constructor.
You can create an instance of the `File` class by passing the path created in
the previous step.


dart

```
Image.file(File('path/to/my/picture.png'));

```

content\_copy

## Complete example

[#](#complete-example)

dart

```
import 'dart:async';
import 'dart:io';
​
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
​
Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
​
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
​
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
​
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}
​
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});
​
  final CameraDescription camera;
​
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}
​
class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
​
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
​
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }
​
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
​
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
​
            if (!context.mounted) return;
​
            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
​
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
​
  const DisplayPictureScreen({super.key, required this.imagePath});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-8-19. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/plugins/picture-using-camera.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/plugins/picture-using-camera&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/plugins/picture-using-camera.md "Report an issue with this page").