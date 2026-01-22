---
name: flutter-for-xamarin-forms-developers
description: Learn how to apply Xamarin.Forms developer knowledge when building Flutter apps.
metadata:
  url: https://docs.flutter.dev/flutter-for/xamarin-forms-devs
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter for Xamarin.Forms developers

This document is meant for Xamarin.Forms developers
looking to apply their existing knowledge
to build mobile apps with Flutter.
If you understand the fundamentals of the Xamarin.Forms framework,
then you can use this document as a jump start to Flutter development.


Your Android and iOS knowledge and skill set
are valuable when building with Flutter,
because Flutter relies on the native operating system configurations,
similar to how you would configure your native Xamarin.Forms projects.
The Flutter Frameworks is also similar to how you create a single UI,
that is used on multiple platforms.


This document can be used as a cookbook by jumping around
and finding questions that are most relevant to your needs.


## Project setup

[#](#project-setup)

### How does the app start?

[#](#how-does-the-app-start)

For each platform in Xamarin.Forms,
you call the `LoadApplication` method,
which creates a new application and starts your app.


csharp

```
LoadApplication(new App());

```

content\_copy

In Flutter, the default main entry point is
`main` where you load your Flutter app.


dart

```
void main() {
  runApp(const MyApp());
}

```

content\_copy

In Xamarin.Forms, you assign a `Page` to the
`MainPage` property in the `Application` class.


csharp

```
public class App : Application
{
    public App()
    {
        MainPage = new ContentPage
        {
            Content = new Label
            {
                Text = "Hello World",
                HorizontalOptions = LayoutOptions.Center,
                VerticalOptions = LayoutOptions.Center
            }
        };
    }
}

```

content\_copy

In Flutter, "everything is a widget", even the application itself.
The following example shows `MyApp`, a simple application `Widget`.


dart

```
class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello World!', textDirection: TextDirection.ltr),
    );
  }
}

```

content\_copy

### How do you create a page?

[#](#how-do-you-create-a-page)

Xamarin.Forms has many types of pages;
`ContentPage` is the most common.
In Flutter, you specify an application widget that holds your root page.
You can use a [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
widget, which supports [Material Design](https://m3.material.io/styles),
or you can use a [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html)
widget, which supports an iOS-style app,
or you can use the lower level [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html),
which you can customize in any way you want.


The following code defines the home page, a stateful widget.
In Flutter, all widgets are immutable,
but two types of widgets are supported: _Stateful_ and _Stateless_.
Examples of a stateless widget are titles, icons, or images.


The following example uses `MaterialApp`,
which holds its root page in the `home` property.


dart

```
class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

```

content\_copy

From here, your actual first page is another `Widget`,
in which you create your state.


A _Stateful_ widget, such as `MyHomePage` below, consists of two parts.
The first part, which is itself immutable, creates a `State` object
that holds the state of the object. The `State` object persists over
the life of the widget.


dart

```
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
​
  final String title;
​
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

```

content\_copy

The `State` object implements the `build()` method for the stateful widget.

When the state of the widget tree changes, call `setState()`,
which triggers a build of that portion of the UI.
Make sure to call `setState()` only when necessary,
and only on the part of the widget tree that has changed,
or it can result in poor UI performance.


dart

```
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
​
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set the appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

```

content\_copy

In Flutter, the UI (also known as widget tree), is immutable,
meaning you can't change its state once it's built.
You change fields in your `State` class, then call `setState()`

to rebuild the entire widget tree again.


This way of generating UI is different from Xamarin.Forms,
but there are many benefits to this approach.


## Views

[#](#views)

### What is the equivalent of a Page or Element in Flutter?

[#](#what-is-the-equivalent-of-a-page-or-element-in-flutter)

How is react-style, or _declarative_, programming different from the
traditional imperative style?
For a comparison, see [Introduction to declarative UI](/get-started/flutter-for/declarative).


`ContentPage`, `TabbedPage`, `FlyoutPage` are all types of pages
you might use in a Xamarin.Forms application.
These pages would then hold `Element` s to display the various controls.
In Xamarin.Forms an `Entry` or `Button` are examples of an `Element`.


In Flutter, almost everything is a widget.
A `Page`, called a `Route` in Flutter, is a widget.
Buttons, progress bars, and animation controllers are all widgets.
When building a route, you create a widget tree.


Flutter includes the [Material Components](/ui/widgets/material) library.
These are widgets that implement the [Material Design guidelines](https://m3.material.io/styles).
Material Design is a flexible design system
[optimized for all platforms](https://m2.material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines), including iOS.


But Flutter is flexible and expressive enough
to implement any design language.
For example, on iOS, you can use the [Cupertino widgets](/ui/widgets/cupertino)

to produce an interface that looks like [Apple's iOS design language](https://developer.apple.com/design/resources/).


### How do I update widgets?

[#](#how-do-i-update-widgets)

In Xamarin.Forms, each `Page` or `Element` is a stateful class,
that has properties and methods.
You update your `Element` by updating a property,
and this is propagated down to the native control.


In Flutter, `Widget` s are immutable and you can't directly update them
by changing a property, instead you have to work with the widget's state.


This is where the concept of Stateful vs Stateless widgets comes from.
A `StatelessWidget` is just what it sounds like—
a widget with no state information.


`StatelessWidgets` are useful when the part of the user interface
you are describing doesn't depend on anything
other than the configuration information in the object.


For example, in Xamarin.Forms, this is similar
to placing an `Image` with your logo.
The logo is not going to change during runtime,
so use a `StatelessWidget` in Flutter.


If you want to dynamically change the UI based on data received
after making an HTTP call or a user interaction,
then you have to work with `StatefulWidget`
and tell the Flutter framework that
the widget's `State` has been updated,
so it can update that widget.


The important thing to note here is at the core
both stateless and stateful widgets behave the same.
They rebuild every frame, the difference is
the `StatefulWidget` has a `State` object
that stores state data across frames and restores it.


If you are in doubt, then always remember this rule: if a widget changes
(because of user interactions, for example) it's stateful.
However, if a widget reacts to change, the containing parent widget can
still be stateless if it doesn't itself react to change.


The following example shows how to use a `StatelessWidget`.
A common `StatelessWidget` is the `Text` widget.
If you look at the implementation of the `Text` widget
you'll find it subclasses `StatelessWidget`.


dart

```
const Text(
  'I like Flutter!',
  style: TextStyle(fontWeight: FontWeight.bold),
);

```

content\_copy

As you can see, the `Text` widget has no state information associated with it,
it renders what is passed in its constructors and nothing more.


But, what if you want to make "I Like Flutter" change dynamically,
for example, when clicking a `FloatingActionButton`?


To achieve this, wrap the `Text` widget in a `StatefulWidget`
and update it when the user clicks the button,
as shown in the following example:


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  /// Default placeholder text
  String textToShow = 'I Like Flutter';
​
  void _updateText() {
    setState(() {
      // Update the text
      textToShow = 'Flutter is Awesome!';
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}

```

content\_copy

### How do I lay out my widgets? What is the equivalent of an XAML file?

[#](#how-do-i-lay-out-my-widgets-what-is-the-equivalent-of-an-xaml-file)

In Xamarin.Forms, most developers write layouts in XAML,
though sometimes in C#.
In Flutter, you write your layouts with a widget tree in code.


The following example shows how to display a simple widget with padding:

dart

```
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sample App')),
    body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(left: 20, right: 30),
        ),
        onPressed: () {},
        child: const Text('Hello'),
      ),
    ),
  );
}

```

content\_copy

You can view the layouts that Flutter has to offer in the
[widget catalog](/ui/widgets/layout).


### How do I add or remove an Element from my layout?

[#](#how-do-i-add-or-remove-an-element-from-my-layout)

In Xamarin.Forms, you had to remove or add an `Element` in code.
This involved either setting the `Content` property or calling
`Add()` or `Remove()` if it was a list.


In Flutter, because widgets are immutable there is no direct equivalent.
Instead, you can pass a function to the parent that returns a widget,
and control that child's creation with a boolean flag.


The following example shows how to toggle between two widgets
when the user clicks the `FloatingActionButton`:


dart

```
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  /// Default value for toggle
  bool toggle = true;
  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }
​
  Widget _getToggleChild() {
    if (toggle) {
      return const Text('Toggle One');
    }
    return CupertinoButton(onPressed: () {}, child: const Text('Toggle Two'));
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(child: _getToggleChild()),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }
}

```

content\_copy

### How do I animate a widget?

[#](#how-do-i-animate-a-widget)

In Xamarin.Forms, you create simple animations using ViewExtensions that
include methods such as `FadeTo` and `TranslateTo`.
You would use these methods on a view
to perform the required animations.


xml

```
<Image Source="{Binding MyImage}" x:Name="myImage" />

```

content\_copy

Then in code behind, or a behavior, this would fade in the image,
over a 1-second period.


csharp

```
myImage.FadeTo(0, 1000);

```

content\_copy

In Flutter, you animate widgets using the animation library
by wrapping widgets inside an animated widget.
Use an `AnimationController`, which is an `Animation<double>`

that can pause, seek, stop and reverse the animation.
It requires a `Ticker` that signals when vsync happens,
and produces a linear interpolation between 0 and 1
on each frame while it's running.
You then create one or more `Animation` s and attach them to the controller.


For example, you might use `CurvedAnimation`
to implement an animation along an interpolated curve.
In this sense, the controller is the "master" source of the animation progress
and the `CurvedAnimation` computes the curve
that replaces the controller's default linear motion.
Like widgets, animations in Flutter work with composition.


When building the widget tree, you assign the `Animation`
to an animated property of a widget,
such as the opacity of a `FadeTransition`,
and tell the controller to start the animation.


The following example shows how to write a `FadeTransition` that fades
the widget into a logo when you press the `FloatingActionButton`:


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const FadeAppTest());
}
​
class FadeAppTest extends StatelessWidget {
  /// This widget is the root of your application.
  const FadeAppTest({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fade Demo',
      home: MyFadeTest(title: 'Fade Demo'),
    );
  }
}
​
class MyFadeTest extends StatefulWidget {
  const MyFadeTest({super.key, required this.title});
​
  final String title;
​
  @override
  State<MyFadeTest> createState() => _MyFadeTest();
}
​
class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation curve;
​
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(size: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
      ),
    );
  }
}

```

content\_copy

For more information, see [Animation & Motion widgets](/ui/widgets/animation),
the [Animations tutorial](/ui/animations/tutorial), and the [Animations overview](/ui/animations).


### How do I draw/paint on the screen?

[#](#how-do-i-drawpaint-on-the-screen)

Xamarin.Forms never had a built-in way to draw directly on the screen.
Many would use SkiaSharp, if they needed a custom image drawn.
In Flutter, you have direct access to the Skia Canvas
and can easily draw on screen.


Flutter has two classes that help you draw to the canvas: `CustomPaint`
and `CustomPainter`, the latter of which implements your algorithm to draw to
the canvas.


To learn how to implement a signature painter in Flutter,
see Collin's answer on [Custom Paint](https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter).


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const MaterialApp(home: DemoApp()));
}
​
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});
​
  @override
  Widget build(BuildContext context) => const Scaffold(body: Signature());
}
​
class Signature extends StatefulWidget {
  const Signature({super.key});
​
  @override
  SignatureState createState() => SignatureState();
}
​
class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];
​
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final RenderBox referenceBox = context.findRenderObject() as RenderBox;
      final Offset localPosition = referenceBox.globalToLocal(
        details.globalPosition,
      );
      _points = List.from(_points)..add(localPosition);
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: (details) => _points.add(null),
      child: CustomPaint(
        painter: SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}
​
class SignaturePainter extends CustomPainter {
  const SignaturePainter(this.points);
​
  final List<Offset?> points;
​
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }
​
  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}

