---
name: flutter-ai-best-practices
description: Learn best practices for building AI-powered Flutter apps using guardrails to  verify and correct AI-generated data.
metadata:
  url: https://docs.flutter.dev/ai/best-practices
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter AI best practices

Flutter and AI go well together on multiple levels. If you're using AI to
generate Flutter code, you only have to generate the code for a single app to
target multiple platforms. And if you're harnessing Gemini to implement features
in your app, the Firebase AI Logic SDK makes that simple, with an easy-to-use
API, and secure, by keeping the API keys out of your code.


If you're new to AI for either of these two use cases, you should know: as good
as it is (and the Gemini 3 Pro Preview is _very_ good), AI still makes mistakes.
If you're using AI to write your code, then you can use guardrails to keep AI on
track using tools like the Flutter analyzer and unit tests.


But what do you do when you're using AI to implement the features in your app,
knowing that sometimes it's going to get things wrong? Or, to quote a friend of
mine:


_**Morgan's Law**_

_"Eventually, due to the nature of sampling from a probability distribution,_
_\[AI\] will fail to do the thing that must be done."_

_–Brett Morgan, Flutter Developer Relations Engineer, July, 2025._

The good news is that, just as you can use developer tools to build guardrails
around the AI writing your code, you can use Flutter to build guardrails around
the AI you use to implement your features. The [Crossword Companion\
app](https://github.com/flutter/demos/tree/main/crossword_companion) was built to demonstrate these techniques.

![Crossword Companion app interface showing a 5-step setup process starting with selecting a crossword image.](/assets/images/docs/ai-best-practices/crossword-companion-app-interface-showin.png)

The goal of the Crossword Companion app is not to help you cheat at
mini-crosswords – although it's darn good at that – but to illustrate how to
channel the power of AI using Flutter. As an example, the first thing you do
when running the app is upload the screenshot of a mini-crossword puzzle. When
you press the **Next** button, the AI uses that image to infer the size,
contents and clues of the puzzle:

![Crossword Companion app showing a 5x5 grid with settings incorrectly displaying 4 rows and 5 columns.](/assets/images/docs/ai-best-practices/crossword-companion-app-showing-a-5x5-gr.png)

Notice that while the crossword puzzle is a 5x5 grid, the AI says it's 4x5.
Because we know that mistakes happen (apparently AIs are only human, too), we
built the app to allow the user to verify and correct the AI-generated data.
That's important; bad data leads to bad results.


So this write-up is not about the app in detail but rather about the best
practices to use when you're building your own AI apps with Flutter. So let's
get to it!


[NextPrompting\
chevron\_right](/ai/best-practices/prompting)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-7. [View source](https://github.com/flutter/website/blob/main/src/content/ai/best-practices/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/best-practices&page-source=https://github.com/flutter/website/blob/main/src/content/ai/best-practices/index.md "Report an issue with this page").