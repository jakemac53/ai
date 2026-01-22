---
name: store-key-value-data-on-disk
description: Learn how to use the shared_preferences package to store key-value data.
metadata:
  url: https://docs.flutter.dev/cookbook/persistence/key-value
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Store key-value data on disk

If you have a relatively small collection of key-values
to save, you can use the [`shared_preferences`](https://pub.dev/packages/shared_preferences)
plugin.


Normally, you would have to
write native platform integrations for storing data on each platform.
Fortunately, the [`shared_preferences`](https://pub.dev/packages/shared_preferences)
plugin can be used to
persist key-value data to disk on each platform Flutter supports.


This recipe uses the following steps:

1. Add the dependency.
2. Save data.
3. Read data.
4. Remove data.

infoNote

To learn more, watch this short Package of the Week video
on the `shared_preferences` package:


[Watch on YouTube in a new tab: "shared\_preferences \| Flutter package of the week"](https://www.youtube.com/watch/sa_U0jffQII)

## 1\. Add the dependency

[#](#1-add-the-dependency)

Before starting, add the [`shared_preferences`](https://pub.dev/packages/shared_preferences)
package as a dependency.


To add the `shared_preferences` package as a dependency,
run `flutter pub add`:


```
flutter pub add shared_preferences

```

content\_copy

## 2\. Save data

[#](#2-save-data)

To persist data, use the setter methods provided by the
`SharedPreferences` class. Setter methods are available for
various primitive types, such as `setInt`, `setBool`, and `setString`.


Setter methods do two things: First, synchronously update the
key-value pair in memory. Then, persist the data to disk.


dart

```
// Load and obtain the shared preferences for this app.
final prefs = await SharedPreferences.getInstance();
​
// Save the counter value to persistent storage under the 'counter' key.
await prefs.setInt('counter', counter);

```

content\_copy

## 3\. Read data

[#](#3-read-data)

To read data, use the appropriate getter method provided by the
`SharedPreferences` class. For each setter there is a corresponding getter.
For example, you can use the `getInt`, `getBool`, and `getString`
methods.


dart

```
final prefs = await SharedPreferences.getInstance();
​
// Try reading the counter value from persistent storage.
// If not present, null is returned, so default to 0.
final counter = prefs.getInt('counter') ?? 0;

```

content\_copy

Note that the getter methods throw an exception if the persisted value
has a different type than the getter method expects.


## 4\. Remove data

[#](#4-remove-data)

To delete data, use the `remove()` method.

dart

```
final prefs = await SharedPreferences.getInstance();
​
// Remove the counter key-value pair from persistent storage.
await prefs.remove('counter');

```

content\_copy

## Supported types

[#](#supported-types)

Although the key-value storage provided by `shared_preferences` is
easy and convenient to use, it has limitations:


- Only primitive types can be used: `int`, `double`, `bool`, `String`,
   and `List<String>`.

- It's not designed to store large amounts of data.
- There is no guarantee that data will be persisted across app restarts.

## Testing support

[#](#testing-support)

It's a good idea to test code that persists data using `shared_preferences`.
To enable this, the package provides an
in-memory mock implementation of the preference store.


To set up your tests to use the mock implementation,
call the `setMockInitialValues` static method in
a `setUpAll()` method in your test files.
Pass in a map of key-value pairs to use as the initial values.


dart

```
SharedPreferences.setMockInitialValues(<String, Object>{'counter': 2});

```

content\_copy

## Complete example

[#](#complete-example)

dart

```
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
​
void main() => runApp(const MyApp());
​
class MyApp extends StatelessWidget {
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shared preferences demo',
      home: MyHomePage(title: 'Shared preferences demo'),
    );
  }
}
​
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
​
  final String title;
​
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
​
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
​
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }
​
  /// Load the initial counter value from persistent storage on start,
  /// or fallback to 0 if it doesn't exist.
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }
​
  /// After a click, increment the counter state and
  /// asynchronously save it to persistent storage.
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times: '),
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

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/key-value.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/persistence/key-value&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/key-value.md "Report an issue with this page").