```

content\_copy

### Where is the widget's opacity?

[#](#where-is-the-widgets-opacity)

On Xamarin.Forms, all `VisualElement` s have an Opacity.
In Flutter, you need to wrap a widget in an
[`Opacity` widget](https://api.flutter.dev/flutter/widgets/Opacity-class.html)
to accomplish this.


### How do I build custom widgets?

[#](#how-do-i-build-custom-widgets)

In Xamarin.Forms, you typically subclass `VisualElement`,
or use a pre-existing `VisualElement`, to override and
implement methods that achieve the desired behavior.


In Flutter, build a custom widget by [composing](/resources/architectural-overview#composition)

smaller widgets (instead of extending them).
It is somewhat similar to implementing a custom control
based off a `Grid` with numerous `VisualElement` s added in,
while extending with custom logic.


For example, how do you build a `CustomButton`
that takes a label in the constructor?
Create a CustomButton that composes a `ElevatedButton`
with a label, rather than by extending `ElevatedButton`:


dart

```
class CustomButton extends StatelessWidget {
  const CustomButton(this.label, {super.key});
​
  final String label;
​
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}

```

content\_copy

Then use `CustomButton`, just as you'd use any other Flutter widget:

dart

```
@override
Widget build(BuildContext context) {
  return const Center(child: CustomButton('Hello'));
}

