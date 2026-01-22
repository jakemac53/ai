---
name: flutter-for-swiftui-developers
description: Learn how to apply SwiftUI developer knowledge when building Flutter apps.
metadata:
  url: https://docs.flutter.dev/flutter-for/swiftui-devs
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter for SwiftUI Developers

SwiftUI developers who want to write mobile apps using Flutter
should review this guide.
It explains how to apply existing SwiftUI knowledge to Flutter.


infoNote

If you instead have experience building apps for iOS with UIKit,
see [Flutter for UIKit developers](/get-started/flutter-for/uikit-devs).


Flutter is a framework for building cross-platform applications
that uses the Dart programming language.
To understand some differences between programming with Dart
and programming with Swift, see [Learning Dart as a Swift Developer](https://dart.dev/guides/language/coming-from/swift-to-dart)

and [Flutter concurrency for Swift developers](/get-started/flutter-for/dart-swift-concurrency).


Your SwiftUI knowledge and experience
are highly valuable when building with Flutter.


Flutter also makes a number of adaptations
to app behavior when running on iOS and macOS.
To learn how, see [Platform adaptations](/platform-integration/platform-adaptations).


lightbulbTip

To integrate Flutter code into an **existing** iOS app,
check out [Add Flutter to existing app](/add-to-app).


This document can be used as a cookbook by jumping around
and finding questions that are most relevant to your needs.
This guide embeds sample code.
By using the "Open in DartPad" button that appears on hover or focus,
you can open and run some of the examples on DartPad.


## Overview

[#](#overview)

As an introduction, watch the following video.
It outlines how Flutter works on iOS and how to use Flutter to build iOS apps.


[Watch on YouTube in a new tab: "Flutter for iOS developers"](https://www.youtube.com/watch/ceMsPBbcEGg)

Flutter and SwiftUI code describes how the UI looks and works.
Developers call this type of code a _declarative framework_.


### Views vs. Widgets

[#](#views-vs-widgets)

**SwiftUI** represents UI components as _views_.
You configure views using _modifiers_.


swift

```
Text("Hello, World!") // <-- This is a View
  .padding(10)        // <-- This is a modifier of that View

```

content\_copy

**Flutter** represents UI components as _widgets_.

Both views and widgets only exist until they need to be changed.
These languages call this property _immutability_.
SwiftUI represents a UI component property as a View modifier.
By contrast, Flutter uses widgets for both UI components and
their properties.


dart

```
Padding(                         // <-- This is a Widget
  padding: EdgeInsets.all(10.0), // <-- So is this
  child: Text("Hello, World!"),  // <-- This, too
)));

```

content\_copy

To compose layouts, both SwiftUI and Flutter nest UI components
within one another.
SwiftUI nests Views while Flutter nests Widgets.


### Layout process

[#](#layout-process)

**SwiftUI** lays out views using the following process:

1. The parent view proposes a size to its child view.
2. All subsequent child views:
   - propose a size to _their_ child's view
   - ask that child what size it wants
3. Each parent view renders its child view at the returned size.

**Flutter** differs somewhat with its process:

1. The parent widget passes constraints down to its children.
    Constraints include minimum and maximum values for height and width.

2. The child tries to decide its size. It repeats the same process with its own
    list of children:
   - It informs its child of the child's constraints.
   - It asks its child what size it wishes to be.
3. The parent lays out the child.
   - If the requested size fits in the constraints,
      the parent uses that size.
   - If the requested size doesn't fit in the constraints,
      the parent limits the height, width, or both to fit in
      its constraints.

Flutter differs from SwiftUI because the parent component can override
the child's desired size. The widget cannot have any size it wants.
It also cannot know or decide its position on screen as its parent
makes that decision.


To force a child widget to render at a specific size,
the parent must set tight constraints.
A constraint becomes tight when its constraint's minimum size value
equals its maximum size value.


In **SwiftUI**, views might expand to the available space or
limit their size to that of its content.
**Flutter** widgets behave in similar manner.


However, in Flutter parent widgets can offer unbounded constraints.
Unbounded constraints set their maximum values to infinity.


dart

```
UnboundedBox(
  child: Container(
      width: double.infinity, height: double.infinity, color: red),
)

```

content\_copy

If the child expands and it has unbounded constraints,
Flutter returns an overflow warning:


dart

```
UnconstrainedBox(
  child: Container(color: red, width: 4000, height: 50),
)

```

content\_copy

![When parents pass unbounded constraints to children, and the children are expanding, then there is an overflow warning.](/assets/images/docs/ui/layout/layout-14.png)

To learn how constraints work in Flutter,
see [Understanding constraints](/ui/layout/constraints).


### Design system

[#](#design-system)

Because Flutter targets multiple platforms, your app doesn't need
to conform to any design system.
Though this guide features [Material](https://m3.material.io/develop/flutter/)
widgets,
your Flutter app can use many different design systems:


- Custom Material widgets
- Community built widgets
- Your own custom widgets
- [Cupertino widgets](/ui/widgets/cupertino) that follow Apple's Human Interface Guidelines

[Watch on YouTube in a new tab: "Flutter's cupertino library for iOS developers"](https://www.youtube.com/watch/3PdUaidHc-E)

If you're looking for a great reference app that features a
custom design system, check out [Wonderous](https://flutter.gskinner.com/wonderous/?utm_source=flutterdocs&utm_medium=docs&utm_campaign=iosdevs).


## UI Basics

[#](#ui-basics)

This section covers the basics of UI development in
Flutter and how it compares to SwiftUI.
This includes how to start developing your app, display static text,
create buttons, react to on-press events, display lists, grids, and more.


### Getting started

[#](#getting-started)

In **SwiftUI**, you use `App` to start your app.

swift

```
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}

```

content\_copy

Another common SwiftUI practice places the app body within a `struct`
that conforms to the `View` protocol as follows:


swift

```
struct HomePage: View {
  var body: some View {
    Text("Hello, World!")
  }
}

```

content\_copy

To start your **Flutter** app, pass in an instance of your app to
the `runApp` function.


dart

```
void main() {
  runApp(const MyApp());
}

```

content\_copy

`App` is a widget. The build method describes the part of the
user interface it represents.
It's common to begin your app with a [`WidgetApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html)
class,
like [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html).


dart

```
class MyApp extends StatelessWidget {
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    // Returns a CupertinoApp that, by default,
    // has the look and feel of an iOS app.
    return const CupertinoApp(home: HomePage());
  }
}

```

content\_copy

The widget used in `HomePage` might begin with the `Scaffold` class.
`Scaffold` implements a basic layout structure for an app.


dart

```
class HomePage extends StatelessWidget {
  const HomePage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Hello, World!')));
  }
}

```

content\_copy

Note how Flutter uses the [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html)
widget.
SwiftUI renders a view's contents in its center by default.
That's not always the case with Flutter.
`Scaffold` doesn't render its `body` widget at the center of the screen.
To center the text, wrap it in a `Center` widget.
To learn about different widgets and their default behaviors, check out
the [Widget catalog](/ui/widgets/layout).


### Adding Buttons

[#](#adding-buttons)

In **SwiftUI**, you use the `Button` struct to create a button.

swift

```
Button("Do something") {
  // this closure gets called when your
  // button is tapped
}

```

content\_copy

To achieve the same result in **Flutter**,
use the `CupertinoButton` class:


dart

```
CupertinoButton(
  onPressed: () {
    // This closure is called when your button is tapped.
  },
  const Text('Do something'),
),

```

content\_copy

**Flutter** gives you access to a variety of buttons with predefined styles.
The [`CupertinoButton`](https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html)
class comes from the Cupertino library.
Widgets in the Cupertino library use Apple's design system.


### Aligning components horizontally

[#](#aligning-components-horizontally)

In **SwiftUI**, stack views play a big part in designing your layouts.
Two separate structures allow you to create stacks:


1. `HStack` for horizontal stack views

2. `VStack` for vertical stack views


The following SwiftUI view adds a globe image and
text to a horizontal stack view:


swift

```
HStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}

```

content\_copy

**Flutter** uses [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html)
rather than `HStack`:


dart

```
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [Icon(CupertinoIcons.globe), Text('Hello, world!')],
),

```

content\_copy

The `Row` widget requires a `List<Widget>` in the `children` parameter.
The `mainAxisAlignment` property tells Flutter how to position children
with extra space. `MainAxisAlignment.center` positions children in the
center of the main axis. For `Row`, the main axis is the horizontal
axis.


### Aligning components vertically

[#](#aligning-components-vertically)

The following examples build on those in the previous section.

In **SwiftUI**, you use `VStack` to arrange the components into a
vertical pillar.


swift

```
VStack {
  Image(systemName: "globe")
  Text("Hello, world!")
}

```

content\_copy

**Flutter** uses the same Dart code from the previous example,
except it swaps [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)
for `Row`:


dart

```
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [Icon(CupertinoIcons.globe), Text('Hello, world!')],
),

```

content\_copy

### Displaying a list view

[#](#displaying-a-list-view)

In **SwiftUI**, you use the `List` base component to display sequences
of items.
To display a sequence of model objects, make sure that the user can
identify your model objects.
To make an object identifiable, use the `Identifiable` protocol.


swift

```
struct Person: Identifiable {
  var name: String
}
​
var persons = [
  Person(name: "Person 1"),
  Person(name: "Person 2"),
  Person(name: "Person 3"),
]
​
struct ListWithPersons: View {
  let persons: [Person]
  var body: some View {
    List {
      ForEach(persons) { person in
        Text(person.name)
      }
    }
  }
}

```

content\_copy

This resembles how **Flutter** prefers to build its list widgets.
Flutter doesn't need the list items to be identifiable.
You set the number of items to display then build a widget for each item.


dart

```
class Person {
  String name;
  Person(this.name);
}
​
final List<Person> items = [
  Person('Person 1'),
  Person('Person 2'),
  Person('Person 3'),
];
​
class HomePage extends StatelessWidget {
  const HomePage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index].name));
        },
      ),
    );
  }
}

```

content\_copy

Flutter has some caveats for lists:

- The [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) widget has a builder method.
   This works like the `ForEach` within SwiftUI's `List` struct.

- The `itemCount` parameter of the `ListView` sets how many items
   the `ListView` displays.

- The `itemBuilder` has an index parameter that will be between zero
   and one less than itemCount.


The previous example returned a [`ListTile`](https://api.flutter.dev/flutter/widgets/ListTitle-class.html)
widget for each item.
The `ListTile` widget includes properties like `height` and
`font-size`.
These properties help build a list. However, Flutter allows you to return
almost any widget that represents your data.


### Displaying a grid

[#](#displaying-a-grid)

When constructing non-conditional grids in **SwiftUI**,
you use `Grid` with `GridRow`.


swift

```
Grid {
  GridRow {
    Text("Row 1")
    Image(systemName: "square.and.arrow.down")
    Image(systemName: "square.and.arrow.up")
  }
  GridRow {
    Text("Row 2")
    Image(systemName: "square.and.arrow.down")
    Image(systemName: "square.and.arrow.up")
  }
}

```

content\_copy

To display grids in **Flutter**, use the [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html)
widget.
This widget has various constructors. Each constructor has
a similar goal, but uses different input parameters.
The following example uses the `.builder()` initializer:


dart

```
const widgets = [
  Text('Row 1'),
  Icon(CupertinoIcons.arrow_down_square),
  Icon(CupertinoIcons.arrow_up_square),
  Text('Row 2'),
  Icon(CupertinoIcons.arrow_down_square),
  Icon(CupertinoIcons.arrow_up_square),
];
​
class HomePage extends StatelessWidget {
  const HomePage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 40,
        ),
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}

```

content\_copy

The `SliverGridDelegateWithFixedCrossAxisCount` delegate determines
various parameters that the grid uses to lay out its components.
This includes `crossAxisCount` that dictates the number of items
displayed on each row.


How SwiftUI's `Grid` and Flutter's `GridView` differ in that `Grid`
requires `GridRow`. `GridView` uses the delegate to decide how the
grid should lay out its components.


### Creating a scroll view

[#](#creating-a-scroll-view)

In **SwiftUI**, you use `ScrollView` to create custom scrolling
components.
The following example displays a series of `PersonView` instances
in a scrollable fashion.


swift

```
ScrollView {
  VStack(alignment: .leading) {
    ForEach(persons) { person in
      PersonView(person: person)
    }
  }
}

```

content\_copy

To create a scrolling view, **Flutter** uses [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).
In the following example, the function `mockPerson` mocks instances
of the `Person` class to create the custom `PersonView` widget.


dart

```
SingleChildScrollView(
  child: Column(
    children: mockPersons
        .map((person) => PersonView(person: person))
        .toList(),
  ),
),

```

content\_copy

### Responsive and adaptive design

[#](#responsive-and-adaptive-design)

In **SwiftUI**, you use `GeometryReader` to create relative view sizes.

For example, you could:

- Multiply `geometry.size.width` by some factor to set the _width_.
- Use `GeometryReader` as a breakpoint to change the design of your app.

You can also see if the size class has `.regular` or `.compact`
using `horizontalSizeClass`.


To create relative views in **Flutter**, you can use one of two options:

- Get the `BoxConstraints` object in the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
   class.

- Use the [`MediaQuery.of()`](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
   in your build functions
   to get the size and orientation of your current app.


To learn more, check out [Creating responsive and adaptive apps](/ui/adaptive-responsive).


### Managing state

[#](#managing-state)

In **SwiftUI**, you use the `@State` property wrapper to represent the
internal state of a SwiftUI view.


swift

```
struct ContentView: View {
  @State private var counter = 0;
  var body: some View {
    VStack{
      Button("+") { counter+=1 }
      Text(String(counter))
    }
  }}

```

content\_copy

**SwiftUI** also includes several options for more complex state
management such as the `ObservableObject` protocol.


**Flutter** manages local state using a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).
Implement a stateful widget with the following two classes:


- a subclass of `StatefulWidget`
- a subclass of `State`

The `State` object stores the widget's state.
To change a widget's state, call `setState()` from the `State`
subclass
to tell the framework to redraw the widget.


The following example shows a part of a counter app:

dart

```
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
​
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter'),
            TextButton(
              onPressed: () => setState(() {
                _counter++;
              }),
              child: const Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}

```

content\_copy

To learn more ways to manage state, check out [State management](/data-and-backend/state-mgmt).


### Animations

[#](#animations)

Two main types of UI animations exist.

- Implicit that animated from a current value to a new target.
- Explicit that animates when asked.

#### Implicit Animation

[#](#implicit-animation)

SwiftUI and Flutter take a similar approach to animation.
In both frameworks, you specify parameters like `duration`, and `curve`.


In **SwiftUI**, you use the `animate()` modifier to handle implicit
animation.


swift

```
Button("Tap me!"){
   angle += 45
}
.rotationEffect(.degrees(angle))
.animation(.easeIn(duration: 1))

```

content\_copy

**Flutter** includes widgets for implicit animation.
This simplifies animating common widgets.
Flutter names these widgets with the following format: `AnimatedFoo`.


For example: To rotate a button, use the [`AnimatedRotation`](https://api.flutter.dev/flutter/widgets/AnimatedRotation-class.html)
class.
This animates the `Transform.rotate` widget.


dart

```
AnimatedRotation(
  duration: const Duration(seconds: 1),
  turns: turns,
  curve: Curves.easeIn,
  TextButton(
    onPressed: () {
      setState(() {
        turns += .125;
      });
    },
    const Text('Tap me!'),
  ),
),

```

content\_copy

Flutter allows you to create custom implicit animations.
To compose a new animated widget, use the [`TweenAnimationBuilder`](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html).


#### Explicit Animation

[#](#explicit-animation)

For explicit animations, **SwiftUI** uses the `withAnimation()` function.

**Flutter** includes explicitly animated widgets with names formatted
like `FooTransition`.
One example would be the [`RotationTransition`](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html)
class.


Flutter also allows you to create a custom explicit animation using
`AnimatedWidget` or `AnimatedBuilder`.


To learn more about animations in Flutter, see [Animations overview](/ui/animations).

### Drawing on the Screen

[#](#drawing-on-the-screen)

In **SwiftUI**, you use `CoreGraphics` to draw lines and shapes to the
screen.


**Flutter** has an API based on the `Canvas` class,
with two classes that help you draw:


1. [`CustomPaint`](https://api.flutter.dev/flutter/widgets/CustomPaint-class.html)
    that requires a painter:



   dart

   ```
   CustomPaint(
     painter: SignaturePainter(_points),
     size: Size.infinite,
   ),

   ```

   content\_copy

2. [`CustomPainter`](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
    that implements your algorithm to draw to the canvas.



   dart

   ```
   class SignaturePainter extends CustomPainter {
     SignaturePainter(this.points);
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


## Navigation

[#](#navigation)

This section explains how to navigate between pages of an app,
the push and pop mechanism, and more.


### Navigating between pages

[#](#navigating-between-pages)

Developers build iOS and macOS apps with different pages called
_navigation routes_.


In **SwiftUI**, the `NavigationStack` represents this stack of pages.

The following example creates an app that displays a list of persons.
To display a person's details in a new navigation link,
tap on that person.


swift

```
NavigationStack(path: $path) {
      List {
        ForEach(persons) { person in
          NavigationLink(
            person.name,
            value: person
          )
        }
      }
      .navigationDestination(for: Person.self) { person in
        PersonView(person: person)
      }
    }

```

content\_copy

If you have a small **Flutter** app without complex linking,
use [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
with named routes.
After defining your navigation routes,
call your navigation routes using their names.


1. Name each route in the class passed to the `runApp()` function.
    The following example uses `App`:



   dart

   ```
   // Defines the route name as a constant
   // so that it's reusable.
   const detailsPageRouteName = '/details';
   ​
   class App extends StatelessWidget {
     const App({super.key});
   ​
     @override
     Widget build(BuildContext context) {
       return CupertinoApp(
         home: const HomePage(),
         // The [routes] property defines the available named routes
         // and the widgets to build when navigating to those routes.
         routes: {detailsPageRouteName: (context) => const DetailsPage()},
       );
     }
   }

   ```

   content\_copy



   The following sample generates a list of persons using
    `mockPersons()`. Tapping a person pushes the person's detail page
    to the `Navigator` using `pushNamed()`.



   dart

   ```
   ListView.builder(
     itemCount: mockPersons.length,
     itemBuilder: (context, index) {
       final person = mockPersons.elementAt(index);
       final age = '${person.age} years old';
       return ListTile(
         title: Text(person.name),
         subtitle: Text(age),
         trailing: const Icon(Icons.arrow_forward_ios),
         onTap: () {
           // When a [ListTile] that represents a person is
           // tapped, push the detailsPageRouteName route
           // to the Navigator and pass the person's instance
           // to the route.
           Navigator.of(
             context,
           ).pushNamed(detailsPageRouteName, arguments: person);
         },
       );
     },
   ),

   ```

   content\_copy

2. Define the `DetailsPage` widget that displays the details of
    each person. In Flutter, you can pass arguments into the
    widget when navigating to the new route.
    Extract the arguments using `ModalRoute.of()`:



   dart

   ```
   class DetailsPage extends StatelessWidget {
     const DetailsPage({super.key});
   ​
     @override
     Widget build(BuildContext context) {
       // Read the person instance from the arguments.
       final Person person = ModalRoute.of(context)?.settings.arguments as Person;
       // Extract the age.
       final age = '${person.age} years old';
       return Scaffold(
         // Display name and age.
         body: Column(children: [Text(person.name), Text(age)]),
       );
     }
   }

   ```

   content\_copy


To create more advanced navigation and routing requirements,
use a routing package such as [go\_router](https://pub.dev/packages/go_router).


To learn more, check out [Navigation and routing](/ui/navigation).

### Manually pop back

[#](#manually-pop-back)

In **SwiftUI**, you use the `dismiss` environment value to pop-back to
the previous screen.


swift

```
Button("Pop back") {
        dismiss()
      }

```

content\_copy

In **Flutter**, use the `pop()` function of the `Navigator` class:


dart

```
TextButton(
  onPressed: () {
    // This code allows the
    // view to pop back to its presenter.
    Navigator.of(context).pop();
  },
  child: const Text('Pop back'),
),

```

content\_copy

### Navigating to another app

[#](#navigating-to-another-app)

In **SwiftUI**, you use the `openURL` environment variable to open a
URL to another application.


swift

```
@Environment(\.openURL) private var openUrl
​
// View code goes here
​
 Button("Open website") {
      openUrl(
        URL(
          string: "https://google.com"
        )!
      )
    }

```

content\_copy

In **Flutter**, use the [`url_launcher`](https://pub.dev/packages/url_launcher)
plugin.


dart

```
CupertinoButton(
  onPressed: () async {
    await launchUrl(Uri.parse('https://google.com'));
  },
  const Text('Open website'),
),

```

content\_copy

## Themes, styles, and media

[#](#themes-styles-and-media)

You can style Flutter apps with little effort.
Styling includes switching between light and dark themes,
changing the design of your text and UI components,
and more. This section covers how to style your apps.


### Using dark mode

[#](#using-dark-mode)

In **SwiftUI**, you call the `preferredColorScheme()`
function on a `View` to use dark mode.


In **Flutter**, you can control light and dark mode at the app-level.
To control the brightness mode, use the `theme` property
of the `App` class:


dart

```
const CupertinoApp(
  theme: CupertinoThemeData(brightness: Brightness.dark),
  home: HomePage(),
);

```

content\_copy

### Styling text

[#](#styling-text)

In **SwiftUI**, you use modifier functions to style text.
For example, to change the font of a `Text` string,
use the `font()` modifier:


swift

```
Text("Hello, world!")
  .font(.system(size: 30, weight: .heavy))
  .foregroundColor(.yellow)

```

content\_copy

To style text in **Flutter**, add a `TextStyle` widget as the value
of the `style` parameter of the `Text` widget.


dart

```
Text(
  'Hello, world!',
  style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: CupertinoColors.systemYellow,
  ),
),

```

content\_copy

### Styling buttons

[#](#styling-buttons)

In **SwiftUI**, you use modifier functions to style buttons.

swift

```
Button("Do something") {
    // do something when button is tapped
  }
  .font(.system(size: 30, weight: .bold))
  .background(Color.yellow)
  .foregroundColor(Color.blue)
}

```

content\_copy

To style button widgets in **Flutter**, set the style of its child,
or modify properties on the button itself.


In the following example:

- The `color` property of `CupertinoButton` sets its `color`.
- The `color` property of the child `Text` widget sets the button
   text color.


dart

```
child: CupertinoButton(
  color: CupertinoColors.systemYellow,
  onPressed: () {},
  padding: const EdgeInsets.all(16),
  child: const Text(
    'Do something',
    style: TextStyle(
      color: CupertinoColors.systemBlue,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
),

```

content\_copy

### Using custom fonts

[#](#using-custom-fonts)

In **SwiftUI**, you can use a custom font in your app in two steps.
First, add the font file to your SwiftUI project. After adding the file,
use the `.font()` modifier to apply it to your UI components.


swift

```
Text("Hello")
  .font(
    Font.custom(
      "BungeeSpice-Regular",
      size: 40
    )
  )

```

content\_copy

In **Flutter**, you control your resources with a file
named `pubspec.yaml`. This file is platform agnostic.
To add a custom font to your project, follow these steps:


1. Create a folder called `fonts` in the project's root directory.
    This optional step helps to organize your fonts.

2. Add your `.ttf`, `.otf`, or `.ttc` font file into the `fonts`
    folder.

3. Open the `pubspec.yaml` file within the project.

4. Find the `flutter` section.

5. Add your custom font(s) under the `fonts` section.



   yaml

   ```
   flutter:
     fonts:
    - family: BungeeSpice
      fonts:
        - asset: fonts/BungeeSpice-Regular.ttf

```

content\_copy

After you add the font to your project, you can use it as in the
following example:


dart

```
Text(
  'Cupertino',
  style: TextStyle(fontSize: 40, fontFamily: 'BungeeSpice'),
),

```

content\_copy

infoNote

To download custom fonts to use in your apps,
check out [Google Fonts](https://fonts.google.com).


### Bundling images in apps

[#](#bundling-images-in-apps)

In **SwiftUI**, you first add the image files to `Assets.xcassets`,
then use the `Image` view to display the images.


To add images in **Flutter**, follow a method similar to how you added
custom fonts.


1. Add an `images` folder to the root directory.

2. Add this asset to the `pubspec.yaml` file.



   yaml

   ```
   flutter:
     assets:
    - images/Blueberries.jpg

```

content\_copy

After adding your image, display it using the `Image` widget's
`.asset()` constructor. This constructor:


1. Instantiates the given image using the provided path.
2. Reads the image from the assets bundled with your app.
3. Displays the image on the screen.

To review a complete example, check out the [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html)
docs.


### Bundling videos in apps

[#](#bundling-videos-in-apps)

In **SwiftUI**, you bundle a local video file with your app in two
steps.
First, you import the `AVKit` framework, then you instantiate a
`VideoPlayer` view.


In **Flutter**, add the [video\_player](https://pub.dev/packages/video_player)
plugin to your project.
This plugin allows you to create a video player that works on
Android, iOS, and on the web from the same codebase.


1. Add the plugin to your app and add the video file to your project.
2. Add the asset to your `pubspec.yaml` file.
3. Use the `VideoPlayerController` class to load and play your video
    file.


To review a complete walkthrough, check out the [video\_player example](https://pub.dev/packages/video_player/example).


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/flutter-for/swiftui-devs.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/flutter-for/swiftui-devs&page-source=https://github.com/flutter/website/blob/main/src/content/flutter-for/swiftui-devs.md "Report an issue with this page").