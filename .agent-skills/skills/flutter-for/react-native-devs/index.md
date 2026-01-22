---
name: flutter-for-react-native-developers
description: Learn how to apply React Native developer knowledge when building Flutter apps.
metadata:
  url: https://docs.flutter.dev/flutter-for/react-native-devs
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter for React Native developers

This document is for React Native (RN) developers looking to apply their
existing RN knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the RN framework then you can use this document as a
way to get started learning Flutter development.


This document can be used as a cookbook by jumping around and finding
questions that are most relevant to your needs.


## Introduction to Dart for JavaScript Developers (ES6)

[#](#introduction-to-dart-for-javascript-developers-es6)

Like React Native, Flutter uses reactive-style views. However, while RN
transpiles to native widgets, Flutter compiles all the way to native code.
Flutter controls each pixel on the screen, which avoids performance problems
caused by the need for a JavaScript bridge.


Dart is an easy language to learn and offers the following features:

- Provides an open-source, scalable programming language for building web,
   server, and mobile apps.

- Provides an object-oriented, single inheritance language that uses a C-style
   syntax that is AOT-compiled into native.

- Transcompiles optionally into JavaScript.
- Supports interfaces and abstract classes.

A few examples of the differences between JavaScript and Dart are described
below.


### Entry point

[#](#entry-point)

JavaScript doesn't have a pre-defined entry
function—you define the entry point.


js

```
// JavaScript
function startHere() {
  // Can be used as entry point
}

```

content\_copy

In Dart, every app must have a top-level `main()` function that serves as the
entry point to the app.


dart

```
/// Dart
void main() {}

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=0df636e00f348bdec2bc1c8ebc7daeb1).

### Printing to the console

[#](#printing-to-the-console)

To print to the console in Dart, use `print()`.

js

```
// JavaScript
console.log('Hello world!');

```

content\_copy

dart

```
/// Dart
print('Hello world!');

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=cf9e652f77636224d3e37d96dcf238e5).

### Variables

[#](#variables)

Dart is type safe—it uses a combination of static type checking
and runtime checks to ensure that a variable's value always matches
the variable's static type. Although types are mandatory,
some type annotations are optional because
Dart performs type inference.


#### Creating and assigning variables

[#](#creating-and-assigning-variables)

In JavaScript, variables cannot be typed.

In [Dart](https://dart.dev/dart-2), variables must either be explicitly
typed or the type system must infer the proper type automatically.


js

```
// JavaScript
let name = 'JavaScript';

```

content\_copy

dart

```
/// Dart
/// Both variables are acceptable.
String name = 'dart'; // Explicitly typed as a [String].
var otherName = 'Dart'; // Inferred [String] type.

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=3f4625c16e05eec396d6046883739612).

For more information, see [Dart's Type System](https://dart.dev/guides/language/sound-dart).


#### Default value

[#](#default-value)

In JavaScript, uninitialized variables are `undefined`.

In Dart, uninitialized variables have an initial value of `null`.
Because numbers are objects in Dart, even uninitialized variables with
numeric types have the value `null`.


infoNote

As of 2.12, Dart supports [Sound Null Safety](https://dart.dev/null-safety),
all underlying types are non-nullable by default,
which must be initialized as a non-nullable value.


js

```
// JavaScript
let name; // == undefined

```

content\_copy

dart

```
// Dart
var name; // == null; raises a linter warning
int? x; // == null

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=57ec21faa8b6fe2326ffd74e9781a2c7).

For more information, see the documentation on
[variables](https://dart.dev/language/variables).


### Checking for null or zero

[#](#checking-for-null-or-zero)

In JavaScript, values of 1 or any non-null objects
are treated as `true` when using the `==` comparison operator.


js

```
// JavaScript
let myNull = null;
if (!myNull) {
  console.log('null is treated as false');
}
let zero = 0;
if (!zero) {
  console.log('0 is treated as false');
}

```

content\_copy

In Dart, only the boolean value `true` is treated as true.

dart

```
/// Dart
var myNull = potentiallyNull();
if (myNull == null) {
  print('use "== null" to check null');
}
var zero = 0;
if (zero == 0) {
  print('use "== 0" to check zero');
}

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=c85038ad677963cb6dc943eb1a0b72e6).

### Functions

[#](#functions)

Dart and JavaScript functions are generally similar.
The primary difference is the declaration.


js

```
// JavaScript
function fn() {
  return true;
}

```

content\_copy

dart

```
/// Dart
/// You can explicitly define the return type.
bool fn() {
  return true;
}

```

content\_copy

Try it out in [DartPad](https://dartpad.dev/?id=5454e8bfadf3000179d19b9bc6be9918).

For more information, see the documentation on
[functions](https://dart.dev/language/functions).


### Asynchronous programming

[#](#asynchronous-programming)

#### Futures

[#](#futures)

Like JavaScript, Dart supports single-threaded execution. In JavaScript,
the Promise object represents the eventual completion (or failure)
of an asynchronous operation and its resulting value.


Dart uses [`Future`](https://dart.dev/tutorials/language/futures) objects to handle this.


js

```
// JavaScript
class Example {
  _getIPAddress() {
    const url = 'https://httpbin.org/ip';
    return fetch(url)
      .then(response => response.json())
      .then(responseJson => {
        const ip = responseJson.origin;
        return ip;
      });
  }
}
​
function main() {
  const example = new Example();
  example
    ._getIPAddress()
    .then(ip => console.log(ip))
    .catch(error => console.error(error));
}
​
main();

```

content\_copy

dart

```
// Dart
import 'dart:convert';
​
import 'package:http/http.dart' as http;
​
class Example {
  Future<String> _getIPAddress() {
    final url = Uri.https('httpbin.org', '/ip');
    return http.get(url).then((response) {
      final ip = jsonDecode(response.body)['origin'] as String;
      return ip;
    });
  }
}
​
void main() {
  final example = Example();
  example
      ._getIPAddress()
      .then((ip) => print(ip))
      .catchError((error) => print(error));
}

```

content\_copy

For more information, see the documentation on
[`Future`](https://dart.dev/tutorials/language/futures) objects.


#### `async` and `await`

[#](#async-and-await)

The `async` function declaration defines an asynchronous function.

In JavaScript, the `async` function returns a `Promise`.
The `await` operator is used to wait for a `Promise`.


js

```
// JavaScript
class Example {
  async function _getIPAddress() {
    const url = 'https://httpbin.org/ip';
    const response = await fetch(url);
    const json = await response.json();
    const data = json.origin;
    return data;
  }
}
​
async function main() {
  const example = new Example();
  try {
    const ip = await example._getIPAddress();
    console.log(ip);
  } catch (error) {
    console.error(error);
  }
}
​
main();

```

content\_copy

In Dart, an `async` function returns a `Future`,
and the body of the function is scheduled for execution later.
The `await` operator is used to wait for a `Future`.


dart

```
// Dart
import 'dart:convert';
​
import 'package:http/http.dart' as http;
​
class Example {
  Future<String> _getIPAddress() async {
    final url = Uri.https('httpbin.org', '/ip');
    final response = await http.get(url);
    final ip = jsonDecode(response.body)['origin'] as String;
    return ip;
  }
}
​
/// An async function returns a `Future`.
/// It can also return `void`, unless you use
/// the `avoid_void_async` lint. In that case,
/// return `Future<void>`.
void main() async {
  final example = Example();
  try {
    final ip = await example._getIPAddress();
    print(ip);
  } catch (error) {
    print(error);
  }
}

```

content\_copy

For more information, see the documentation for [async and await](https://dart.dev/language/async).


## The basics

[#](#the-basics)

### How do I create a Flutter app?

[#](#how-do-i-create-a-flutter-app)

To create an app using React Native,
you would run `create-react-native-app` from the command line.


```
$ create-react-native-app <projectname>

```

content\_copy

To create an app in Flutter, do one of the following:

- Use an IDE with the Flutter and Dart plugins installed.
- Use the `flutter create` command from the command line. Make sure that the
   Flutter SDK is in your PATH.


```
$ flutter create <projectname>

```

content\_copy

For more information, see [Getting started](/get-started), which
walks you through creating a button-click counter app.
Creating a Flutter project builds all the files that you
need to run a sample app on both Android and iOS devices.


### How do I run my app?

[#](#how-do-i-run-my-app)

In React Native, you would run `npm run` or `yarn run` from the project
directory.


You can run Flutter apps in a couple of ways:

- Use the "run" option in an IDE with the Flutter and Dart plugins.
- Use `flutter run` from the project's root directory.

Your app runs on a connected device, the iOS simulator,
or the Android emulator.


For more information, see the Flutter [Getting started](/get-started)
documentation.


### How do I import widgets?

[#](#how-do-i-import-widgets)

In React Native, you need to import each required component.

js

```
// React Native
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

```

content\_copy

In Flutter, to use widgets from the Material Design library,
import the `material.dart` package. To use iOS style widgets,
import the Cupertino library. To use a more basic widget set,
import the Widgets library.
Or, you can write your own widget library and import that.


dart

```
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_widgets/my_widgets.dart';

```

content\_copy

Whichever widget package you import,
Dart pulls in only the widgets that are used in your app.


For more information, see the [Flutter Widget Catalog](/ui/widgets).

### What is the equivalent of the React Native "Hello world!" app in Flutter?

[#](#what-is-the-equivalent-of-the-react-native-hello-world-app-in-flutter)

In React Native, the `HelloWorldApp` class extends `React.Component` and
implements the render method by returning a view component.


js

```
// React Native
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
​
const App = () => {
  return (
    <View style={styles.container}>
      <Text>Hello world!</Text>
    </View>
  );
};
​
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  }
});
​
export default App;

```

content\_copy

In Flutter, you can create an identical "Hello world!" app using the
`Center` and `Text` widgets from the core widget library.
The `Center` widget becomes the root of the widget tree and has one child,
the `Text` widget.


dart

```
// Flutter
import 'package:flutter/material.dart';
​
void main() {
  runApp(
    const Center(
      child: Text('Hello, world!', textDirection: TextDirection.ltr),
    ),
  );
}

```

content\_copy

The following images show the Android and iOS UI for the basic Flutter
"Hello world!" app.


![Hello world app on Android](/assets/images/docs/get-started/android/react-native/hello-world-basic.png)Android

![Hello world app on iOS](/assets/images/docs/get-started/ios/react-native/hello-world-basic.png)iOS

Now that you've seen the most basic Flutter app, the next section shows how to
take advantage of Flutter's rich widget libraries to create a modern, polished
app.


### How do I use widgets and nest them to form a widget tree?

[#](#how-do-i-use-widgets-and-nest-them-to-form-a-widget-tree)

In Flutter, almost everything is a widget.

Widgets are the basic building blocks of an app's user interface.
You compose widgets into a hierarchy, called a widget tree.
Each widget nests inside a parent widget
and inherits properties from its parent.
Even the application object itself is a widget.
There is no separate "application" object.
Instead, the root widget serves this role.


A widget can define:

- A structural element—like a button or menu
- A stylistic element—like a font or color scheme
- An aspect of layout—like padding or alignment

The following example shows the "Hello world!" app using widgets from the
Material library. In this example, the widget tree is nested inside the
`MaterialApp` root widget.


dart

```
// Flutter
import 'package:flutter/material.dart';
​
void main() => runApp(const MyApp());
​
class MyApp extends StatelessWidget {
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Welcome to Flutter')),
        body: const Center(child: Text('Hello world')),
      ),
    );
  }
}

