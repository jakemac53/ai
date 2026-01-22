---
name: handle-changes-to-a-text-field
description: How to detect changes to a text field.
metadata:
  url: https://docs.flutter.dev/cookbook/forms/text-field-changes
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Handle changes to a text field

In some cases, it's useful to run a callback function every time the text
in a text field changes. For example, you might want to build a search
screen with autocomplete functionality where you want to update the
results as the user types.


How do you run a callback function every time the text changes?
With Flutter, you have two options:


1. Supply an `onChanged()` callback to a `TextField` or a `TextFormField`.

2. Use a `TextEditingController`.

## 1\. Supply an `onChanged()` callback to a `TextField` or a `TextFormField`

[#](#1-supply-an-onchanged-callback-to-a-textfield-or-a-textformfield)

The simplest approach is to supply an [`onChanged()`](https://api.flutter.dev/flutter/material/TextField/onChanged.html)
callback to a
[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
or a [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html).
Whenever the text changes, the callback is invoked.


In this example, print the current value and length of the text field
to the console every time the text changes.


It's important to use [characters](https://pub.dev/packages/characters) when dealing with user input,
as text may contain complex characters.
This ensures that every character is counted correctly
as they appear to the user.


dart

```
TextField(
  onChanged: (text) {
    print('First text field: $text (${text.characters.length})');
  },
),

```

content\_copy

## 2\. Use a `TextEditingController`

[#](#2-use-a-texteditingcontroller)

A more powerful, but more elaborate approach, is to supply a
[`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
as the [`controller`](https://api.flutter.dev/flutter/material/TextField/controller.html)

property of the `TextField` or a `TextFormField`.


To be notified when the text changes, listen to the controller
using the [`addListener()`](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html)
method using the following steps:


1. Create a `TextEditingController`.
2. Connect the `TextEditingController` to a text field.
3. Create a function to print the latest value.
4. Listen to the controller for changes.

### Create a `TextEditingController`

[#](#create-a-texteditingcontroller)

Create a `TextEditingController`:

dart

```
// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
​
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}
​
// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();
​
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
​
  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
  }
}

```

content\_copy

infoNote

Remember to dispose of the `TextEditingController` when it's no
longer needed. This ensures that you discard any resources used
by the object.


### Connect the `TextEditingController` to a text field

[#](#connect-the-texteditingcontroller-to-a-text-field)

Supply the `TextEditingController` to either a `TextField`
or a `TextFormField`. Once you wire these two classes together,
you can begin listening for changes to the text field.


dart

```
TextField(controller: myController),

```

content\_copy

### Create a function to print the latest value

[#](#create-a-function-to-print-the-latest-value)

You need a function to run every time the text changes.
Create a method in the `_MyCustomFormState` class that prints
out the current value of the text field.


dart

```
void _printLatestValue() {
  final text = myController.text;
  print('Second text field: $text (${text.characters.length})');
}

```

content\_copy

### Listen to the controller for changes

[#](#listen-to-the-controller-for-changes)

Finally, listen to the `TextEditingController` and call the
`_printLatestValue()` method when the text changes. Use the
[`addListener()`](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html)
method for this purpose.


Begin listening for changes when the
`_MyCustomFormState` class is initialized,
and stop listening when the `_MyCustomFormState` is disposed.


dart

```
@override
void initState() {
  super.initState();
​
  // Start listening to changes.
  myController.addListener(_printLatestValue);
}

```

content\_copy

dart

```
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  myController.dispose();
  super.dispose();
}

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
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                print('First text field: $text (${text.characters.length})');
              },
            ),
            TextField(controller: myController),
          ],
        ),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/forms/text-field-changes.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/forms/text-field-changes&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/forms/text-field-changes.md "Report an issue with this page").