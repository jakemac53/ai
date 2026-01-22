---
name: parse-json-in-the-background
description: How to perform a task in the background.
metadata:
  url: https://docs.flutter.dev/cookbook/networking/background-parsing
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Parse JSON in the background

By default, Dart apps do all of their work on a single thread.
In many cases, this model simplifies coding and is fast enough
that it does not result in poor app performance or stuttering animations,
often called "jank."


However, you might need to perform an expensive computation,
such as parsing a very large JSON document.
If this work takes more than 16 milliseconds,
your users experience jank.


To avoid jank, you need to perform expensive computations
like this in the background, using a separate [Isolate](https://api.flutter.dev/flutter/dart-isolate/Isolate-class.html).
This recipe uses the following steps:


1. Add the `http` package.
2. Make a network request using the `http` package.
3. Convert the response into a list of photos.
4. Move this work to a separate isolate.

## 1\. Add the `http` package

[#](#1-add-the-http-package)

First, add the [`http`](https://pub.dev/packages/http) package to your project.
The `http` package makes it easier to perform network
requests, such as fetching data from a JSON endpoint.


To add the `http` package as a dependency,
run `flutter pub add`:


```
$ flutter pub add http

```

content\_copy

## 2\. Make a network request

[#](#2-make-a-network-request)

This example covers how to fetch a large JSON document
that contains a list of 5000 photo objects from the
[JSONPlaceholder REST API](https://jsonplaceholder.typicode.com),
using the [`http.get()`](https://pub.dev/documentation/http/latest/http/get.html)
method.


dart

```
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
}

```

content\_copy

infoNote

You're providing an `http.Client` to the function in this example.
This makes the function easier to test and use in different environments.


## 3\. Parse and convert the JSON into a list of photos

[#](#3-parse-and-convert-the-json-into-a-list-of-photos)

Next, following the guidance from the
[Fetch data from the internet](/cookbook/networking/fetch-data) recipe,
convert the `http.Response` into a list of Dart objects.
This makes the data easier to work with.


### Create a `Photo` class

[#](#create-a-photo-class)

First, create a `Photo` class that contains data about a photo.
Include a `fromJson()` factory method to make it easy to create a
`Photo` starting with a JSON object.


dart

```
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
​
  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
​
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

```

content\_copy

### Convert the response into a list of photos

[#](#convert-the-response-into-a-list-of-photos)

Now, use the following instructions to update the
`fetchPhotos()` function so that it returns a
`Future<List<Photo>>`:


1. Create a `parsePhotos()` function that converts the response
    body into a `List<Photo>`.

2. Use the `parsePhotos()` function in the `fetchPhotos()` function.

dart

```
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List<Object?>)
      .cast<Map<String, Object?>>();
​
  return parsed.map<Photo>(Photo.fromJson).toList();
}
​
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );
​
  // Synchronously run parsePhotos in the main isolate.
  return parsePhotos(response.body);
}

```

content\_copy

## 4\. Move this work to a separate isolate

[#](#4-move-this-work-to-a-separate-isolate)

If you run the `fetchPhotos()` function on a slower device,
you might notice the app freezes for a brief moment as it parses and
converts the JSON. This is jank, and you want to get rid of it.


You can remove the jank by moving the parsing and conversion
to a background isolate using the [`compute()`](https://api.flutter.dev/flutter/foundation/compute.html)

function provided by Flutter. The `compute()` function runs expensive
functions in a background isolate and returns the result. In this case,
run the `parsePhotos()` function in the background.


dart

```
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );
​
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

```

content\_copy

## Notes on working with isolates

[#](#notes-on-working-with-isolates)

Isolates communicate by passing messages back and forth. These messages can
be primitive values, such as `null`, `num`, `bool`,
`double`, or `String`, or
simple objects such as the `List<Photo>` in this example.


You might experience errors if you try to pass more complex objects,
such as a `Future` or `http.Response` between isolates.


As an alternate solution, check out the [`worker_manager`](https://pub.dev/packages/worker_manager)
or
[`workmanager`](https://pub.dev/packages/workmanager) packages for background processing.


## Complete example

[#](#complete-example)

dart

```
import 'dart:async';
import 'dart:convert';
​
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
​
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  );
​
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}
​
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List<Object?>)
      .cast<Map<String, Object?>>();
​
  return parsed.map<Photo>(Photo.fromJson).toList();
}
​
class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
​
  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
​
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
​
void main() => runApp(const MyApp());
​
class MyApp extends StatelessWidget {
  const MyApp({super.key});
​
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';
​
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
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
  late Future<List<Photo>> futurePhotos;
​
  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos(http.Client());
  }
​
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error has occurred!'));
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
​
class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});
​
  final List<Photo> photos;
​
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}

```

content\_copy

![Isolate demo](/assets/images/docs/cookbook/isolate.webp)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-8-19. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/networking/background-parsing.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/networking/background-parsing&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/networking/background-parsing.md "Report an issue with this page").