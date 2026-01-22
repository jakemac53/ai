---
name: test-orientation
description: How to test if an app is in portrait or landscape mode.
metadata:
  url: https://docs.flutter.dev/cookbook/testing/widget/orientation
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Test orientation

In Flutter, you can build different layouts depending on a given
[orientation](https://api.flutter.dev/flutter/widgets/Orientation.html). For example, you could present data in two columns if the app
is in portrait mode, and three columns if in landscape mode.
Additionally, you can create tests that check if the correct number of columns
are being shown for each orientation.


In this recipe, you can learn how check if the orientation of an app is
`portrait` or `landscape`, and also how many columns are displayed for each
orientation.


This recipe uses the following steps:

1. Create an app that updates the layout of the content,
    based on the orientation.

2. Create an orientation test group.
3. Create a portrait orientation test.
4. Create a landscape orientation test.
5. Run the tests.

## 1\. Create an app that updates based on orientation

[#](#1-create-an-app-that-updates-based-on-orientation)

Create a Flutter app that changes how many columns are shown when an
app is in portrait or landscape mode:


1. Create a new Flutter project called `orientation_tests`.





   ```
   flutter create orientation_tests

   ```

   content\_copy

2. Follow the steps in [Update the UI based on orientation](/cookbook/design/orientation) to
    set up the project.


## 2\. Create an orientation test group

[#](#2-create-an-orientation-test-group)

After you've set up your `orientation_tests` project, complete these steps to
group your future orientation tests:


1. In your Flutter project, open `test/widget_test.dart`.

2. Replace the existing contents with the following:



   widget\_test.dart



   dart

   ```
   import 'package:flutter/material.dart';
   import 'package:flutter_test/flutter_test.dart';
   import 'package:orientation_tests/main.dart';
   ​
   void main() {
     group('Orientation', () {
       // ···
     });
   }

   ```

   content\_copy


## 3\. Create a portrait orientation test

[#](#3-create-a-portrait-orientation-test)

Add the portrait orientation test to the `Orientation` group.
This test makes sure that the orientation is `portrait` and that
only `2` columns of data appear in the app:


1. In `test/widget_test.dart`, replace `...` inside of the `Orientation`
    group
    with the following test:



   widget\_test.dart



   dart

   ```
   // Check if portrait mode displays correctly.
   testWidgets('Displays 2 columns in portrait mode', (tester) async {
     // Build the app.
     await tester.pumpWidget(const MyApp());
   ​
     // Change to portrait.
     tester.view.physicalSize = const Size(600, 800);
     tester.view.devicePixelRatio = 1.0;
     addTearDown(() {
       tester.view.resetPhysicalSize();
     });
     await tester.pump();
   ​
     // Verify initial orientation is portrait.
     final orientation = MediaQuery.of(
       tester.element(find.byType(OrientationList)),
     ).orientation;
     expect(orientation, Orientation.portrait);
   ​
     // Verify there are only 2 columns in portrait mode.
     final gridViewFinder = find.byType(GridView);
     final gridView = tester.widget<GridView>(gridViewFinder);
     final delegate =
         gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
     expect(delegate.crossAxisCount, 2);
   });

   ```

   content\_copy


## 4\. Create a landscape orientation test

[#](#4-create-a-landscape-orientation-test)

Add the landscape orientation test to the `Orientation` group.
This test makes sure that the orientation is `landscape` and that
only `3` columns of data appear in the app:


1. In `test/widget_test.dart`, inside of the `Orientation` group,
    add the following test after the landscape test:



   widget\_test.dart



   dart

   ```
   // Check if landscape mode displays correctly.
   testWidgets('Displays 3 columns in landscape mode', (tester) async {
     // Build the app.
     await tester.pumpWidget(const MyApp());
   ​
     // Change to landscape.
     tester.view.physicalSize = const Size(800, 600);
     tester.view.devicePixelRatio = 1.0;
     addTearDown(() {
       tester.view.resetPhysicalSize();
     });
     await tester.pump();
   ​
     // Verify initial orientation is landscape.
     final orientation = MediaQuery.of(
       tester.element(find.byType(OrientationList)),
     ).orientation;
     expect(orientation, Orientation.landscape);
   ​
     // Verify there are only 3 columns in landscape mode.
     final gridViewFinder = find.byType(GridView);
     final gridView = tester.widget<GridView>(gridViewFinder);
     final delegate =
         gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
     expect(delegate.crossAxisCount, 3);
   });

   ```

   content\_copy


## 5\. Run the tests

[#](#5-run-the-tests)

Run the tests using the following command from the root of the project:

```
flutter test test/widget_test.dart

```

content\_copy

## Complete example

[#](#complete-example)

widget\_test.dart

dart

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orientation_tests/main.dart';
​
void main() {
  group('Orientation', () {
    // Check if portrait mode displays correctly.
    testWidgets('Displays 2 columns in portrait mode', (tester) async {
      // Build the app.
      await tester.pumpWidget(const MyApp());
​
      // Change to portrait.
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      await tester.pump();
​
      // Verify initial orientation is portrait.
      final orientation = MediaQuery.of(
        tester.element(find.byType(OrientationList)),
      ).orientation;
      expect(orientation, Orientation.portrait);
​
      // Verify there are only 2 columns in portrait mode.
      final gridViewFinder = find.byType(GridView);
      final gridView = tester.widget<GridView>(gridViewFinder);
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });
​
    // Check if landscape mode displays correctly.
    testWidgets('Displays 3 columns in landscape mode', (tester) async {
      // Build the app.
      await tester.pumpWidget(const MyApp());
​
      // Change to landscape.
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      await tester.pump();
​
      // Verify initial orientation is landscape.
      final orientation = MediaQuery.of(
        tester.element(find.byType(OrientationList)),
      ).orientation;
      expect(orientation, Orientation.landscape);
​
      // Verify there are only 3 columns in landscape mode.
      final gridViewFinder = find.byType(GridView);
      final gridView = tester.widget<GridView>(gridViewFinder);
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
    });
  });
}

```

content\_copy

main.dart

dart

```
import 'package:flutter/material.dart';
​
void main() {
  runApp(const MyApp());
}
​
class MyApp extends StatelessWidget {
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Orientation Demo';
​
    return const MaterialApp(
      title: appTitle,
      home: OrientationList(title: appTitle),
    );
  }
}
​
class OrientationList extends StatelessWidget {
  final String title;
​
  const OrientationList({super.key, required this.title});
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or
            // 3 columns in landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 widgets that display their index in the list.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: TextTheme.of(context).displayLarge,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-11-24. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/orientation.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/testing/widget/orientation&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/testing/widget/orientation.md "Report an issue with this page").