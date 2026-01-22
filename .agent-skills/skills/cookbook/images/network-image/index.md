---
name: display-images-from-the-internet
description: How to display images from the internet.
metadata:
  url: https://docs.flutter.dev/cookbook/images/network-image
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Display images from the internet

Displaying images is fundamental for most mobile apps.
Flutter provides the [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html)
widget to
display different types of images.


To work with images from a URL, use the
[`Image.network()`](https://api.flutter.dev/flutter/widgets/Image/Image.network.html)
constructor.


dart

```
Image.network('https://picsum.photos/250?image=9'),

```

content\_copy

## Bonus: animated gifs

[#](#bonus-animated-gifs)

One useful thing about the `Image` widget:
It supports animated gifs.


dart

```
Image.network(
  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
);

```

content\_copy

## Image fade in with placeholders

[#](#image-fade-in-with-placeholders)

The default `Image.network` constructor doesn't handle more advanced
functionality, such as fading images in after loading.
To accomplish this task,
check out [Fade in images with a placeholder](/cookbook/images/fading-in-images).


- [Fade in images with a placeholder](/cookbook/images/fading-in-images)

## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/images/network-image.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/images/network-image&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/images/network-image.md "Report an issue with this page").