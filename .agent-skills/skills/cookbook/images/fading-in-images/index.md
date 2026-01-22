---
name: fade-in-images-with-a-placeholder
description: How to fade images into view.
metadata:
  url: https://docs.flutter.dev/cookbook/images/fading-in-images
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Fade in images with a placeholder

When displaying images using the default `Image` widget,
you might notice they simply pop onto the screen as they're loaded.
This might feel visually jarring to your users.


Instead, wouldn't it be nice to display a placeholder at first,
and images would fade in as they're loaded? Use the
[`FadeInImage`](https://api.flutter.dev/flutter/widgets/FadeInImage-class.html)
widget for exactly this purpose.


`FadeInImage` works with images of any type: in-memory, local assets,
or images from the internet.


## In-Memory

[#](#in-memory)

In this example, use the [`transparent_image`](https://pub.dev/packages/transparent_image)

package for a simple transparent placeholder.


dart

```
FadeInImage.memoryNetwork(
  placeholder: kTransparentImage,
  image: 'https://picsum.photos/250?image=9',
),

```

content\_copy

### Complete example

[#](#complete-example)

dart

```
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
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
    const title = 'Fade in images';
​
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://picsum.photos/250?image=9',
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

![Fading In Image Demo](/assets/images/docs/cookbook/fading-in-images.webp)

## From asset bundle

[#](#from-asset-bundle)

You can also consider using local assets for placeholders.
First, add the asset to the project's `pubspec.yaml` file
(for more details, see [Adding assets and images](/ui/assets/assets-and-images)):


yaml

```
flutter:
  assets:
    - assets/loading.gif

```

content\_copy

Then, use the [`FadeInImage.assetNetwork()`](https://api.flutter.dev/flutter/widgets/FadeInImage/FadeInImage.assetNetwork.html)
constructor:


dart

```
FadeInImage.assetNetwork(
  placeholder: 'assets/loading.gif',
  image: 'https://picsum.photos/250?image=9',
),

```

content\_copy

### Complete example

[#](#complete-example-1)

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
    const title = 'Fade in images';
​
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: 'https://picsum.photos/250?image=9',
          ),
        ),
      ),
    );
  }
}

```

content\_copy

![Asset fade-in](/assets/images/docs/cookbook/fading-in-asset-demo.webp)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-4-2. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/images/fading-in-images.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/images/fading-in-images&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/images/fading-in-images.md "Report an issue with this page").