```

content\_copy

## Navigation

[#](#navigation)

### How do I navigate between pages?

[#](#how-do-i-navigate-between-pages)

In Xamarin.Forms, the `NavigationPage` class
provides a hierarchical navigation experience
where the user is able to navigate through pages,
forwards and backwards.


Flutter has a similar implementation,
using a `Navigator` and `Routes`.
A `Route` is an abstraction for a `Page` of an app,
and a `Navigator` is a [widget](/resources/architectural-overview#widgets)
that manages routes.


A route roughly maps to a `Page`.
The navigator works in a similar way to the Xamarin.Forms `NavigationPage`,
in that it can `push()` and `pop()` routes depending on
whether you want to navigate to, or back from, a view.


To navigate between pages, you have a couple options:

- Specify a `Map` of route names. ( `MaterialApp`)
- Directly navigate to a route. ( `WidgetsApp`)

The following example builds a `Map`.

dart

```
void main() {
  runApp(
    MaterialApp(
      home: const MyAppHome(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/a': (context) => const MyPage(title: 'page A'),
        '/b': (context) => const MyPage(title: 'page B'),
        '/c': (context) => const MyPage(title: 'page C'),
      },
    ),
  );
}

```

content\_copy

Navigate to a route by pushing its name to the `Navigator`.

dart

```
Navigator.of(context).pushNamed('/b');

```

content\_copy

The `Navigator` is a stack that manages your app's routes.
Pushing a route to the stack moves to that route.
Popping a route from the stack, returns to the previous route.
This is done by awaiting on the `Future` returned by `push()`.


`async`/ `await` is very similar to the .NET implementation
and is explained in more detail in [Async UI](#async-ui).


For example, to start a `location` route
that lets the user select their location,
you might do the following:


dart

```
Object? coordinates = await Navigator.of(context).pushNamed('/location');

```

content\_copy

And then, inside your 'location' route, once the user has selected their
location, pop the stack with the result:


dart

```
Navigator.of(context).pop({'lat': 43.821757, 'long': -79.226392});

```

content\_copy

### How do I navigate to another app?

[#](#how-do-i-navigate-to-another-app)

In Xamarin.Forms, to send the user to another application,
you use a specific URI scheme, using `Device.OpenUrl("mailto://")`.


To implement this functionality in Flutter,
create a native platform integration, or use an [existing plugin](https://pub.dev/flutter),
such as [`url_launcher`](https://pub.dev/packages/url_launcher), available with many other packages on
[pub.dev](https://pub.dev).


## Async UI

[#](#async-ui)

### What is the equivalent of Device.BeginOnMainThread() in Flutter?

[#](#what-is-the-equivalent-of-device-beginonmainthread-in-flutter)

Dart has a single-threaded execution model,
with support for `Isolate` s (a way to run Dart codes on another thread),
an event loop, and asynchronous programming.
Unless you spawn an `Isolate`,
your Dart code runs in the main UI thread
and is driven by an event loop.


Dart's single-threaded model doesn't mean you need to run everything
as a blocking operation that causes the UI to freeze.
Much like Xamarin.Forms, you need to keep the UI thread free.
You would use `async`/ `await` to perform tasks,
where you must wait for the response.


In Flutter, use the asynchronous facilities that the Dart language provides,
also named `async`/ `await`, to perform asynchronous work.
This is very similar to C# and should be very easy to use
for any Xamarin.Forms developer.


For example, you can run network code without causing the UI to hang by
using `async`/ `await` and letting Dart do the heavy lifting:


dart

```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}

```

content\_copy

Once the awaited network call is done,
update the UI by calling `setState()`,
which triggers a rebuild of the widget subtree and updates the data.


The following example loads data asynchronously
and displays it in a `ListView`:


dart

```
import 'dart:convert';
​
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];
​
  @override
  void initState() {
    super.initState();
    loadData();
  }
​
  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }
​
  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}

```

content\_copy

Refer to the next section for more information
on doing work in the background,
and how Flutter differs from Android.


### How do you move work to a background thread?

[#](#how-do-you-move-work-to-a-background-thread)

Since Flutter is single threaded and runs an event loop,
you don't have to worry about thread management
or spawning background threads.
This is very similar to Xamarin.Forms.
If you're doing I/O-bound work, such as disk access or a network call,
then you can safely use `async`/ `await` and you're all set.


If, on the other hand, you need to do computationally intensive work
that keeps the CPU busy,
you want to move it to an `Isolate` to avoid blocking the event loop,
like you would keep _any_ sort of work out of the main thread.
This is similar to when you move things to a different
thread via `Task.Run()` in Xamarin.Forms.


For I/O-bound work, declare the function as an `async` function,
and `await` on long-running tasks inside the function:


dart

```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}

```

content\_copy

This is how you would typically do network or database calls,
which are both I/O operations.


However, there are times when you might be processing
a large amount of data and your UI hangs.
In Flutter, use `Isolate` s to take advantage of multiple CPU cores
to do long-running or computationally intensive tasks.


Isolates are separate execution threads that
do not share any memory with the main execution memory heap.
This is a difference between `Task.Run()`.
This means you can't access variables from the main thread,
or update your UI by calling `setState()`.


The following example shows, in a simple isolate,
how to share data back to the main thread to update the UI.


dart

```
Future<void> loadData() async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(dataLoader, receivePort.sendPort);
​
  // The 'echo' isolate sends its SendPort as the first message
  final SendPort sendPort = await receivePort.first as SendPort;
  final List<Map<String, dynamic>> msg = await sendReceive(
    sendPort,
    'https://jsonplaceholder.typicode.com/posts',
  );
  setState(() {
    data = msg;
  });
}
​
// The entry point for the isolate
static Future<void> dataLoader(SendPort sendPort) async {
  // Open the ReceivePort for incoming messages.
  final ReceivePort port = ReceivePort();
​
  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);
  await for (final dynamic msg in port) {
    final String url = msg[0] as String;
    final SendPort replyTo = msg[1] as SendPort;
​
    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    // Lots of JSON to parse
    replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
  }
}
​
Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
  final ReceivePort response = ReceivePort();
  port.send(<dynamic>[msg, response.sendPort]);
  return response.first as Future<List<Map<String, dynamic>>>;
}

