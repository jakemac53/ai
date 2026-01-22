---
name: retrieve-the-value-of-a-text-field
description: How to retrieve text from a text field.
metadata:
  url: https://docs.flutter.dev/cookbook/forms/retrieve-input
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Retrieve the value of a text field

In this recipe,
learn how to retrieve the text a user has entered into a text field
using the following steps:


1. Create a `TextEditingController`.
2. Supply the `TextEditingController` to a `TextField`.
3. Display the current value of the text field.

## 1\. Create a `TextEditingController`

[#](#1-create-a-texteditingcontroller)

To retrieve the text a user has entered into a text field,
create a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)

and supply it to a `TextField` or `TextFormField`.


feedbackImportant

Call `dispose` of the `TextEditingController` when
you've finished using it. This ensures that you discard any resources
used by the object.


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
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
​
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
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

## 2\. Supply the `TextEditingController` to a `TextField`

[#](#2-supply-the-texteditingcontroller-to-a-textfield)

Now that you have a `TextEditingController`, wire it up
to a text field using the `controller` property:


dart

```
return TextField(controller: myController);

```

content\_copy

## 3\. Display the current value of the text field

[#](#3-display-the-current-value-of-the-text-field)

After supplying the `TextEditingController` to the text field,
begin reading values. Use the [`text`](https://api.flutter.dev/flutter/widgets/TextEditingController/text.html)

property provided by the `TextEditingController` to retrieve the
String that the user has entered into the text field.


The following code displays an alert dialog with the current
value of the text field when the user taps a floating action button.


dart

```
FloatingActionButton(
  // When the user presses the button, show an alert dialog containing
  // the text that the user has entered into the text field.
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text that the user has entered by using the
          // TextEditingController.
          content: Text(myController.text),
        );
      },
    );
  },
  tooltip: 'Show me the value!',
  child: const Icon(Icons.text_fields),
),

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
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retrieve Text Input')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(controller: myController),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
```

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/forms/retrieve-input.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/forms/retrieve-input&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/forms/retrieve-input.md "Report an issue with this page").