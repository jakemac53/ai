---
name: delete-data-on-the-internet
description: How to use the http package to delete data on the internet.
metadata:
  url: https://docs.flutter.dev/cookbook/networking/delete-data
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Delete data on the internet

This recipe covers how to delete data over
the internet using the `http` package.


This recipe uses the following steps:

1. Add the `http` package.
2. Delete data on the server.
3. Update the screen.

## 1\. Add the `http` package

[#](#1-add-the-http-package)

To add the `http` package as a dependency,
run `flutter pub add`:


```
$ flutter pub add http

```

content\_copy

Import the `http` package.

dart

```
import 'package:http/http.dart' as http;

```

content\_copy

If you are deploying to Android, edit your `AndroidManifest.xml` file to
add the Internet permission.


xml

```
<!-- Required to fetch data from the internet. -->
<uses-permission android:name="android.permission.INTERNET" />

```

content\_copy

Likewise, if you are deploying to macOS, edit your
`macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements`

files to include the network client entitlement.


xml

```
<!-- Required to fetch data from the internet. -->
<key>com.apple.security.network.client</key>
<true/>

```

content\_copy

## 2\. Delete data on the server

[#](#2-delete-data-on-the-server)

This recipe covers how to delete an album from the
[JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the `http.delete()`
method.
Note that this requires the `id` of the album that
you want to delete. For this example,
use something you already know, for example `id = 1`.


dart

```
Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
​
  return response;
}

```

content\_copy

The `http.delete()` method returns a `Future` that contains a `Response`.


- [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) is a core Dart class for working with
   async operations. A Future object represents a potential
   value or error that will be available at some time in the future.

- The `http.Response` class contains the data received from a successful
   http call.

- The `deleteAlbum()` method takes an `id` argument that
   is needed to identify the data to be deleted from the server.


## 3\. Update the screen

[#](#3-update-the-screen)

In order to check whether the data has been deleted or not,
first fetch the data from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/)

using the `http.get()` method, and display it in the screen.
(See the [Fetch Data](/cookbook/networking/fetch-data) recipe for a complete example.)
You should now have a **Delete Data** button that,
when pressed, calls the `deleteAlbum()` method.


dart

```
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text(snapshot.data?.title ?? 'Deleted'),
    ElevatedButton(
      child: const Text('Delete Data'),
      onPressed: () {
        setState(() {
          _futureAlbum = deleteAlbum(
            snapshot.data!.id.toString(),
          );
        });
      },
    ),
  ],
);

```

content\_copy

Now, when you click on the _**Delete Data**_ button,
the `deleteAlbum()` method is called and the id
you are passing is the id of the data that you retrieved
from the internet. This means you are going to delete
the same data that you fetched from the internet.


### Returning a response from the deleteAlbum() method

[#](#returning-a-response-from-the-deletealbum-method)

Once the delete request has been made,
you can return a response from the `deleteAlbum()`
method to notify our screen that the data has been deleted.


dart

```
Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
​
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then return an empty Album. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.empty();
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}

```

content\_copy

`FutureBuilder()` now rebuilds when it receives a response.
Since the response won't have any data in its body
if the request was successful,
the `Album.fromJson()` method creates an instance of the
`Album` object with a default value ( `null` in our case).
This behavior can be altered in any way you wish.


That's all!
Now you've got a function that deletes the data from the internet.


## Complete example

[#](#complete-example)

dart

```
import 'dart:async';
import 'dart:convert';
​
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
​
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );
​
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}
​
Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
​
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then return an empty Album. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Album.empty();
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}
​
class Album {
  int? id;
  String? title;
​
  Album({this.id, this.title});
​
  Album.empty();
​
  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title} => Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
​
void main() {
  runApp(const MyApp());
}
​
class MyApp extends StatefulWidget {
  const MyApp({super.key});
​
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}
​
class _MyAppState extends State<MyApp> {
  late Future<Album> _futureAlbum;
​
  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }
​
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Delete Data Example')),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              // If the connection is done,
              // check for response data or an error.
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.title ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum = deleteAlbum(
                              snapshot.data!.id.toString(),
                            );
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
​
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/networking/delete-data.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/networking/delete-data&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/networking/delete-data.md "Report an issue with this page").