```

content\_copy

Here, `dataLoader()` is the `Isolate` that runs in
its own separate execution thread.
In the isolate, you can perform more CPU intensive
processing (parsing a big JSON, for example),
or perform computationally intensive math,
such as encryption or signal processing.


You can run the full example below:

dart

```
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
​
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];
​
  @override
  void initState() {
    super.initState();
    loadData();
  }
​
  bool get showLoadingDialog => data.isEmpty;
​
  Future<void> loadData() async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
​
    // The 'echo' isolate sends its SendPort as the first message
    final SendPort sendPort = await receivePort.first as SendPort;
    final List<Map<String, dynamic>> msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );
    setState(() {
      data = msg;
    });
  }
​
  // The entry point for the isolate
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final ReceivePort port = ReceivePort();
​
    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);
    await for (final dynamic msg in port) {
      final String url = msg[0] as String;
      final SendPort replyTo = msg[1] as SendPort;
​
      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
    }
  }
​
  Future<List<Map<String, dynamic>>> sendReceive(SendPort port, String msg) {
    final ReceivePort response = ReceivePort();
    port.send(<dynamic>[msg, response.sendPort]);
    return response.first as Future<List<Map<String, dynamic>>>;
  }
​
  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }
    return getListView();
  }
​
  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }
​
  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }
​
  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
}

```

content\_copy

### How do I make network requests?

[#](#how-do-i-make-network-requests)

In Xamarin.Forms you would use `HttpClient`.
Making a network call in Flutter is easy
when you use the popular [`http` package](https://pub.dev/packages/http).
This abstracts away a lot of the networking
that you might normally implement yourself,
making it simple to make network calls.


To use the `http` package, add it to your dependencies in `pubspec.yaml`:

yaml

```
dependencies:
  http: ^1.4.0

```

content\_copy

To make a network request,
call `await` on the `async` function `http.get()`:


dart

```
Future<void> loadData() async {
  final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final http.Response response = await http.get(dataURL);
  setState(() {
    data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
  });
}

```

content\_copy

### How do I show the progress for a long-running task?

[#](#how-do-i-show-the-progress-for-a-long-running-task)

In Xamarin.Forms you would typically create a loading indicator,
either directly in XAML or through a 3rd party plugin such as AcrDialogs.


In Flutter, use a `ProgressIndicator` widget.
Show the progress programmatically by controlling
when it's rendered through a boolean flag.
Tell Flutter to update its state before your long-running task starts,
and hide it after it ends.


In the example below, the build function is separated into three different
functions. If `showLoadingDialog` is `true`
(when `widgets.length == 0`), then render the `ProgressIndicator`.
Otherwise, render the `ListView` with the data returned from a network call.


dart

```
import 'dart:async';
import 'dart:convert';
​
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Map<String, Object?>> data = [];
​
  @override
  void initState() {
    super.initState();
    loadData();
  }
​
  bool get showLoadingDialog => data.isEmpty;
​
  Future<void> loadData() async {
    final Uri dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final http.Response response = await http.get(dataURL);
    setState(() {
      data = (jsonDecode(response.body) as List).cast<Map<String, Object?>>();
    });
  }
​
  Widget getBody() {
    if (showLoadingDialog) {
      return getProgressDialog();
    }
    return getListView();
  }
​
  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }
​
  ListView getListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return getRow(index);
      },
    );
  }
​
  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text('Row ${data[index]['title']}'),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: getBody(),
    );
  }
}

```

content\_copy

## Project structure & resources

[#](#project-structure-resources)

### Where do I store my image files?

[#](#where-do-i-store-my-image-files)

Xamarin.Forms has no platform independent way of storing images,
you had to place images in the iOS `xcasset` folder,
or on Android in the various `drawable` folders.


While Android and iOS treat resources and assets as distinct items,
Flutter apps have only assets.
All resources that would live in the
`Resources/drawable-*` folders on Android,
are placed in an assets' folder for Flutter.


Flutter follows a simple density-based format like iOS.
Assets might be `1.0x`, `2.0x`, `3.0x`, or any other multiplier.
Flutter doesn't have `dp` s but there are logical pixels,
which are basically the same as device-independent pixels.
Flutter's [`devicePixelRatio`](https://api.flutter.dev/flutter/dart-ui/FlutterView/devicePixelRatio.html)
expresses the ratio
of physical pixels in a single logical pixel.


The equivalent to Android's density buckets are:

Android density qualifierFlutter pixel ratio`ldpi``0.75x``mdpi``1.0x``hdpi``1.5x``xhdpi``2.0x``xxhdpi``3.0x``xxxhdpi``4.0x`

Assets are located in any arbitrary folder—
Flutter has no predefined folder structure.
You declare the assets (with location)
in the `pubspec.yaml` file, and Flutter picks them up.


To add a new image asset called `my_icon.png` to our Flutter project,
for example, and deciding that it should live in a folder we
arbitrarily called `images`, you would put the base image (1.0x)
in the `images` folder, and all the other variants in sub-folders
called with the appropriate ratio multiplier:


```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image

```

content\_copy

Next, you'll need to declare these images in your `pubspec.yaml` file:

yaml

```
assets:
 - images/my_icon.png

```

content\_copy

You can directly access your images in an `Image.asset` widget:

dart

```
@override
Widget build(BuildContext context) {
  return Image.asset('images/my_icon.png');
}

```

content\_copy

or using `AssetImage`:

dart

```
@override
Widget build(BuildContext context) {
  return const Image(image: AssetImage('images/my_image.png'));
}

```

content\_copy

More detailed information can be found in [Adding assets and images](/ui/assets/assets-and-images).


### Where do I store strings? How do I handle localization?

[#](#where-do-i-store-strings-how-do-i-handle-localization)

Unlike .NET which has `resx` files,
Flutter doesn't currently have a dedicated system for handling strings.
At the moment, the best practice is to declare your copy text
in a class as static fields and access them from there. For example:


dart

```
class Strings {
  static const String welcomeMessage = 'Welcome To Flutter';
}

```

content\_copy

You can access your strings as such:

dart

```
Text(Strings.welcomeMessage);