```

content\_copy

The following images show "Hello world!" built from Material Design widgets.
You get more functionality for free than in the basic "Hello world!" app.


![Hello world app on Android](/assets/images/docs/get-started/android/react-native/hello-world.png)Android

![Hello world app on iOS](/assets/images/docs/get-started/ios/react-native/hello-world.png)iOS

When writing an app, you'll use two types of widgets:
[`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)
or [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).
A `StatelessWidget` is just what it sounds like—a
widget with no state. A `StatelessWidget` is created once,
and never changes its appearance.
A `StatefulWidget` dynamically changes state based on data
received, or user input.


The important difference between stateless and stateful
widgets is that `StatefulWidget` s have a `State` object
that stores state data and carries it over
across tree rebuilds, so it's not lost.


In simple or basic apps it's easy to nest widgets,
but as the code base gets larger and the app becomes complex,
you should break deeply nested widgets into
functions that return the widget or smaller classes.
Creating separate functions
and widgets allows you to reuse the components within the app.


### How do I create reusable components?

[#](#how-do-i-create-reusable-components)

In React Native, you would define a function (or a class) to create a
reusable component and then use `props` methods to set
or return properties and values of the selected elements.
In the example below, the `CustomCard` function is defined
and then used inside a parent component.


js

```
// React Native
const CustomCard = ({ index, onPress }) => {
  return (
    <View>
      <Text> Card {index} </Text>
      <Button
        title="Press"
        onPress={() => onPress(index)}
      />
    </View>
  );
};
​
// Usage
<CustomCard onPress={this.onPress} index={item.key} />

```

content\_copy

In Flutter, define a class to create a custom widget and then reuse the
widget. You can also define and call a function that returns a
reusable widget as shown in the `build` function in the following example.


dart

```
/// Flutter
class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.index, required this.onPress});
​
  final int index;
  final void Function() onPress;
​
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Card $index'),
          TextButton(onPressed: onPress, child: const Text('Press')),
        ],
      ),
    );
  }
}
​
class UseCard extends StatelessWidget {
  const UseCard({super.key, required this.index});
​
  final int index;
​
  @override
  Widget build(BuildContext context) {
    /// Usage
    return CustomCard(
      index: index,
      onPress: () {
        print('Card $index');
      },
    );
  }
}

```

content\_copy

In the previous example, the constructor for the `CustomCard`
class uses Dart's curly brace syntax `{ }` to indicate [named parameters](https://dart.dev/language/functions#named-parameters).


To require these fields, either remove the curly braces from
the constructor, or add `required` to the constructor.


The following screenshots show an example of the reusable
`CustomCard` class.


![Custom cards on Android](/assets/images/docs/get-started/android/react-native/custom-cards.png)Android

![Custom cards on iOS](/assets/images/docs/get-started/ios/react-native/custom-cards.png)iOS

## Project structure and resources

[#](#project-structure-and-resources)

### Where do I start writing the code?

[#](#where-do-i-start-writing-the-code)

Start with the `lib/main.dart` file.
It's autogenerated when you create a Flutter app.


dart

```
// Dart
void main() {
  print('Hello, this is the main function.');
}

```

content\_copy

In Flutter, the entry point file is
`{project_name}/lib/main.dart` and execution
starts from the `main` function.


### How are files structured in a Flutter app?

[#](#how-are-files-structured-in-a-flutter-app)

When you create a new Flutter project,
it builds the following directory structure.
You can customize it later, but this is where you start.


- <project\_name>/

- android/// Contains Android-specific files.
- build/// Stores iOS and Android build files.
- ios/// Contains iOS-specific files.
- lib/// Contains externally accessible Dart source files.

- src/// Contains additional source files.
- main.dart// The Flutter entry point and the start of a new app. This is generated automatically when you create a Flutter project. It's where you start writing your Dart code.

- test/// Contains automated test files.
- pubspec.yaml// Contains the metadata for the Flutter app. This is equivalent to the package.json file in React Native.

### Where do I put my resources and assets and how do I use them?

[#](#where-do-i-put-my-resources-and-assets-and-how-do-i-use-them)

A Flutter resource or asset is a file that is bundled and deployed
with your app and is accessible at runtime.
Flutter apps can include the following asset types:


- Static data such as JSON files
- Configuration files
- Icons and images (JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP,
   and WBMP)


Flutter uses the `pubspec.yaml` file,
located at the root of your project, to
identify assets required by an app.


yaml

```
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png

```

content\_copy

The `assets` subsection specifies files that should be included with the app.
Each asset is identified by an explicit path
relative to the `pubspec.yaml` file, where the asset file is located.
The order in which the assets are declared does not matter.
The actual directory used ( `assets` in this case) does not matter.
However, while assets can be placed in any app directory, it's a
best practice to place them in the `assets` directory.


During a build, Flutter places assets into a special archive
called the _asset bundle_, which apps read from at runtime.
When an asset's path is specified in the assets' section of `pubspec.yaml`,
the build process looks for any files
with the same name in adjacent subdirectories.
These files are also included in the asset bundle
along with the specified asset. Flutter uses asset variants
when choosing resolution-appropriate images for your app.


In React Native, you would add a static image by placing the image file
in a source code directory and referencing it.


js

```
<Image source={require('./my-icon.png')} />
// OR
<Image
  source={{
    url: 'https://reactnative.dev/img/tiny_logo.png'
  }}
/>

```

content\_copy

In Flutter, add a static image to your app
using the `Image.asset` constructor in a widget's build method.


dart

```
Image.asset('assets/background.png');

```

content\_copy

For more information, see [Adding Assets and Images in Flutter](/ui/assets/assets-and-images).


### How do I load images over a network?

[#](#how-do-i-load-images-over-a-network)

In React Native, you would specify the `uri` in the
`source` prop of the `Image` component and also provide the
size if needed.


In Flutter, use the `Image.network` constructor to include
an image from a URL.


dart

```
Image.network('https://docs.flutter.dev/assets/images/docs/owl.jpg');

```

content\_copy

### How do I install packages and package plugins?

[#](#how-do-i-install-packages-and-package-plugins)

Flutter supports using shared packages contributed by other developers to the
Flutter and Dart ecosystems. This allows you to quickly build your app without
having to develop everything from scratch. Packages that contain
platform-specific code are known as package plugins.


In React Native, you would use `yarn add {package-name}` or
`npm install --save {package-name}` to install packages
from the command line.


In Flutter, install a package using the following instructions:

1. To add the `google_sign_in` package as a dependency, run `flutter pub add`:

```
$ flutter pub add google_sign_in

```

content\_copy

2. Install the package from the command line by using `flutter pub get`.
    If using an IDE, it often runs `flutter pub get` for you, or it might
    prompt you to do so.

3. Import the package into your app code as shown below:

dart

```
import 'package:flutter/material.dart';

```

content\_copy

For more information, see [Using Packages](/packages-and-plugins/using-packages) and
[Developing Packages & Plugins](/packages-and-plugins/developing-packages).


You can find many packages shared by Flutter developers in the
[Flutter packages](https://pub.dev/flutter/) section of [pub.dev](https://pub.dev).


## Flutter widgets

[#](#flutter-widgets)

In Flutter, you build your UI out of widgets that describe what their view
should look like given their current configuration and state.


Widgets are often composed of many small,
single-purpose widgets that are nested to produce powerful effects.
For example, the `Container` widget consists of
several widgets responsible for layout, painting, positioning, and sizing.
Specifically, the `Container` widget includes the `LimitedBox`,
`ConstrainedBox`, `Align`, `Padding`, `DecoratedBox`, and
`Transform` widgets.
Rather than subclassing `Container` to produce a customized effect, you can
compose these and other simple widgets in new and unique ways.


The `Center` widget is another example of how you can control the layout.
To center a widget, wrap it in a `Center` widget and then use layout
widgets for alignment, row, columns, and grids.
These layout widgets do not have a visual representation of their own.
Instead, their sole purpose is to control some aspect of another
widget's layout. To understand why a widget renders in a
certain way, it's often helpful to inspect the neighboring widgets.


For more information, see the [Flutter Technical Overview](/resources/architectural-overview).


For more information about the core widgets from the `Widgets` package,
see [Flutter Basic Widgets](/ui/widgets/basics),
the [Flutter Widget Catalog](/ui/widgets),
or the [Flutter Widget Index](/reference/widgets).


## Views

[#](#views)

### What is the equivalent of the `View` container?

[#](#what-is-the-equivalent-of-the-view-container)

In React Native, `View` is a container that supports layout with `Flexbox`,
style, touch handling, and accessibility controls.


In Flutter, you can use the core layout widgets in the `Widgets`
library, such as [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html),
[`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html),
[`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html), and
[`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html).
For more information, see the [Layout Widgets](/ui/widgets/layout) catalog.


### What is the equivalent of `FlatList` or `SectionList`?

[#](#what-is-the-equivalent-of-flatlist-or-sectionlist)

A `List` is a scrollable list of components arranged vertically.

In React Native, `FlatList` or `SectionList` are used to render simple or
sectioned lists.


js

```
// React Native
<FlatList
  data={[ ... ]}
  renderItem={({ item }) => <Text>{item.key}</Text>}
/>

```

content\_copy

[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) is Flutter's most commonly used scrolling widget.
The default constructor takes an explicit list of children.
[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)
is most appropriate for a small number of widgets.
For a large or infinite list, use `ListView.builder`,
which builds its children on demand and only builds
those children that are visible.


dart

```
var data = ['Hello', 'World'];
return ListView.builder(
  itemCount: data.length,
  itemBuilder: (context, index) {
    return Text(data[index]);
  },
);

```

content\_copy

![Flat list on Android](/assets/images/docs/get-started/android/react-native/flatlist.webp)Android

![Flat list on iOS](/assets/images/docs/get-started/ios/react-native/flatlist.webp)iOS

To learn how to implement an infinite scrolling list, see the official
[`infinite_list`](https://github.com/flutter/samples/tree/main/infinite_list)
sample.


### How do I use a Canvas to draw or paint?

[#](#how-do-i-use-a-canvas-to-draw-or-paint)

In React Native, canvas components aren't present
so third party libraries like `react-native-canvas` are used.


js

```
// React Native
const CanvasComp = () => {
  const handleCanvas = (canvas) => {
    const ctx = canvas.getContext('2d');
    ctx.fillStyle = 'skyblue';
    ctx.beginPath();
    ctx.arc(75, 75, 50, 0, 2 * Math.PI);
    ctx.fillRect(150, 100, 300, 300);
    ctx.stroke();
  };
​
  return (
    <View>
      <Canvas ref={this.handleCanvas} />
    </View>
  );
}

```

content\_copy

In Flutter, you can use the [`CustomPaint`](https://api.flutter.dev/flutter/widgets/CustomPaint-class.html)

and [`CustomPainter`](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
classes to draw to the canvas.


The following example shows how to draw during the paint phase using the
`CustomPaint` widget. It implements the abstract class, `CustomPainter`,
and passes it to `CustomPaint`'s painter property.
`CustomPaint` subclasses must implement the `paint()`
and `shouldRepaint()` methods.


dart

```
class MyCanvasPainter extends CustomPainter {
  const MyCanvasPainter();
​
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.amber;
    canvas.drawCircle(const Offset(100, 200), 40, paint);
    final Paint paintRect = Paint()..color = Colors.lightBlue;
    final Rect rect = Rect.fromPoints(
      const Offset(150, 300),
      const Offset(300, 400),
    );
    canvas.drawRect(rect, paintRect);
  }
​
  @override
  bool shouldRepaint(MyCanvasPainter oldDelegate) => false;
}
​
class MyCanvasWidget extends StatelessWidget {
  const MyCanvasWidget({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CustomPaint(painter: MyCanvasPainter()));
  }
}

```

content\_copy

![Canvas on Android](/assets/images/docs/get-started/android/react-native/canvas.png)Android

![Canvas on iOS](/assets/images/docs/get-started/ios/react-native/canvas.png)iOS

## Layouts

[#](#layouts)

### How do I use widgets to define layout properties?

[#](#how-do-i-use-widgets-to-define-layout-properties)

In React Native, most of the layout can be done with the props
that are passed to a specific component.
For example, you could use the `style` prop on the `View` component
in order to specify the flexbox properties.
To arrange your components in a column, you would specify a prop such as:
`flexDirection: 'column'`.


js

```
// React Native
<View
  style={{
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'space-between',
    alignItems: 'center'
  }}
>

```

content\_copy

In Flutter, the layout is primarily defined by widgets
specifically designed to provide layout,
combined with control widgets and their style properties.


For example, the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
and [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) widgets
take an array of children and align them
vertically and horizontally respectively.
A [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html)
widget takes a combination of
layout and styling properties, and a
[`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html)
widget centers its child widgets.


dart

```
@override
Widget build(BuildContext context) {
  return Center(
    child: Column(
      children: <Widget>[
        Container(color: Colors.red, width: 100, height: 100),
        Container(color: Colors.blue, width: 100, height: 100),
        Container(color: Colors.green, width: 100, height: 100),
      ],
    ),
  );

```

content\_copy

Flutter provides a variety of layout widgets in its core widget library.
For example, [`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html),
[`Align`](https://api.flutter.dev/flutter/widgets/Align-class.html), and [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html).


For a complete list, see [Layout Widgets](/ui/widgets/layout).

![Layout on Android](/assets/images/docs/get-started/android/react-native/basic-layout.webp)Android

![Layout on iOS](/assets/images/docs/get-started/ios/react-native/basic-layout.webp)iOS

### How do I layer widgets?

[#](#how-do-i-layer-widgets)

In React Native, components can be layered using `absolute` positioning.

Flutter uses the [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html)

widget to arrange children widgets in layers.
The widgets can entirely or partially overlap the base widget.


The `Stack` widget positions its children relative to the edges of its box.
This class is useful if you simply want to overlap several children widgets.


dart

```
@override
Widget build(BuildContext context) {
  return Stack(
    alignment: const Alignment(0.6, 0.6),
    children: <Widget>[
      const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://avatars3.githubusercontent.com/u/14101776?v=4',
        ),
      ),
      Container(color: Colors.black45, child: const Text('Flutter')),
    ],
  );

```

content\_copy

The previous example uses `Stack` to overlay a Container
(that displays its `Text` on a translucent black background)
on top of a `CircleAvatar`.
The Stack offsets the text using the alignment property
and `Alignment` coordinates.


![Stack on Android](/assets/images/docs/get-started/android/react-native/stack.png)Android

![Stack on iOS](/assets/images/docs/get-started/ios/react-native/stack.png)iOS

For more information, see the [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html)
class documentation.


## Styling

[#](#styling)

### How do I style my components?

[#](#how-do-i-style-my-components)

In React Native, inline styling and `stylesheets.create`
are used to style components.


js

```
// React Native
<View style={styles.container}>
  <Text style={{ fontSize: 32, color: 'cyan', fontWeight: '600' }}>
    This is a sample text
  </Text>
</View>
​
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  }
});

```

content\_copy

In Flutter, a `Text` widget can take a `TextStyle` class
for its style property. If you want to use the same text
style in multiple places, you can create a
[`TextStyle`](https://api.flutter.dev/flutter/dart-ui/TextStyle-class.html)
class and use it for multiple `Text` widgets.


dart

```
const TextStyle textStyle = TextStyle(
  color: Colors.cyan,
  fontSize: 32,
  fontWeight: FontWeight.w600,
);
​
return const Center(
  child: Column(
    children: <Widget>[
      Text('Sample text', style: textStyle),
      Padding(
        padding: EdgeInsets.all(20),
        child: Icon(
          Icons.lightbulb_outline,
          size: 48,
          color: Colors.redAccent,
        ),
      ),
    ],
  ),
);

```

content\_copy

![Styling on Android](/assets/images/docs/get-started/android/react-native/flutterstyling.webp)Android

![Styling on iOS](/assets/images/docs/get-started/ios/react-native/flutterstyling.webp)iOS

### How do I use `Icons` and `Colors`?

[#](#how-do-i-use-icons-and-colors)

React Native doesn't include support for icons
so third party libraries are used.


In Flutter, importing the Material library also pulls in the
rich set of [Material icons](https://api.flutter.dev/flutter/material/Icons-class.html)
and [colors](https://api.flutter.dev/flutter/material/Colors-class.html).


dart

```
return const Icon(Icons.lightbulb_outline, color: Colors.redAccent);

```

content\_copy

When using the `Icons` class,
make sure to set `uses-material-design: true` in
the project's `pubspec.yaml` file.
This ensures that the `MaterialIcons` font,
which displays the icons, is included in your app.
In general, if you intend to use the Material library,
you should include this line.


yaml

```
name: my_awesome_application
flutter:
  uses-material-design: true

```

content\_copy

Flutter's [Cupertino (iOS-style)](/ui/widgets/cupertino) package provides high
fidelity widgets for the current iOS design language.
To use the `CupertinoIcons` font,
add a dependency for `cupertino_icons` in your project's
`pubspec.yaml` file.


yaml

```
name: my_awesome_application
dependencies:
  cupertino_icons: ^1.0.8

```

content\_copy

To globally customize the colors and styles of components,
use `ThemeData` to specify default colors
for various aspects of the theme.
Set the theme property in `MaterialApp` to the `ThemeData` object.
The [`Colors`](https://api.flutter.dev/flutter/material/Colors-class.html)
class provides colors
from the Material Design [color palette](https://m2.material.io/design/color/the-color-system.html#color-theme-creation).


The following example sets the color scheme from seed to `deepPurple`
and the text selection to `red`.


dart

```
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.red,
        ),
      ),
      home: const SampleAppPage(),
    );
  }
}

```

content\_copy

### How do I add style themes?

[#](#how-do-i-add-style-themes)

In React Native, common themes are defined for
components in stylesheets and then used in components.


In Flutter, create uniform styling for almost everything
by defining the styling in the [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html)

class and passing it to the theme property in the
[`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
widget.


dart

```
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(primaryColor: Colors.cyan, brightness: Brightness.dark),
    home: const StylingPage(),
  );
}

```

content\_copy

A `Theme` can be applied even without using the `MaterialApp` widget.
The [`Theme`](https://api.flutter.dev/flutter/material/Theme-class.html)
widget takes a `ThemeData` in its `data` parameter
and applies the `ThemeData` to all of its children widgets.


dart

```
@override
Widget build(BuildContext context) {
  return Theme(
    data: ThemeData(primaryColor: Colors.cyan, brightness: brightness),
    child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //...
    ),
  );
}

```

content\_copy

## State management

[#](#state-management)

State is information that can be read synchronously
when a widget is built or information
that might change during the lifetime of a widget.
To manage app state in Flutter,
use a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
paired with a State object.


For more information on ways to approach managing state in Flutter,
see [State management](/data-and-backend/state-mgmt).


### The StatelessWidget

[#](#the-statelesswidget)

A `StatelessWidget` in Flutter is a widget
that doesn't require a state change—
it has no internal state to manage.


Stateless widgets are useful when the part of the user interface
you are describing does not depend on anything other than the
configuration information in the object itself and the
[`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
in which the widget is inflated.


[`AboutDialog`](https://api.flutter.dev/flutter/material/AboutDialog-class.html),
[`CircleAvatar`](https://api.flutter.dev/flutter/material/CircleAvatar-class.html), and
[`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) are examples
of stateless widgets that subclass [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).


dart

```
import 'package:flutter/material.dart';
​
void main() => runApp(
  const MyStatelessWidget(
    text: 'StatelessWidget Example to show immutable data',
  ),
);
​
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key, required this.text});
​
  final String text;
​
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, textDirection: TextDirection.ltr));
  }
}

```

content\_copy

The previous example uses the constructor of the `MyStatelessWidget`
class to pass the `text`, which is marked as `final`.
This class extends `StatelessWidget`&mdash;it contains immutable data.


The `build` method of a stateless widget is typically called
in only three situations:


- When the widget is inserted into a tree
- When the widget's parent changes its configuration
- When an [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
   it depends on, changes


### The StatefulWidget

[#](#the-statefulwidget)

A [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
is a widget that changes state.
Use the `setState` method to manage the
state changes for a `StatefulWidget`.
A call to `setState()` tells the Flutter
framework that something has changed in a state,
which causes an app to rerun the `build()` method
so that the app can reflect the change.


_State_ is information that can be read synchronously when a widget
is built and might change during the lifetime of the widget.
It's the responsibility of the widget implementer to ensure that
the state object is promptly notified when the state changes.
Use `StatefulWidget` when a widget can change dynamically.
For example, the state of the widget changes by typing into a form,
or moving a slider.
Or, it can change over time—perhaps a data feed updates the UI.


[`Checkbox`](https://api.flutter.dev/flutter/material/Checkbox-class.html), [`Radio`](https://api.flutter.dev/flutter/material/Radio-class.html),
[`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html), [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html),
[`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html), and
[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
are examples of stateful widgets that subclass
[`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).


The following example declares a `StatefulWidget`
that requires a `createState()` method.
This method creates the state object that manages the widget's state,
`_MyStatefulWidgetState`.


dart

```
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});
​
  final String title;
​
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

```

content\_copy

The following state class, `_MyStatefulWidgetState`,
implements the `build()` method for the widget.
When the state changes, for example, when the user toggles
the button, `setState()` is called with the new toggle value.
This causes the framework to rebuild this widget in the UI.


dart

```
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool showText = true;
  bool toggleState = true;
  Timer? t2;
​
  void toggleBlinkState() {
    setState(() {
      toggleState = !toggleState;
    });
    if (!toggleState) {
      t2 = Timer.periodic(const Duration(milliseconds: 1000), (t) {
        toggleShowText();
      });
    } else {
      t2?.cancel();
    }
  }
​
  void toggleShowText() {
    setState(() {
      showText = !showText;
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            if (showText)
              const Text('This execution will be done before you can blink.'),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ElevatedButton(
                onPressed: toggleBlinkState,
                child: toggleState
                    ? const Text('Blink')
                    : const Text('Stop Blinking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

content\_copy

### What are the StatefulWidget and StatelessWidget best practices?

[#](#what-are-the-statefulwidget-and-statelesswidget-best-practices)

Here are a few things to consider when designing your widget.

1. Determine whether a widget should be
    a `StatefulWidget` or a `StatelessWidget`.


In Flutter, widgets are either Stateful or Stateless—depending on whether
they depend on a state change.


- If a widget changes—the user interacts with it or
   a data feed interrupts the UI, then it's _Stateful_.

- If a widget is final or immutable, then it's _Stateless_.

2. Determine which object manages the widget's state (for a `StatefulWidget`).

In Flutter, there are three primary ways to manage state:

- The widget manages its own state
- The parent widget manages the widget's state
- A mix-and-match approach

When deciding which approach to use, consider the following principles:

- If the state in question is user data,
   for example the checked or unchecked mode of a checkbox,
   or the position of a slider, then the state is best managed
   by the parent widget.

- If the state in question is aesthetic, for example an animation,
   then the widget itself best manages the state.

- When in doubt, let the parent widget manage the child widget's state.

3. Subclass StatefulWidget and State.

The `MyStatefulWidget` class manages its own state—it extends
`StatefulWidget`, it overrides the `createState()`
method to create the `State` object,
and the framework calls `createState()` to build the widget.
In this example, `createState()` creates an instance of
`_MyStatefulWidgetState`, which
is implemented in the next best practice.


dart

```
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});
​
  final String title;
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
​
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    //...
  }
}

```

content\_copy

4. Add the StatefulWidget into the widget tree.

Add your custom `StatefulWidget` to the widget tree
in the app's build method.


dart

```
class MyStatelessWidget extends StatelessWidget {
  // This widget is the root of your application.
  const MyStatelessWidget({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyStatefulWidget(title: 'State Change Demo'),
    );
  }
}

```

content\_copy

![State change on Android](/assets/images/docs/get-started/android/react-native/state-change.webp)Android

![State change on iOS](/assets/images/docs/get-started/ios/react-native/state-change.webp)iOS

## Props

[#](#props)

In React Native, most components can be customized when they are
created with different parameters or properties, called `props`.
These parameters can be used in a child component using `this.props`.


js

```
// React Native
const CustomCard = ({ index, onPress }) => {
  return (
    <View>
      <Text> Card {index} </Text>
      <Button
        title='Press'
        onPress={() => onPress(index)}
      />
    </View>
  );
};
​
const App = () => {
  const onPress = (index) => {
    console.log('Card ', index);
  };
​
  return (
    <View>
      <FlatList
        data={[ /* ... */ ]}
        renderItem={({ item }) => (
          <CustomCard onPress={onPress} index={item.key} />
        )}
      />
    </View>
  );
};

```

content\_copy

In Flutter, you assign a local variable or function marked
`final` with the property received in the parameterized constructor.


dart

```
/// Flutter
class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.index, required this.onPress});
​
  final int index;
  final void Function() onPress;
​
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Card $index'),
          TextButton(onPressed: onPress, child: const Text('Press')),
        ],
      ),
    );
  }
}
​
class UseCard extends StatelessWidget {
  const UseCard({super.key, required this.index});
​
  final int index;
​
  @override
  Widget build(BuildContext context) {
    /// Usage
    return CustomCard(
      index: index,
      onPress: () {
        print('Card $index');
      },
    );
  }
}

```

content\_copy

![Cards on Android](/assets/images/docs/get-started/android/react-native/modular.png)Android

![Cards on iOS](/assets/images/docs/get-started/ios/react-native/modular.png)iOS

## Local storage

[#](#local-storage)

If you don't need to store a lot of data, and it doesn't require
structure, you can use `shared_preferences` which allows you to
read and write persistent key-value pairs of primitive data
types: booleans, floats, ints, longs, and strings.


### How do I store persistent key-value pairs that are global to the app?

[#](#how-do-i-store-persistent-key-value-pairs-that-are-global-to-the-app)

In React Native, you use the `setItem` and `getItem` functions
of the `AsyncStorage` component to store and retrieve data
that is persistent and global to the app.


js

```
// React Native
const [counter, setCounter] = useState(0)
...
await AsyncStorage.setItem( 'counterkey', json.stringify(++this.state.counter));
AsyncStorage.getItem('counterkey').then(value => {
  if (value != null) {
    setCounter(value);
  }
});

```

content\_copy

In Flutter, use the [`shared_preferences`](https://github.com/flutter/packages/tree/main/packages/shared_preferences/shared_preferences)
plugin to
store and retrieve key-value data that is persistent and global
to the app. The `shared_preferences` plugin wraps
`NSUserDefaults` on iOS and `SharedPreferences` on Android,
providing a persistent store for simple data.


To add the `shared_preferences` package as a dependency, run `flutter pub add`:


```
$ flutter pub add shared_preferences

```

content\_copy

dart

```
import 'package:shared_preferences/shared_preferences.dart';

```

content\_copy

To implement persistent data, use the setter methods
provided by the `SharedPreferences` class.
Setter methods are available for various primitive
types, such as `setInt`, `setBool`, and `setString`.
To read data, use the appropriate getter method provided
by the `SharedPreferences` class. For each
setter there is a corresponding getter method,
for example, `getInt`, `getBool`, and `getString`.


dart

```
Future<void> updateCounter() async {
  final prefs = await SharedPreferences.getInstance();
  int? counter = prefs.getInt('counter');
  if (counter is int) {
    await prefs.setInt('counter', ++counter);
  }
  setState(() {
    _counter = counter;
  });
}

```

content\_copy

## Routing

[#](#routing)

Most apps contain several screens for displaying different
types of information. For example, you might have a product
screen that displays images where users could tap on a product
image to get more information about the product on a new screen.


In Android, new screens are new Activities.
In iOS, new screens are new ViewControllers. In Flutter,
screens are just Widgets! And to navigate to new
screens in Flutter, use the Navigator widget.


### How do I navigate between screens?

[#](#how-do-i-navigate-between-screens)

In React Native, there are three main navigators:
StackNavigator, TabNavigator, and DrawerNavigator.
Each provides a way to configure and define the screens.


js

```
// React Native
const MyApp = TabNavigator(
  { Home: { screen: HomeScreen }, Notifications: { screen: tabNavScreen } },
  { tabBarOptions: { activeTintColor: '#e91e63' } }
);
const SimpleApp = StackNavigator({
  Home: { screen: MyApp },
  stackScreen: { screen: StackScreen }
});
export default (MyApp1 = DrawerNavigator({
  Home: {
    screen: SimpleApp
  },
  Screen2: {
    screen: drawerScreen
  }
}));

```

content\_copy

In Flutter, there are two main widgets used to navigate between screens:

- A [`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html) is an abstraction for an app screen or page.

- A [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) is a widget that manages routes.


A `Navigator` is defined as a widget that manages a set of child
widgets with a stack discipline. The navigator manages a stack
of `Route` objects and provides methods for managing the stack,
like [`Navigator.push`](https://api.flutter.dev/flutter/widgets/Navigator/push.html)
and [`Navigator.pop`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html).
A list of routes might be specified in the [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
widget,
or they might be built on the fly, for example, in hero animations.
The following example specifies named routes in the `MaterialApp` widget.


infoNote

Named routes are no longer recommended for most
applications. For more information, see
[Limitations](/ui/navigation#limitations) in the [navigation overview](/ui/navigation)
page.


dart

```
class NavigationApp extends StatelessWidget {
  // This widget is the root of your application.
  const NavigationApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //...
      routes: <String, WidgetBuilder>{
        '/a': (context) => const UsualNavScreen(),
        '/b': (context) => const DrawerNavScreen(),
      },
      //...
    );
  }
}

```

content\_copy

To navigate to a named route, the [`Navigator.of()`](https://api.flutter.dev/flutter/widgets/Navigator/of.html)

method is used to specify the `BuildContext`
(a handle to the location of a widget in the widget tree).
The name of the route is passed to the `pushNamed` function to
navigate to the specified route.


dart

```
Navigator.of(context).pushNamed('/a');

```

content\_copy

You can also use the push method of `Navigator` which
adds the given [`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html)
to the history of the
navigator that most tightly encloses the given [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html),
and transitions to it. In the following example,
the [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html)
widget is a modal route that
replaces the entire screen with a platform-adaptive
transition. It takes a [`WidgetBuilder`](https://api.flutter.dev/flutter/widgets/WidgetBuilder.html)
as a required parameter.


dart

```
Navigator.push(
  context,
  MaterialPageRoute<void>(builder: (context) => const UsualNavScreen()),
);

```

content\_copy

### How do I use tab navigation and drawer navigation?

[#](#how-do-i-use-tab-navigation-and-drawer-navigation)

In Material Design apps, there are two primary options
for Flutter navigation: tabs and drawers.
When there is insufficient space to support tabs, drawers
provide a good alternative.


#### Tab navigation

[#](#tab-navigation)

In React Native, `createBottomTabNavigator`
and `TabNavigation` are used to
show tabs and for tab navigation.


js

```
// React Native
import { createBottomTabNavigator } from 'react-navigation';
​
const MyApp = TabNavigator(
  { Home: { screen: HomeScreen }, Notifications: { screen: tabNavScreen } },
  { tabBarOptions: { activeTintColor: '#e91e63' } }
);

```

content\_copy

Flutter provides several specialized widgets for drawer and
tab navigation:


[`TabController`](https://api.flutter.dev/flutter/material/TabController-class.html)

Coordinates the tab selection between a `TabBar`
and a `TabBarView`.


[`TabBar`](https://api.flutter.dev/flutter/material/TabBar-class.html)

Displays a horizontal row of tabs.

[`Tab`](https://api.flutter.dev/flutter/material/Tab-class.html)

Creates a material design TabBar tab.

[`TabBarView`](https://api.flutter.dev/flutter/material/TabBarView-class.html)

Displays the widget that corresponds to the currently selected tab.

dart

```
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);
​
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: const <Tab>[
        Tab(icon: Icon(Icons.person)),
        Tab(icon: Icon(Icons.email)),
      ],
    );
  }
}

```

content\_copy

A `TabController` is required to coordinate the tab selection
between a `TabBar` and a `TabBarView`.
The `TabController` constructor `length` argument is the total
number of tabs. A `TickerProvider` is required to trigger
the notification whenever a frame triggers a state change.
The `TickerProvider` is `vsync`. Pass the
`vsync: this` argument to the `TabController` constructor
whenever you create a new `TabController`.


The [`TickerProvider`](https://api.flutter.dev/flutter/scheduler/TickerProvider-class.html)
is an interface implemented
by classes that can vend [`Ticker`](https://api.flutter.dev/flutter/scheduler/Ticker-class.html)
objects.
Tickers can be used by any object that must be notified whenever a
frame triggers, but they're most commonly used indirectly via an
[`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html).
`AnimationController` s
need a `TickerProvider` to obtain their `Ticker`.
If you are creating an AnimationController from a State,
then you can use the [`TickerProviderStateMixin`](https://api.flutter.dev/flutter/widgets/TickerProviderStateMixin-mixin.html)

or [`SingleTickerProviderStateMixin`](https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html)

classes to obtain a suitable `TickerProvider`.


The [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget wraps a new
`TabBar` widget and
creates two tabs. The `TabBarView` widget
is passed as the `body` parameter of the `Scaffold` widget.
All screens corresponding to the `TabBar` widget's tabs are
children to the `TabBarView` widget along with the same `TabController`.


dart

```
class _NavigationHomePageState extends State<NavigationHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: const <Tab>[
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.email)),
          ],
          controller: controller,
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const <Widget>[HomeScreen(), TabScreen()],
      ),
    );
  }
}

```

content\_copy

#### Drawer navigation

[#](#drawer-navigation)

In React Native, import the needed react-navigation packages and then use
`createDrawerNavigator` and `DrawerNavigation`.


js

```
// React Native
export default (MyApp1 = DrawerNavigator({
  Home: {
    screen: SimpleApp
  },
  Screen2: {
    screen: drawerScreen
  }
}));

```

content\_copy

In Flutter, we can use the `Drawer` widget in combination with a
`Scaffold` to create a layout with a Material Design drawer.
To add a `Drawer` to an app, wrap it in a `Scaffold` widget.
The `Scaffold` widget provides a consistent
visual structure to apps that follow the
[Material Design](https://m3.material.io/styles) guidelines. It also supports
special Material Design components,
such as `Drawers`, `AppBars`, and `SnackBars`.


The `Drawer` widget is a Material Design panel that slides
in horizontally from the edge of a `Scaffold` to show navigation
links in an application. You can
provide a [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html), a
[`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget,
or a list of items to display as the child to the `Drawer` widget.
In the following example, the [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html)

widget provides the navigation on tap.


dart

```
@override
Widget build(BuildContext context) {
  return Drawer(
    elevation: 20,
    child: ListTile(
      leading: const Icon(Icons.change_history),
      title: const Text('Screen2'),
      onTap: () {
        Navigator.of(context).pushNamed('/b');
      },
    ),
  );
}

```

content\_copy

The `Scaffold` widget also includes an `AppBar` widget that automatically
displays an appropriate IconButton to show the `Drawer` when a Drawer is
available in the `Scaffold`. The `Scaffold` automatically handles the
edge-swipe gesture to show the `Drawer`.


dart

```
@override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: Drawer(
      elevation: 20,
      child: ListTile(
        leading: const Icon(Icons.change_history),
        title: const Text('Screen2'),
        onTap: () {
          Navigator.of(context).pushNamed('/b');
        },
      ),
    ),
    appBar: AppBar(title: const Text('Home')),
    body: Container(),
  );
}

```

content\_copy

![Navigation on Android](/assets/images/docs/get-started/android/react-native/navigation.webp)Android

![Navigation on iOS](/assets/images/docs/get-started/ios/react-native/navigation.webp)iOS

## Gesture detection and touch event handling

[#](#gesture-detection-and-touch-event-handling)

To listen for and respond to gestures,
Flutter supports taps, drags, and scaling.
The gesture system in Flutter has two separate layers.
The first layer includes raw pointer events,
which describe the location and movement of pointers,
(such as touches, mice, and styli movements), across the screen.
The second layer includes gestures
that describe semantic actions
and consist of one or more pointer movements.


### How do I add a click or press listeners to a widget?

[#](#how-do-i-add-a-click-or-press-listeners-to-a-widget)

In React Native, listeners are added to components
using `PanResponder` or the `Touchable` components.


js

```
// React Native
<TouchableOpacity
  onPress={() => {
    console.log('Press');
  }}
  onLongPress={() => {
    console.log('Long Press');
  }}
>
  <Text>Tap or Long Press</Text>
</TouchableOpacity>

```

content\_copy

For more complex gestures and combining several touches into
a single gesture, [`PanResponder`](https://reactnative.dev/docs/panresponder)
is used.


js

```
// React Native
const App = () => {
  const panResponderRef = useRef(null);
​
  useEffect(() => {
    panResponderRef.current = PanResponder.create({
      onMoveShouldSetPanResponder: (event, gestureState) =>
        !!getDirection(gestureState),
      onPanResponderMove: (event, gestureState) => true,
      onPanResponderRelease: (event, gestureState) => {
        const drag = getDirection(gestureState);
      },
      onPanResponderTerminationRequest: (event, gestureState) => true
    });
  }, []);
​
  return (
    <View style={styles.container} {...panResponderRef.current.panHandlers}>
      <View style={styles.center}>
        <Text>Swipe Horizontally or Vertically</Text>
      </View>
    </View>
  );
};

```

content\_copy

In Flutter, to add a click (or press) listener to a widget,
use a button or a touchable widget that has an `onPress: field`.
Or, add gesture detection to any widget by wrapping it
in a [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html).


dart

```
@override
Widget build(BuildContext context) {
  return GestureDetector(
    child: Scaffold(
      appBar: AppBar(title: const Text('Gestures')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tap, Long Press, Swipe Horizontally or Vertically'),
          ],
        ),
      ),
    ),
    onTap: () {
      print('Tapped');
    },
    onLongPress: () {
      print('Long Pressed');
    },
    onVerticalDragEnd: (value) {
      print('Swiped Vertically');
    },
    onHorizontalDragEnd: (value) {
      print('Swiped Horizontally');
    },
  );
}

```

content\_copy

For more information, including a list of
Flutter `GestureDetector` callbacks,
see the [GestureDetector class](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html#instance-properties).


![Gestures on Android](/assets/images/docs/get-started/android/react-native/flutter-gestures.webp)Android

![Gestures on iOS](/assets/images/docs/get-started/ios/react-native/flutter-gestures.webp)iOS

## Making HTTP network requests

[#](#making-http-network-requests)

Fetching data from the internet is common for most apps. And in Flutter,
the `http` package provides the simplest way to fetch data from the internet.


### How do I fetch data from API calls?

[#](#how-do-i-fetch-data-from-api-calls)

React Native provides the Fetch API for networking—you make a fetch request
and then receive the response to get the data.


js

```
// React Native
const [ipAddress, setIpAddress] = useState('')
​
const _getIPAddress = () => {
  fetch('https://httpbin.org/ip')
    .then(response => response.json())
    .then(responseJson => {
      setIpAddress(responseJson.origin);
    })
    .catch(error => {
      console.error(error);
    });
};

```

content\_copy

Flutter uses the `http` package.

To add the `http` package as a dependency, run `flutter pub add`:

```
$ flutter pub add http

```

content\_copy

Flutter uses the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html)
core HTTP support client.
To create an HTTP Client, import `dart:io`.


dart

```
import 'dart:io';

```

content\_copy

The client supports the following HTTP operations:
GET, POST, PUT, and DELETE.


dart

```
final url = Uri.parse('https://httpbin.org/ip');
final httpClient = HttpClient();
​
Future<void> getIPAddress() async {
  final request = await httpClient.getUrl(url);
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  final ip = jsonDecode(responseBody)['origin'] as String;
  setState(() {
    _ipAddress = ip;
  });
}

```

content\_copy

![API calls on Android](/assets/images/docs/get-started/android/react-native/api-calls.webp)Android

![API calls on iOS](/assets/images/docs/get-started/ios/react-native/api-calls.webp)iOS

## Form input

[#](#form-input)

Text fields allow users to type text into your app so they can be
used to build forms, messaging apps, search experiences, and more.
Flutter provides two core text field widgets:
[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
and [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html).


### How do I use text field widgets?

[#](#how-do-i-use-text-field-widgets)

In React Native, to enter text you use a `TextInput` component to show a text
input box and then use the callback to store the value in a variable.


js

```
// React Native
const [password, setPassword] = useState('')
...
<TextInput
  placeholder="Enter your Password"
  onChangeText={password => setPassword(password)}
/>
<Button title="Submit" onPress={this.validate} />

```

content\_copy

In Flutter, use the [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)

class to manage a `TextField` widget.
Whenever the text field is modified,
the controller notifies its listeners.


Listeners read the text and selection properties to
learn what the user typed into the field.
You can access the text in `TextField`
by the `text` property of the controller.


dart

```
final TextEditingController _controller = TextEditingController();
​
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Type something',
          labelText: 'Text Field',
        ),
      ),
      ElevatedButton(
        child: const Text('Submit'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: Text('You typed ${_controller.text}'),
              );
            },
          );
        },
      ),
    ],
  );
}

```

content\_copy

In this example, when a user clicks on the submit button an alert dialog
displays the current text entered in the text field.
This is achieved using an [`AlertDialog`](https://api.flutter.dev/flutter/material/AlertDialog-class.html)

widget that displays the alert message, and the text from
the `TextField` is accessed by the `text` property of the
[`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html).


### How do I use Form widgets?

[#](#how-do-i-use-form-widgets)

In Flutter, use the [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html)
widget where
[`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html)
widgets along with the submit
button are passed as children.
The `TextFormField` widget has a parameter called
[`onSaved`](https://api.flutter.dev/flutter/widgets/FormField/onSaved.html)
that takes a callback and executes
when the form is saved. A `FormState`
object is used to save, reset, or validate
each `FormField` that is a descendant of this `Form`.
To obtain the `FormState`, you can use `Form.of()`
with a context whose ancestor is the `Form`,
or pass a `GlobalKey` to the `Form` constructor and call
`GlobalKey.currentState()`.


dart

```
@override
Widget build(BuildContext context) {
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value != null && value.contains('@')) {
              return null;
            }
            return 'Not a valid email.';
          },
          onSaved: (val) {
            _email = val;
          },
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            labelText: 'Email',
          ),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Login')),
      ],
    ),
  );
}

```

content\_copy

The following example shows how `Form.save()` and `formKey`
(which is a `GlobalKey`), are used to save the form on submit.


dart

```
void _submit() {
  final form = formKey.currentState;
  if (form != null && form.validate()) {
    form.save();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text('Email: $_email, password: $_password'),
        );
      },
    );
  }
}

```

content\_copy

![Input on Android](/assets/images/docs/get-started/android/react-native/input-fields.webp)Android

![Input on iOS](/assets/images/docs/get-started/ios/react-native/input-fields.webp)iOS

## Platform-specific code

[#](#platform-specific-code)

When building a cross-platform app, you want to re-use as much code as
possible across platforms. However, scenarios might arise where it
makes sense for the code to be different depending on the OS.
This requires a separate implementation by declaring a specific platform.


In React Native, the following implementation would be used:

js

```
// React Native
if (Platform.OS === 'ios') {
  return 'iOS';
} else if (Platform.OS === 'android') {
  return 'android';
} else {
  return 'not recognised';
}

```

content\_copy

In Flutter, use the following implementation:

dart

```
final platform = Theme.of(context).platform;
if (platform == TargetPlatform.iOS) {
  return 'iOS';
}
if (platform == TargetPlatform.android) {
  return 'android';
}
if (platform == TargetPlatform.fuchsia) {
  return 'fuchsia';
}
return 'not recognized ';

```

content\_copy

## Debugging

[#](#debugging)

### What tools can I use to debug my app in Flutter?

[#](#what-tools-can-i-use-to-debug-my-app-in-flutter)

Use the [DevTools](/tools/devtools) suite for debugging Flutter or Dart apps.

DevTools includes support for profiling, examining the heap,
inspecting the widget tree, logging diagnostics, debugging,
observing executed lines of code, debugging memory leaks and memory
fragmentation. For more information, check out the
[DevTools](/tools/devtools) documentation.


If you're using an IDE,
you can debug your application using the IDE's debugger.


### How do I perform a hot reload?

[#](#how-do-i-perform-a-hot-reload)

Flutter's Stateful Hot Reload feature helps you quickly and easily experiment,
build UIs, add features, and fix bugs. Instead of recompiling your app
every time you make a change, you can hot reload your app instantly.
The app is updated to reflect your change,
and the current state of the app is preserved.


First, from your preferred IDE,
enable autosave and hot reloads on save.


**VS Code**

Add the following to your `.vscode/settings.json` file:

`json     "files.autoSave": "afterDelay",     "dart.flutterHotReloadOnSave": "all",     ` **Android Studio and IntelliJ**

\\* Open `Settings > Tools > Actions on Save` and select
`Configure autosave options`.
\- Check the option to `Save files if the IDE is idle for X seconds`.
\- **Recommended:** Set a small delay duration. For example, 2 seconds.


\\* Open `Settings > Languages & Frameworks > Flutter`.
\- Check the option to `Perform hot reload on save`.


In React Native,
the shortcut is ⌘R for the iOS Simulator and tapping R twice on
Android emulators.


In Flutter, if you are using IntelliJ IDE or Android Studio,
you can select Save All (⌘s/ctrl-s), or you can click the
Hot Reload button on the toolbar. If you
are running the app at the command line using `flutter run`,
type `r` in the Terminal window.
You can also perform a full restart by typing `R` in the
Terminal window.


### How do I access the in-app developer menu?

[#](#how-do-i-access-the-in-app-developer-menu)

In React Native, the developer menu can be accessed by shaking your device: ⌘D
for the iOS Simulator or ⌘M for Android emulator.


In Flutter, if you are using an IDE, you can use the IDE tools. If you start
your application using `flutter run` you can also access the menu by typing
`h`
in the terminal window, or type the following shortcuts:


ActionTerminal ShortcutDebug functions and propertiesWidget hierarchy of the app`w`debugDumpApp()Rendering tree of the app`t`debugDumpRenderTree()Layers`L`debugDumpLayerTree()Accessibility`S` (traversal order) or

`U` (inverse hit test order)debugDumpSemantics()To toggle the widget inspector`i`WidgetsApp. showWidgetInspectorOverrideTo toggle the display of construction lines`p`debugPaintSizeEnabledTo simulate different operating systems`o`defaultTargetPlatformTo display the performance overlay`P`WidgetsApp. showPerformanceOverlayTo save a screenshot to flutter. png`s`To quit`q`

## Animation

[#](#animation)

Well-designed animation makes a UI feel intuitive,
contributes to the look and feel of a polished app,
and improves the user experience.
Flutter's animation support makes it easy
to implement simple and complex animations.
The Flutter SDK includes many Material Design widgets
that include standard motion effects,
and you can easily customize these effects
to personalize your app.


In React Native, Animated APIs are used to create animations.

In Flutter, use the [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html)

class and the [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
class.
`Animation` is an abstract class that understands its
current value and its state (completed or dismissed).
The `AnimationController` class lets you
play an animation forward or in reverse,
or stop animation and set the animation
to a specific value to customize the motion.


### How do I add a simple fade-in animation?

[#](#how-do-i-add-a-simple-fade-in-animation)

In the React Native example below, an animated component,
`FadeInView` is created using the Animated API.
The initial opacity state, final state, and the
duration over which the transition occurs are defined.
The animation component is added inside the `Animated` component,
the opacity state `fadeAnim` is mapped
to the opacity of the `Text` component that we want to animate,
and then, `start()` is called to start the animation.


js

```
// React Native
const FadeInView = ({ style, children }) => {
  const fadeAnim = useRef(new Animated.Value(0)).current;
​
  useEffect(() => {
    Animated.timing(fadeAnim, {
      toValue: 1,
      duration: 10000
    }).start();
  }, []);
​
  return (
    <Animated.View style={{ ...style, opacity: fadeAnim }}>
      {children}
    </Animated.View>
  );
};
    ...
<FadeInView>
  <Text> Fading in </Text>
</FadeInView>
    ...

```

content\_copy

To create the same animation in Flutter, create an
[`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
object named `controller`
and specify the duration. By default, an `AnimationController`
linearly produces values that range from 0.0 to 1.0,
during a given duration. The animation controller generates a new value
whenever the device running your app is ready to display a new frame.
Typically, this rate is around 60 values per second.


When defining an `AnimationController`,
you must pass in a `vsync` object.
The presence of `vsync` prevents offscreen
animations from consuming unnecessary resources.
You can use your stateful object as the `vsync` by adding
`TickerProviderStateMixin` to the class definition.
An `AnimationController` needs a TickerProvider,
which is configured using the `vsync` argument on the constructor.


A [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) describes the interpolation between a
beginning and ending value or the mapping from an input
range to an output range. To use a `Tween` object
with an animation, call the `Tween` object's `animate()`
method and pass it the `Animation` object that you want to modify.


For this example, a [`FadeTransition`](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html)

widget is used and the `opacity` property is
mapped to the `animation` object.


To start the animation, use `controller.forward()`.
Other operations can also be performed using the
controller such as `fling()` or `repeat()`.
For this example, the [`FlutterLogo`](https://api.flutter.dev/flutter/material/FlutterLogo-class.html)

widget is used inside the `FadeTransition` widget.


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const Center(child: LogoFade()));
}
​
class LogoFade extends StatefulWidget {
  const LogoFade({super.key});
​
  @override
  State<LogoFade> createState() => _LogoFadeState();
}
​
class _LogoFadeState extends State<LogoFade>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
​
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);
    controller.forward();
  }
​
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
​
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: const SizedBox(height: 300, width: 300, child: FlutterLogo()),
    );
  }
}

```

content\_copy

![Flutter fade on Android](/assets/images/docs/get-started/android/react-native/flutter-fade.webp)Android

![Flutter fade on iOS](/assets/images/docs/get-started/ios/react-native/flutter-fade.webp)iOS

### How do I add swipe animation to cards?

[#](#how-do-i-add-swipe-animation-to-cards)

In React Native, either the `PanResponder` or
third-party libraries are used for swipe animation.


In Flutter, to add a swipe animation, use the
[`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html)
widget and nest the child widgets.


dart

```
return Dismissible(
  key: Key(widget.key.toString()),
  onDismissed: (dismissDirection) {
    cards.removeLast();
  },
  child: Container(
    //...
  ),
);

```

content\_copy

![Card swipe on Android](/assets/images/docs/get-started/android/react-native/card-swipe.webp)Android

![Card swipe on iOS](/assets/images/docs/get-started/ios/react-native/card-swipe.webp)iOS

## React Native and Flutter widget equivalent components

[#](#react-native-and-flutter-widget-equivalent-components)

The following table lists commonly-used React Native
components mapped to the corresponding Flutter widget
and common widget properties.


React Native ComponentFlutter WidgetDescription[`Button`](https://reactnative.dev/docs/button)[`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)A basic raised button.onPressed \[required\]The callback when the button is tapped or otherwise activated.ChildThe button's label.[`Button`](https://reactnative.dev/docs/button)[`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html)A basic flat button.onPressed \[required\]The callback when the button is tapped or otherwise activated.ChildThe button's label.[`ScrollView`](https://reactnative.dev/docs/scrollview)[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html)A scrollable list of widgets arranged linearly.children( <Widget> \[ \]) List of child widgets to display.controller
\[
[`ScrollController`](https://api.flutter.dev/flutter/widgets/ScrollController-class.html)
\] An object that can be used to control a scrollable widget.
itemExtent\[ double \] If non-null, forces the children to have the given extent in the scroll direction.scroll Direction
\[
[`Axis`](https://api.flutter.dev/flutter/painting/Axis.html)
\] The axis along which the scroll view scrolls.
[`FlatList`](https://reactnative.dev/docs/flatlist)[`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html)The constructor for a linear array of widgets that are created on demand.itemBuilder \[required\]
\[
[`IndexedWidgetBuilder`](https://api.flutter.dev/flutter/widgets/IndexedWidgetBuilder.html)
\] helps in building the children on demand. This callback is called only with indices greater than or equal to zero and less than the itemCount.
itemCount\[ int \] improves the ability of the `ListView` to estimate the maximum scroll extent.[`Image`](https://reactnative.dev/docs/image)[`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html)A widget that displays an image.image \[required\]The image to display.Image. assetSeveral constructors are provided for the various ways that an image can be specified.width, height, color, alignmentThe style and layout for the image.fitInscribing the image into the space allocated during layout.[`Modal`](https://reactnative.dev/docs/modal)[`ModalRoute`](https://api.flutter.dev/flutter/widgets/ModalRoute-class.html)A route that blocks interaction with previous routes.animationThe animation that drives the route's transition and the previous route's forward transition.[`ActivityIndicator`](https://reactnative.dev/docs/activityindicator)[`CircularProgressIndicator`](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html)A widget that shows progress along a circle.strokeWidthThe width of the line used to draw the circle.backgroundColor
The progress indicator's background color. The current theme's
`ThemeData.backgroundColor`
by default.
[`ActivityIndicator`](https://reactnative.dev/docs/activityindicator)[`LinearProgressIndicator`](https://api.flutter.dev/flutter/material/LinearProgressIndicator-class.html)A widget that shows progress along a line.valueThe value of this progress indicator.[`RefreshControl`](https://reactnative.dev/docs/refreshcontrol)[`RefreshIndicator`](https://api.flutter.dev/flutter/material/RefreshIndicator-class.html)A widget that supports the Material "swipe to refresh" idiom.colorThe progress indicator's foreground color.onRefresh
A function that's called when a user drags the refresh indicator far enough to demonstrate that they want the app to refresh.
[`View`](https://reactnative.dev/docs/view)[`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html)A widget that surrounds a child widget.[`View`](https://reactnative.dev/docs/view)[`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)A widget that displays its children in a vertical array.[`View`](https://reactnative.dev/docs/view)[`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html)A widget that displays its children in a horizontal array.[`View`](https://reactnative.dev/docs/view)[`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html)A widget that centers its child within itself.[`View`](https://reactnative.dev/docs/view)[`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html)A widget that insets its child by the given padding.padding \[required\]\[ EdgeInsets \] The amount of space to inset the child.[`TouchableOpacity`](https://reactnative.dev/docs/touchableopacity)[`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html)A widget that detects gestures.onTapA callback when a tap occurs.onDoubleTapA callback when a tap occurs at the same location twice in quick succession.[`TextInput`](https://reactnative.dev/docs/textinput)[`TextInput`](https://api.flutter.dev/flutter/services/TextInput-class.html)The interface to the system's text input control.controller
\[
[`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
\] used to access and modify text.
[`Text`](https://reactnative.dev/docs/text)[`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html)The Text widget that displays a string of text with a single style.data\[ String \] The text to display.textDirection
\[
[`TextAlign`](https://api.flutter.dev/flutter/dart-ui/TextAlign.html)
\] The direction in which the text flows.
[`Switch`](https://reactnative.dev/docs/switch)[`Switch`](https://api.flutter.dev/flutter/material/Switch-class.html)A material design switch.value \[required\]\[ boolean \] Whether this switch is on or off.onChanged \[required\]\[ callback \] Called when the user toggles the switch on or off.

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/flutter-for/react-native-devs.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/flutter-for/react-native-devs&page-source=https://github.com/flutter/website/blob/main/src/content/flutter-for/react-native-devs.md "Report an issue with this page").