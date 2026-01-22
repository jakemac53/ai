---
name: add-material-touch-ripples
description: How to implement ripple animations.
metadata:
  url: https://docs.flutter.dev/cookbook/gestures/ripples
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Add Material touch ripples

Widgets that follow the Material Design guidelines display
a ripple animation when tapped.


Flutter provides the [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html)

widget to perform this effect.
Create a ripple effect using the following steps:


1. Create a widget that supports tap.
2. Wrap it in an `InkWell` widget to manage tap callbacks and
    ripple animations.


dart

```
// The InkWell wraps the custom flat button widget.
InkWell(
  // When the user taps the button, show a snackbar.
  onTap: () {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tap')));
  },
  child: const Padding(
    padding: EdgeInsets.all(12),
    child: Text('Flat Button'),
  ),
)

```

content\_copy

## Interactive example

[#](#interactive-example)

```
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'InkWell Demo';

    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    // The InkWell wraps the custom flat button widget.
    return InkWell(
      // When the user taps the button, show a snackbar.
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Tap')));
      },
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text('Flat Button'),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/gestures/ripples.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/gestures/ripples&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/gestures/ripples.md "Report an issue with this page").