```

content\_copy

By default, Flutter only supports US English for its strings.
If you need to add support for other languages,
include the `flutter_localizations` package.
You might also need to add Dart's [`intl`](https://pub.dev/packages/intl)

package to use i10n machinery, such as date/time formatting.


yaml

```
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any # Use version of intl from flutter_localizations.

```

content\_copy

To use the `flutter_localizations` package,
specify the `localizationsDelegates` and
`supportedLocales` on the app widget:


dart

```
import 'package:flutter_localizations/flutter_localizations.dart';
​
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        // Add app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale('en', 'US'), // English
        Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
    );
  }
}

```

content\_copy

The delegates contain the actual localized values,
while the `supportedLocales` defines which locales the app supports.
The above example uses a `MaterialApp`,
so it has both a `GlobalWidgetsLocalizations`
for the base widgets localized values,
and a `MaterialWidgetsLocalizations` for the Material widgets localizations.
If you use `WidgetsApp` for your app, you don't need the latter.
Note that these two delegates contain "default" values,
but you'll need to provide one or more delegates
for your own app's localizable copy,
if you want those to be localized too.


When initialized, the `WidgetsApp` (or `MaterialApp`)
creates a [`Localizations`](https://api.flutter.dev/flutter/widgets/Localizations-class.html)
widget for you,
with the delegates you specify.
The current locale for the device is always accessible
from the `Localizations` widget from the current context
(in the form of a `Locale` object), or using the [`Window.locale`](https://api.flutter.dev/flutter/dart-ui/Window/locale.html).


To access localized resources, use the `Localizations.of()` method
to access a specific localizations class that is provided by a given delegate.
Use the [`intl_translation`](https://pub.dev/packages/intl_translation)
package to extract translatable copy
to [arb](https://github.com/google/app-resource-bundle) files for translating, and importing them back into the app
for using them with `intl`.


For further details on internationalization and localization in Flutter,
see the [internationalization guide](/ui/internationalization), which has sample code
with and without the `intl` package.


### Where is my project file?

[#](#where-is-my-project-file)

In Xamarin.Forms you will have a `csproj` file.
The closest equivalent in Flutter is pubspec.yaml,
which contains package dependencies and various project details.
Similar to .NET Standard,
files within the same directory are considered part of the project.


### What is the equivalent of Nuget? How do I add dependencies?

[#](#what-is-the-equivalent-of-nuget-how-do-i-add-dependencies)

In the .NET ecosystem, native Xamarin projects and Xamarin.Forms projects
had access to Nuget and the built-in package management system.
Flutter apps contain a native Android app, native iOS app and Flutter app.


In Android, you add dependencies by adding to your Gradle build script.
In iOS, you add dependencies by adding to your `Podfile`.


Flutter uses Dart's own build system, and the Pub package manager.
The tools delegate the building of the native Android and iOS wrapper apps
to the respective build systems.


In general, use `pubspec.yaml` to declare
external dependencies to use in Flutter.
A good place to find Flutter packages is on [pub.dev](https://pub.dev).


## Application lifecycle

[#](#application-lifecycle)

### How do I listen to application lifecycle events?

[#](#how-do-i-listen-to-application-lifecycle-events)

In Xamarin.Forms, you have an `Application`
that contains `OnStart`, `OnResume` and `OnSleep`.
In Flutter, you can instead listen to similar lifecycle events
by hooking into the `WidgetsBinding` observer and listening to
the `didChangeAppLifecycleState()` change event.


The observable lifecycle events are:

`inactive`

The application is in an inactive state and is not receiving user input.
This event is iOS only.


`paused`

The application is not currently visible to the user,
is not responding to user input, but is running in the background.


`resumed`

The application is visible and responding to user input.

`suspending`

The application is suspended momentarily.
This event is Android only.


For more details on the meaning of these states,
see the [`AppLifecycleStatus` documentation](https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html).


## Layouts

[#](#layouts)

### What is the equivalent of a StackLayout?

[#](#what-is-the-equivalent-of-a-stacklayout)

In Xamarin.Forms you can create a `StackLayout`
with an `Orientation` of horizontal or vertical.
Flutter has a similar approach,
however you would use the `Row` or `Column` widgets.


If you notice the two code samples are identical
except the `Row` and `Column` widget.
The children are the same and this feature
can be exploited to develop rich layouts
that can change overtime with the same children.


dart

```
@override
Widget build(BuildContext context) {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}

```

content\_copy

dart

```
@override
Widget build(BuildContext context) {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Column One'),
      Text('Column Two'),
      Text('Column Three'),
      Text('Column Four'),
    ],
  );

