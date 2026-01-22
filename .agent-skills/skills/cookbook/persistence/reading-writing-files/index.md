---
name: read-and-write-files
description: How to read from and write to files on disk.
metadata:
  url: https://docs.flutter.dev/cookbook/persistence/reading-writing-files
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Read and write files

In some cases, you need to read and write files to disk.
For example, you might need to persist data across app launches,
or download data from the internet and save it for later offline use.


To save files to disk on mobile or desktop apps,
combine the [`path_provider`](https://pub.dev/packages/path_provider)
plugin with the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html)
library.


This recipe uses the following steps:

1. Find the correct local path.
2. Create a reference to the file location.
3. Write data to the file.
4. Read data from the file.

To learn more, watch this Package of the Week video
on the `path_provider` package:


[Watch on YouTube in a new tab: "path\_provider \| Flutter package of the week"](https://www.youtube.com/watch/Ci4t-NkOY3I)

infoNote

This recipe doesn't work with web apps at this time.
To follow the discussion on this issue,
check out `flutter/flutter` [issue #45296](https://github.com/flutter/flutter/issues/45296).


## 1\. Find the correct local path

[#](#1-find-the-correct-local-path)

This example displays a counter. When the counter changes,
write data on disk so you can read it again when the app loads.
Where should you store this data?


The [`path_provider`](https://pub.dev/packages/path_provider) package
provides a platform-agnostic way to access commonly used locations on the
device's file system. The plugin currently supports access to
two file system locations:


_Temporary directory_

A temporary directory (cache) that the system can
clear at any time. On iOS, this corresponds to the
[`NSCachesDirectory`](https://developer.apple.com/documentation/foundation/nssearchpathdirectory/nscachesdirectory). On Android, this is the value that
[`getCacheDir()`](https://developer.android.com/reference/android/content/Context#getCacheDir())
returns.


_Documents directory_

A directory for the app to store files that only
it can access. The system clears the directory only when the app
is deleted.
On iOS, this corresponds to the `NSDocumentDirectory`.
On Android, this is the `AppData` directory.


This example stores information in the documents directory.
You can find the path to the documents directory as follows:


dart

```
import 'package:path_provider/path_provider.dart';
  // ···
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
​
    return directory.path;
  }

```

content\_copy

## 2\. Create a reference to the file location

[#](#2-create-a-reference-to-the-file-location)

Once you know where to store the file, create a reference to the
file's full location. You can use the [`File`](https://api.flutter.dev/flutter/dart-io/File-class.html)

class from the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html)
library to achieve this.


dart

```
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

```

content\_copy

## 3\. Write data to the file

[#](#3-write-data-to-the-file)

Now that you have a `File` to work with,
use it to read and write data.
First, write some data to the file.
The counter is an integer, but is written to the
file as a string using the `'$counter'` syntax.


dart

```
Future<File> writeCounter(int counter) async {
  final file = await _localFile;
​
  // Write the file
  return file.writeAsString('$counter');
}

```

content\_copy

## 4\. Read data from the file

[#](#4-read-data-from-the-file)

Now that you have some data on disk, you can read it.
Once again, use the `File` class.


dart

```
Future<int> readCounter() async {
  try {
    final file = await _localFile;
​
    // Read the file
    final contents = await file.readAsString();
​
    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}

```

content\_copy

## Complete example

[#](#complete-example)

dart

```
import 'dart:async';
import 'dart:io';
​
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
​
void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}
​
class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
​
    return directory.path;
  }
​
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
​
  Future<int> readCounter() async {
    try {
      final file = await _localFile;
​
      // Read the file
      final contents = await file.readAsString();
​
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
​
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
​
    // Write the file
    return file.writeAsString('$counter');
  }
​
}
​
class FlutterDemo extends StatefulWidget {
  const FlutterDemo({super.key, required this.storage});
​
  final CounterStorage storage;
​
  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}
​
class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;
​
  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }
​
  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });
​
    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading and Writing Files')),
      body: Center(
        child: Text('Button tapped $_counter time${_counter == 1 ? '' : 's'}.'),
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

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/reading-writing-files.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/persistence/reading-writing-files&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/persistence/reading-writing-files.md "Report an issue with this page").