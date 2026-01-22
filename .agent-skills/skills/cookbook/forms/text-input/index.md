---
name: create-and-style-a-text-field
description: How to implement a text field.
metadata:
  url: https://docs.flutter.dev/cookbook/forms/text-input
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create and style a text field

Text fields allow users to type text into an app.
They are used to build forms,
send messages, create search experiences, and more.
In this recipe, explore how to create and style text fields.


Flutter provides two text fields:
[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)
and [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html).


## `TextField`

[#](#textfield)

[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) is the most commonly used text input widget.


By default, a `TextField` is decorated with an underline.
You can add a label, icon, inline hint text, and error text by supplying an
[`InputDecoration`](https://api.flutter.dev/flutter/material/InputDecoration-class.html)
as the [`decoration`](https://api.flutter.dev/flutter/material/TextField/decoration.html)

property of the `TextField`.
To remove the decoration entirely (including the
underline and the space reserved for the label),
set the `decoration` to null.


dart

```
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'Enter a search term',
  ),
),

```

content\_copy

To retrieve the value when it changes,
see the [Handle changes to a text field](/cookbook/forms/text-field-changes/)
recipe.


## `TextFormField`

[#](#textformfield)

[`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html)
wraps a `TextField` and integrates it
with the enclosing [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html).
This provides additional functionality,
such as validation and integration with other
[`FormField`](https://api.flutter.dev/flutter/widgets/FormField-class.html)
widgets.


dart

```
TextFormField(
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Enter your username',
  ),
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
    const appTitle = 'Form Styling Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
      ],
    );
  }
}
```

For more information on input validation, see the
[Building a form with validation](/cookbook/forms/validation/) recipe.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-28. [View source](https://github.com/flutter/website/blob/main/src/content/cookbook/forms/text-input.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/cookbook/forms/text-input&page-source=https://github.com/flutter/website/blob/main/src/content/cookbook/forms/text-input.md "Report an issue with this page").