```

content\_copy

### What is the equivalent of a Grid?

[#](#what-is-the-equivalent-of-a-grid)

The closest equivalent of a `Grid` would be a `GridView`.
This is much more powerful than what you are used to in Xamarin.Forms.
A `GridView` provides automatic scrolling when the
content exceeds its viewable space.


dart

```
@override
Widget build(BuildContext context) {
  return GridView.count(
    // Create a grid with 2 columns. If you change the scrollDirection to
    // horizontal, this would produce 2 rows.
    crossAxisCount: 2,
    // Generate 100 widgets that display their index in the list.
    children: List<Widget>.generate(100, (index) {
      return Center(
        child: Text(
          'Item $index',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      );
    }),
  );
}

```

content\_copy

You might have used a `Grid` in Xamarin.Forms
to implement widgets that overlay other widgets.
In Flutter, you accomplish this with the `Stack` widget.


This sample creates two icons that overlap each other.

dart

```
@override
Widget build(BuildContext context) {
  return const Stack(
    children: <Widget>[
      Icon(Icons.add_box, size: 24, color: Colors.black),
      Positioned(
        left: 10,
        child: Icon(Icons.add_circle, size: 24, color: Colors.black),
      ),
    ],
  );
}

```

content\_copy

### What is the equivalent of a ScrollView?

[#](#what-is-the-equivalent-of-a-scrollview)

In Xamarin.Forms, a `ScrollView` wraps around a `VisualElement`,
and if the content is larger than the device screen, it scrolls.


In Flutter, the closest match is the `SingleChildScrollView` widget.
You simply fill the Widget with the content that you want to be scrollable.


dart

```
@override
Widget build(BuildContext context) {
  return const SingleChildScrollView(child: Text('Long Content'));
}

```

content\_copy

If you have many items you want to wrap in a scroll,
even of different `Widget` types, you might want to use a `ListView`.
This might seem like overkill, but in Flutter this is
far more optimized and less intensive than a Xamarin.Forms `ListView`,
which is backing on to platform specific controls.


dart

```
@override
Widget build(BuildContext context) {
  return ListView(
    children: const <Widget>[
      Text('Row One'),
      Text('Row Two'),
      Text('Row Three'),
      Text('Row Four'),
    ],
  );
}

```

content\_copy

### How do I handle landscape transitions in Flutter?

[#](#how-do-i-handle-landscape-transitions-in-flutter)

Landscape transitions can be handled automatically by setting the
`configChanges` property in the AndroidManifest.xml:


xml

```
<activity android:configChanges="orientation|screenSize" />

```

content\_copy

## Gesture detection and touch event handling

[#](#gesture-detection-and-touch-event-handling)

### How do I add GestureRecognizers to a widget in Flutter?

[#](#how-do-i-add-gesturerecognizers-to-a-widget-in-flutter)

In Xamarin.Forms, `Element` s might contain a click event you can attach to.
Many elements also contain a `Command` that is tied to this event.
Alternatively you would use the `TapGestureRecognizer`.
In Flutter there are two very similar ways:


1. If the widget supports event detection, pass a function to it and
    handle it in the function. For example, the ElevatedButton has an
    `onPressed` parameter:



   dart

   ```
   @override
   Widget build(BuildContext context) {
     return ElevatedButton(
       onPressed: () {
         developer.log('click');
       },
       child: const Text('Button'),
     );
   }

   ```

   content\_copy

2. If the widget doesn't support event detection, wrap the
    widget in a `GestureDetector` and pass a function
    to the `onTap` parameter.



   dart

   ```
   class SampleApp extends StatelessWidget {
     const SampleApp({super.key});
   ​
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         body: Center(
           child: GestureDetector(
             onTap: () {
               developer.log('tap');
             },
             child: const FlutterLogo(size: 200),
           ),
         ),
       );
     }
   }

   ```

   content\_copy


### How do I handle other gestures on widgets?

[#](#how-do-i-handle-other-gestures-on-widgets)

In Xamarin.Forms you would add a `GestureRecognizer` to the `View`.
You would normally be limited to `TapGestureRecognizer`,
`PinchGestureRecognizer`, `PanGestureRecognizer`, `SwipeGestureRecognizer`,
`DragGestureRecognizer` and `DropGestureRecognizer` unless you built your own.


In Flutter, using the GestureDetector,
you can listen to a wide range of Gestures such as:


- Tap

`onTapDown`

A pointer that might cause a tap
has contacted the screen at a particular location.


`onTapUp`

A pointer that triggers a tap
has stopped contacting the screen at a particular location.


`onTap`

A tap has occurred.

`onTapCancel`

The pointer that previously triggered the `onTapDown`
won't cause a tap.


- Double tap

`onDoubleTap`

The user tapped the screen at the same location twice
in quick succession.


- Long press

`onLongPress`

A pointer has remained in contact with the screen
at the same location for a long period of time.


- Vertical drag

`onVerticalDragStart`

A pointer has contacted the screen and might begin to move vertically.

`onVerticalDragUpdate`

A pointer in contact with the screen
has moved further in the vertical direction.


`onVerticalDragEnd`

A pointer that was previously in contact with the
screen and moving vertically is no longer in contact
with the screen and was moving at a specific velocity
when it stopped contacting the screen.


- Horizontal drag

`onHorizontalDragStart`

A pointer has contacted the screen and might begin to move horizontally.

`onHorizontalDragUpdate`

A pointer in contact with the screen
has moved further in the horizontal direction.


`onHorizontalDragEnd`

A pointer that was previously in contact with the
screen and moving horizontally is no longer in contact
with the screen and was moving at a specific velocity
when it stopped contacting the screen.


The following example shows a `GestureDetector`
that rotates the Flutter logo on a double tap:


dart

```
class RotatingFlutterDetector extends StatefulWidget {
  const RotatingFlutterDetector({super.key});
​
  @override
  State<RotatingFlutterDetector> createState() =>
      _RotatingFlutterDetectorState();
}
​
class _RotatingFlutterDetectorState extends State<RotatingFlutterDetector>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation curve;
​
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: RotationTransition(
            turns: curve,
            child: const FlutterLogo(size: 200),
          ),
        ),
      ),
    );
  }
}

```

content\_copy

## Listviews and adapters

[#](#listviews-and-adapters)

### What is the equivalent to a ListView in Flutter?

[#](#what-is-the-equivalent-to-a-listview-in-flutter)

The equivalent to a `ListView` in Flutter is … a `ListView`!

In a Xamarin.Forms `ListView`, you create a `ViewCell`
and possibly a `DataTemplateSelector` and pass it into the `ListView`,
which renders each row with what your
`DataTemplateSelector` or `ViewCell` returns.
However, you often have to make sure you turn on Cell Recycling
otherwise you will run into memory issues and slow scrolling speeds.


Due to Flutter's immutable widget pattern,
you pass a list of widgets to your `ListView`,
and Flutter takes care of making sure that scrolling is fast and smooth.


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatelessWidget {
  const SampleAppPage({super.key});
​
  List<Widget> _getListData() {
    return List<Widget>.generate(
      100,
      (index) =>
          Padding(padding: const EdgeInsets.all(10), child: Text('Row $index')),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: _getListData()),
    );
  }
}

```

content\_copy

### How do I know which list item has been clicked?

