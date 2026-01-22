---
name: make-authenticated-requests
description: How to fetch authorized data from a web service.
metadata:
  url: https://docs.flutter.dev/cookbook/networking/authenticated-requests
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Make authenticated requests

To fetch data from most web services, you need to provide
authorization. There are many ways to do this,
but perhaps the most common uses the `Authorization` HTTP header.


## Add authorization headers

[#](#add-authorization-headers)

The [`http`](https://pub.dev/packages/http) package provides a
convenient way to add headers to your requests.
Alternatively, use the [`HttpHeaders`](https://api.dart.dev/dart-io/HttpHeaders-class.html)

class from the `dart:io` library.


dart

```
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  // Send authorization headers to the backend.
  headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
);

```

content\_copy

## Complete example

[#](#complete-example)

This example builds upon the
[Fetching data from the internet](/cookbook/networking/fetch-data) recipe.


dart

```
import 'dart:async';
import 'dart:convert';
import 'dart:io';
​
import 'package:http/http.dart' as http;
​
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
  );
  final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
​
  return Album.fromJson(responseJson);
}
​
class Album {
  final int userId;
  final int id;
  final String title;
​
  const Album({required this.userId, required this.id, required this.title});
​
  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-2-12. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/networking/authenticated-requests.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/networking/authenticated-requests&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/networking/authenticated-requests.md "Report an issue with this page").