---
name: flutter-for-web-developers
description: Learn how to apply Web developer knowledge when building Flutter apps.
metadata:
  url: https://docs.flutter.dev/flutter-for/web-devs
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter for web developers

This page is for users who are familiar with the HTML
and CSS syntax for arranging components of an application's UI.
It maps HTML/CSS code snippets to their Flutter/Dart code equivalents.


Flutter is a framework for building cross-platform applications
that uses the Dart programming language.
To understand some differences between programming with Dart
and programming with Javascript,
see [Learning Dart as a JavaScript Developer](https://dart.dev/guides/language/coming-from/js-to-dart).


One of the fundamental differences between
designing a web layout and a Flutter layout,
is learning how constraints work,
and how widgets are sized and positioned.
To learn more, see [Understanding constraints](/ui/layout/constraints).


The examples assume:

- The HTML document starts with `<!DOCTYPE html>`, and the CSS box model
   for all HTML elements is set to [`border-box`](https://css-tricks.com/box-sizing/),
   for consistency with the Flutter model.



  css

  ```
  {
      box-sizing: border-box;
  }

  ```

  content\_copy

- In Flutter, the default styling of the 'Lorem ipsum' text
   is defined by the `bold24Roboto` variable as follows,
   to keep the syntax simple:



  dart

  ```
  TextStyle bold24Roboto = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  ```

  content\_copy


How is react-style, or _declarative_, programming different from the
traditional imperative style?
For a comparison, see [Introduction to declarative UI](/get-started/flutter-for/declarative).


## Performing basic layout operations

[#](#performing-basic-layout-operations)

The following examples show how to perform the most common UI layout tasks.

### Styling and aligning text

[#](#styling-and-aligning-text)

Font style, size, and other text attributes that CSS
handles with the font and color properties are individual
properties of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html)
child of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget.


For text-align property in CSS that is used for aligning text,
there is a textAlign property of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html)
widget.


In both HTML and Flutter, child elements or widgets
are anchored at the top left, by default.


css

```
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Georgia;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: const Text(
    'Lorem ipsum',
    style: TextStyle(
      fontFamily: 'Georgia',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
);

```

content\_copy

### Setting background color

[#](#setting-background-color)

In Flutter, you set the background color using the `color` property
or the `decoration` property of a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html).
However, you cannot supply both, since it would potentially
result in the decoration drawing over the background color.
The `color` property should be preferred
when the background is a simple color.
For other cases, such as gradients or images,
use the `decoration` property.


The CSS examples use the hex color equivalents to the Material color palette.

css

```
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Text(
    'Lorem ipsum',
    style: bold24Roboto,
  ),
);

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
  child: Text(
    'Lorem ipsum',
    style: bold24Roboto,
  ),
);

```

content\_copy

### Centering components

[#](#centering-components)

A [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) widget centers its child both horizontally
and vertically.


To accomplish a similar effect in CSS, the parent element uses either a flex
or table-cell display behavior. The examples on this page show the flex
behavior.


css

```
<div class="grey-box">
  Lorem ipsum
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Text(
      'Lorem ipsum',
      style: bold24Roboto,
    ),
  ),
);

```

content\_copy

### Setting container width

[#](#setting-container-width)

To specify the width of a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html)

widget, use its `width` property.
This is a fixed width, unlike the CSS max-width property
that adjusts the container width up to a maximum value.
To mimic that effect in Flutter,
use the `constraints` property of the Container.
Create a new [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html)
widget with a `minWidth` or `maxWidth`.


For nested Containers, if the parent's width is less than the child's width,
the child Container sizes itself to match the parent.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    width: 100%;
    max-width: 240px;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      width: 240, // max-width is 240
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);

```

content\_copy

## Manipulating position and size

[#](#manipulating-position-and-size)

The following examples show how to perform more complex operations
on widget position, size, and background.


### Setting absolute position

[#](#setting-absolute-position)

By default, widgets are positioned relative to their parent.

To specify an absolute position for a widget as x-y coordinates,
nest it in a [`Positioned`](https://api.flutter.dev/flutter/widgets/Positioned-class.html)
widget that is,
in turn, nested in a [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html)
widget.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    position: relative;
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    position: absolute;
    top: 24px;
    left: 24px;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Stack(
    children: [
      Positioned(
        // red box
        left: 24,
        top: 24,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
          child: Text(
            'Lorem ipsum',
            style: bold24Roboto,
          ),
        ),
      ),
    ],
  ),
);

```

content\_copy

### Rotating components

[#](#rotating-components)

To rotate a widget, nest it in a [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html)
widget.
Use the `Transform` widget's `alignment` and `origin`
properties
to specify the transform origin (fulcrum) in relative and absolute terms,
respectively.


For a simple 2D rotation, in which the widget is rotated on the Z axis,
create a new [`Matrix4`](https://api.flutter.dev/flutter/vector_math_64/Matrix4-class.html)
identity object
and use its `rotateZ()` method to specify the rotation factor
using radians (degrees × π / 180).


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    transform: rotate(15deg);
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(15 * 3.1415927 / 180),
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);

```

content\_copy

### Scaling components

[#](#scaling-components)

To scale a widget up or down, nest it in a [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html)
widget.
Use the Transform widget's `alignment` and `origin` properties
to specify the transform origin (fulcrum) in relative or absolute terms,
respectively.


For a simple scaling operation along the x-axis,
create a new [`Matrix4`](https://api.flutter.dev/flutter/vector_math_64/Matrix4-class.html)
identity object
and use its `scale()` method to specify the scaling factor.


When you scale a parent widget,
its child widgets are scaled accordingly.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    transform: scale(1.5);
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scaleByDouble(1.5, 1.5, 1.5, 1.5),
      child: Container(
        // red box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[400],
        ),
        child: Text(
          'Lorem ipsum',
          style: bold24Roboto,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);

```

content\_copy

### Applying a linear gradient

[#](#applying-a-linear-gradient)

To apply a linear gradient to a widget's background,
nest it in a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html)
widget.
Then use the `Container` widget's `decoration` property to create a
[`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html)
object, and use `BoxDecoration`'s `gradient`
property to transform the background fill.


The gradient "angle" is based on the Alignment (x, y) values:

- If the beginning and ending x values are equal,
   the gradient is vertical (0° \| 180°).

- If the beginning and ending y values are equal,
   the gradient is horizontal (90° \| 270°).


#### Vertical gradient

[#](#vertical-gradient)

css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    padding: 16px;
    color: #ffffff;
    background: linear-gradient(180deg, #ef5350, rgba(0, 0, 0, 0) 80%);
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 0.6),
          colors: <Color>[
            Color(0xffef5350),
            Color(0x00ef5350),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);

```

content\_copy

#### Horizontal gradient

[#](#horizontal-gradient)

css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    padding: 16px;
    color: #ffffff;
    background: linear-gradient(90deg, #ef5350, rgba(0, 0, 0, 0) 80%);
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(0.6, 0.0),
          colors: <Color>[
            Color(0xffef5350),
            Color(0x00ef5350),
          ],
        ),
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);

```

content\_copy

## Manipulating shapes

[#](#manipulating-shapes)

The following examples show how to make and customize shapes.

### Rounding corners

[#](#rounding-corners)

To round the corners of a rectangular shape,
use the `borderRadius` property of a [`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html)
object.
Create a new [`BorderRadius`](https://api.flutter.dev/flutter/painting/BorderRadius-class.html)

object that specifies the radius for rounding each corner.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    border-radius: 8px;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red circle
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);

```

content\_copy

### Adding box shadows

[#](#adding-box-shadows)

In CSS you can specify shadow offset and blur in shorthand,
using the box-shadow property. This example shows two box shadows,
with properties:


- `xOffset: 0px, yOffset: 2px, blur: 4px, color: black @80% alpha`
- `xOffset: 0px, yOffset: 06x, blur: 20px, color: black @50% alpha`

In Flutter, each property and value is specified separately.
Use the `boxShadow` property of `BoxDecoration` to create a list of
[`BoxShadow`](https://api.flutter.dev/flutter/painting/BoxShadow-class.html)
widgets. You can define one or multiple
`BoxShadow` widgets, which can be stacked
to customize the shadow depth, color, and so on.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.8),
              0 6px 20px rgba(0, 0, 0, 0.5);
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  margin: const EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.grey[300],
  ),
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0xcc000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 6),
            blurRadius: 20,
          ),
        ],
      ),
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
      ),
    ),
  ),
);

```

content\_copy

### Making circles and ellipses

[#](#making-circles-and-ellipses)

Making a circle in CSS requires a workaround of applying a
border-radius of 50% to all four sides of a rectangle,
though there are [basic shapes](https://developer.mozilla.org/en-US/docs/Web/CSS/basic-shape).


While this approach is supported
with the `borderRadius` property of [`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html),
Flutter provides a `shape` property
with [`BoxShape` enum](https://api.flutter.dev/flutter/painting/BoxShape.html)
for this purpose.


css

```
<div class="grey-box">
  <div class="red-circle">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-circle {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    text-align: center;
    width: 160px;
    height: 160px;
    border-radius: 50%;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red circle
      decoration: BoxDecoration(
        color: Colors.red[400],
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16),
      width: 160,
      height: 160,
      child: Text(
        'Lorem ipsum',
        style: bold24Roboto,
        textAlign: TextAlign.center,
      ),
    ),
  ),
);

```

content\_copy

## Manipulating text

[#](#manipulating-text)

The following examples show how to specify fonts and other
text attributes. They also show how to transform text strings,
customize spacing, and create excerpts.


### Adjusting text spacing

[#](#adjusting-text-spacing)

In CSS, you specify the amount of white space
between each letter or word by giving a length value
for the letter-spacing and word-spacing properties, respectively.
The amount of space can be in px, pt, cm, em, etc.


In Flutter, you specify white space as logical pixels
(negative values are allowed)
for the `letterSpacing` and `wordSpacing` properties
of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html)
child of a `Text` widget.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    letter-spacing: 4px;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      child: const Text(
        'Lorem ipsum',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
    ),
  ),
);

```

content\_copy

### Making inline formatting changes

[#](#making-inline-formatting-changes)

A [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget lets you display text
with some formatting characteristics.
To display text that uses multiple styles
(in this example, a single word with emphasis),
use a [`RichText`](https://api.flutter.dev/flutter/widgets/RichText-class.html)
widget instead.
Its `text` property can specify one or more
[`TextSpan`](https://api.flutter.dev/flutter/painting/TextSpan-class.html)
objects that can be individually styled.


In the following example, "Lorem" is in a `TextSpan`
with the default (inherited) text styling,
and "ipsum" is in a separate `TextSpan` with custom styling.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem <em>ipsum</em>
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
}
.red-box em {
    font: 300 48px Roboto;
    font-style: italic;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: const EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          style: bold24Roboto,
          children: const <TextSpan>[
            TextSpan(text: 'Lorem '),
            TextSpan(
              text: 'ipsum',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 48,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

```

content\_copy

### Creating text excerpts

[#](#creating-text-excerpts)

An excerpt displays the initial line(s) of text in a paragraph,
and handles the overflow text, often using an ellipsis.


In Flutter, use the `maxLines` property of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html)
widget
to specify the number of lines to include in the excerpt,
and the `overflow` property for handling overflow text.


css

```
<div class="grey-box">
  <div class="red-box">
    Lorem ipsum dolor sit amet, consec etur
  </div>
</div>

.grey-box {
    background-color: #e0e0e0; /* grey 300 */
    width: 320px;
    height: 240px;
    font: 900 24px Roboto;
    display: flex;
    align-items: center;
    justify-content: center;
}
.red-box {
    background-color: #ef5350; /* red 400 */
    padding: 16px;
    color: #ffffff;
    overflow: hidden;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
}

```

content\_copy

dart

```
final container = Container(
  // grey box
  width: 320,
  height: 240,
  color: Colors.grey[300],
  child: Center(
    child: Container(
      // red box
      decoration: BoxDecoration(
        color: Colors.red[400],
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        'Lorem ipsum dolor sit amet, consec etur',
        style: bold24Roboto,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ),
  ),
);

```

content\_copy

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-14. [View source](https://github.com/flutter/website/blob/main/src/content/flutter-for/web-devs.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/flutter-for/web-devs&page-source=https://github.com/flutter/website/blob/main/src/content/flutter-for/web-devs.md "Report an issue with this page").