[#](#how-do-i-know-which-list-item-has-been-clicked)

In Xamarin.Forms, the ListView has an `ItemTapped` method
to find out which item was clicked.
There are many other techniques you might have used
such as checking when `SelectedItem` or `EventToCommand`
behaviors change.


In Flutter, use the touch handling provided by the passed-in widgets.

dart

```
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> _getListData() {
    return List<Widget>.generate(
      100,
      (index) => GestureDetector(
        onTap: () {
          developer.log('Row $index tapped');
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Row $index'),
        ),
      ),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: _getListData()),
    );
  }
}

```

content\_copy

### How do I update a ListView dynamically?

[#](#how-do-i-update-a-listview-dynamically)

In Xamarin.Forms, if you bound the
`ItemsSource` property to an `ObservableCollection`,
you would just update the list in your ViewModel.
Alternatively, you could assign a new `List` to the `ItemSource`
property.


In Flutter, things work a little differently.
If you update the list of widgets inside a `setState()` method,
you would quickly see that your data did not change visually.
This is because when `setState()` is called,
the Flutter rendering engine looks at the widget tree
to see if anything has changed.
When it gets to your `ListView`, it performs a `==` check,
and determines that the two `ListView` s are the same.
Nothing has changed, so no update is required.


For a simple way to update your `ListView`,
create a new `List` inside of `setState()`,
and copy the data from the old list to the new list.
While this approach is simple, it is not recommended for large data sets,
as shown in the next example.


dart

```
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = <Widget>[];
​
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }
​
  Widget getRow(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets = List<Widget>.from(widgets);
          widgets.add(getRow(widgets.length));
          developer.log('Row $index');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $index'),
      ),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView(children: widgets),
    );
  }
}

```

content\_copy

The recommended, efficient, and effective way to build a list
uses a `ListView.Builder`.
This method is great when you have a dynamic list
or a list with very large amounts of data.
This is essentially the equivalent of RecyclerView on Android,
which automatically recycles list elements for you:


dart

```
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  List<Widget> widgets = [];
​
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }
​
  Widget getRow(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('Row $index');
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Row $index'),
      ),
    );
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return getRow(index);
        },
      ),
    );
  }
}

```

content\_copy

Instead of creating a `ListView`, create a `ListView.builder`
that takes two key parameters: the initial length of the list,
and an item builder function.


The item builder function is similar to the `getView` function
in an Android adapter; it takes a position,
and returns the row you want rendered at that position.


Finally, but most importantly, notice that the `onTap()` function
doesn't recreate the list anymore, but instead adds to it.


For more information, see
[Your first Flutter app](https://codelabs.developers.google.com/codelabs/flutter-codelab-first)
codelab.


## Working with text

[#](#working-with-text)

### How do I set custom fonts on my text widgets?

[#](#how-do-i-set-custom-fonts-on-my-text-widgets)

In Xamarin.Forms, you would have to add a custom font in each native project.
Then, in your `Element` you would assign this font name
to the `FontFamily` attribute using `filename#fontname`
and just `fontname` for iOS.


In Flutter, place the font file in a folder and reference it
in the `pubspec.yaml` file, similar to how you import images.


yaml

```
fonts:
  - family: MyCustomFont
    fonts:
      - asset: fonts/MyCustomFont.ttf
      - style: italic

```

content\_copy

Then assign the font to your `Text` widget:

dart

```
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Sample App')),
    body: const Center(
      child: Text(
        'This is a custom font text',
        style: TextStyle(fontFamily: 'MyCustomFont'),
      ),
    ),
  );
}

```

content\_copy

### How do I style my text widgets?

[#](#how-do-i-style-my-text-widgets)

Along with fonts, you can customize other styling elements on a `Text` widget.
The style parameter of a `Text` widget takes a `TextStyle` object,
where you can customize many parameters, such as:


- `color`
- `decoration`
- `decorationColor`
- `decorationStyle`
- `fontFamily`
- `fontSize`
- `fontStyle`
- `fontWeight`
- `hashCode`
- `height`
- `inherit`
- `letterSpacing`
- `textBaseline`
- `wordSpacing`

## Form input

[#](#form-input)

### How do I retrieve user input?

[#](#how-do-i-retrieve-user-input)

Xamarin.Forms `element` s allow you to directly query the `element`
to determine the state of its properties,
or whether it's bound to a property in a `ViewModel`.


Retrieving information in Flutter is handled by specialized widgets
and is different from how you are used to.
If you have a `TextField` or a `TextFormField`,
you can supply a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)

to retrieve user input:


dart

```
import 'package:flutter/material.dart';
​
class MyForm extends StatefulWidget {
  const MyForm({super.key});
​
  @override
  State<MyForm> createState() => _MyFormState();
}
​
class _MyFormState extends State<MyForm> {
  /// Create a text controller and use it to retrieve the current value
  /// of the TextField.
  final TextEditingController myController = TextEditingController();
​
  @override
  void dispose() {
    // Clean up the controller when disposing of the widget.
    myController.dispose();
    super.dispose();
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text that the user has typed into our text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text that the user has entered using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}

```

content\_copy

You can find more information and the full code listing in
[Retrieve the value of a text field](/cookbook/forms/retrieve-input).


### What is the equivalent of a Placeholder on an Entry?

[#](#what-is-the-equivalent-of-a-placeholder-on-an-entry)

In Xamarin.Forms, some `Elements` support a `Placeholder` property
that you can assign a value to. For example:


xml

```
<Entry Placeholder="This is a hint">

```

content\_copy

In Flutter, you can easily show a "hint" or a placeholder text
for your input by adding an `InputDecoration` object
to the `decoration` constructor parameter for the text widget.


dart

```
TextField(decoration: InputDecoration(hintText: 'This is a hint')),

```

content\_copy

### How do I show validation errors?

[#](#how-do-i-show-validation-errors)

With Xamarin.Forms, if you wished to provide a visual hint of a
validation error, you would need to create new properties and
`VisualElement` s surrounding the `Element` s that had validation errors.


In Flutter, you pass through an InputDecoration object to the
decoration constructor for the text widget.


However, you don't want to start off by showing an error.
Instead, when the user has entered invalid data,
update the state, and pass a new `InputDecoration` object.


dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const SampleApp());
}
​
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
  const SampleApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sample App', home: SampleAppPage());
  }
}
​
class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key});
​
  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}
​
class _SampleAppPageState extends State<SampleAppPage> {
  String? _errorText;
​
  String? _getErrorText() {
    return _errorText;
  }
​
  bool isEmail(String em) {
    const String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
        r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(emailRegexp);
    return regExp.hasMatch(em);
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App')),
      body: Center(
        child: TextField(
          onSubmitted: (text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'This is a hint',
            errorText: _getErrorText(),
          ),
        ),
      ),
    );
  }
}

```

content\_copy

## Flutter plugins

[#](#flutter-plugins)

## Interacting with hardware, third party services, and the platform

[#](#interacting-with-hardware-third-party-services-and-the-platform)

### How do I interact with the platform, and with platform native code?

[#](#how-do-i-interact-with-the-platform-and-with-platform-native-code)

Flutter doesn't run code directly on the underlying platform;
rather, the Dart code that makes up a Flutter app is run natively
on the device, "sidestepping" the SDK provided by the platform.
That means, for example, when you perform a network request in Dart,
it runs directly in the Dart context.
You don't use the Android or iOS APIs
you normally take advantage of when writing native apps.
Your Flutter app is still hosted in a native app's
`ViewController` or `Activity` as a view,
but you don't have direct access to this, or the native framework.


This doesn't mean Flutter apps can't interact with those native APIs,
or with any native code you have. Flutter provides [platform channels](/platform-integration/platform-channels)

that communicate and exchange data with the
`ViewController` or `Activity` that hosts your Flutter view.
Platform channels are essentially an asynchronous messaging mechanism
that bridges the Dart code with the host `ViewController`
or `Activity` and the iOS or Android framework it runs on.
You can use platform channels to execute a method on the native side,
or to retrieve some data from the device's sensors, for example.


In addition to directly using platform channels,
you can use a variety of pre-made [plugins](/packages-and-plugins/using-packages)

that encapsulate the native and Dart code for a specific goal.
For example, you can use a plugin to access
the camera roll and the device camera directly from Flutter,
without having to write your own integration.
Plugins are found on [pub.dev](https://pub.dev),
Dart and Flutter's open source package repository.
Some packages might support native integrations on iOS,
or Android, or both.


If you can't find a plugin on pub.dev that fits your needs,
you can [write your own](/packages-and-plugins/developing-packages), and
[publish it on pub.dev](/packages-and-plugins/developing-packages#publish).


### How do I access the GPS sensor?

[#](#how-do-i-access-the-gps-sensor)

Use the [`geolocator`](https://pub.dev/packages/geolocator) community plugin.

### How do I access the camera?

[#](#how-do-i-access-the-camera)

The [`camera`](https://pub.dev/packages/camera) plugin is popular for accessing the camera.


### How do I log in with Facebook?

[#](#how-do-i-log-in-with-facebook)

To log in with Facebook, use the
[`flutter_facebook_login`](https://pub.dev/packages/flutter_facebook_login)
community plugin.


### How do I use Firebase features?

[#](#how-do-i-use-firebase-features)

Most Firebase functions are covered by [first party plugins](https://pub.dev/flutter/packages?q=firebase).
These plugins are first-party integrations, maintained by the Flutter team:


- [`google_mobile_ads`](https://pub.dev/packages/google_mobile_ads) for Google Mobile Ads for Flutter

- [`firebase_analytics`](https://pub.dev/packages/firebase_analytics) for Firebase Analytics

- [`firebase_auth`](https://pub.dev/packages/firebase_auth) for Firebase Auth
- [`firebase_database`](https://pub.dev/packages/firebase_database) for Firebase RTDB

- [`firebase_storage`](https://pub.dev/packages/firebase_storage) for Firebase Cloud Storage

- [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) for Firebase Messaging (FCM)

- [`flutter_firebase_ui`](https://pub.dev/packages/flutter_firebase_ui) for quick Firebase Auth integrations
   (Facebook, Google, Twitter and email)

- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) for Firebase Cloud Firestore


You can also find some third-party Firebase plugins on pub.dev
that cover areas not directly covered by the first-party plugins.


### How do I build my own custom native integrations?

[#](#how-do-i-build-my-own-custom-native-integrations)

If there is platform-specific functionality that Flutter
or its community plugins are missing,
you can build your own following the
[developing packages and plugins](/packages-and-plugins/developing-packages)
page.


Flutter's plugin architecture, in a nutshell,
is much like using an Event bus in Android:
you fire off a message and let the receiver process and emit a result
back to you. In this case, the receiver is code running on the native side
on Android or iOS.


## Themes (Styles)

[#](#themes-styles)

### How do I theme my app?

[#](#how-do-i-theme-my-app)

Flutter comes with a beautiful, built-in implementation of Material Design,
which handles much of the styling and theming needs
that you would typically do.


Xamarin.Forms does have a global `ResourceDictionary`
where you can share styles across your app.
Alternatively, there is Theme support currently in preview.


In Flutter, you declare themes in the top level widget.

To take full advantage of Material Components in your app,
you can declare a top level widget `MaterialApp`
as the entry point to your application.
`MaterialApp` is a convenience widget
that wraps a number of widgets that are commonly required
for applications implementing Material Design.
It builds upon a `WidgetsApp` by adding Material-specific functionality.


You can also use a `WidgetsApp` as your app widget,
which provides some of the same functionality,
but is not as rich as `MaterialApp`.


To customize the colors and styles of any child components,
pass a `ThemeData` object to the `MaterialApp` widget.
For example, in the following code,
the color scheme from seed is set to deepPurple and text selection color is red.


dart

```
class SampleApp extends StatelessWidget {
  /// This widget is the root of your application.
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

## Databases and local storage

[#](#databases-and-local-storage)

### How do I access shared preferences or UserDefaults?

[#](#how-do-i-access-shared-preferences-or-userdefaults)

Xamarin.Forms developers will likely be familiar with the
`Xam.Plugins.Settings` plugin.


In Flutter, access equivalent functionality using the
[`shared_preferences`](https://pub.dev/packages/shared_preferences)
plugin. This plugin wraps the
functionality of both `UserDefaults` and the Android
equivalent, `SharedPreferences`.


### How do I access SQLite in Flutter?

[#](#how-do-i-access-sqlite-in-flutter)

In Xamarin.Forms most applications would use the `sqlite-net-pcl`
plugin to access SQLite databases.


In Flutter, on macOS, Android, and iOS,
access this functionality using the
[`sqflite`](https://pub.dev/packages/sqflite) plugin.


## Debugging

[#](#debugging)

### What tools can I use to debug my app in Flutter?

[#](#what-tools-can-i-use-to-debug-my-app-in-flutter)

Use the [DevTools](/tools/devtools) suite for debugging Flutter or Dart apps.

DevTools includes support for profiling, examining the heap,
inspecting the widget tree, logging diagnostics, debugging,
observing executed lines of code,
debugging memory leaks and memory fragmentation.
For more information, check out the [DevTools](/tools/devtools) documentation.


## Notifications

[#](#notifications)

### How do I set up push notifications?

[#](#how-do-i-set-up-push-notifications)

In Android, you use Firebase Cloud Messaging to set up
push notifications for your app.


In Flutter, access this functionality using the
[`firebase_messaging`](https://pub.dev/packages/firebase_messaging)
plugin.
For more information on using the Firebase Cloud Messaging API, see the
[`firebase_messaging`](https://pub.dev/packages/firebase_messaging)
plugin documentation.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/flutter-for/xamarin-forms-devs.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/flutter-for/xamarin-forms-devs&page-source=https://github.com/flutter/website/blob/main/src/content/flutter-for/xamarin-forms-devs.md "Report an issue with this page").