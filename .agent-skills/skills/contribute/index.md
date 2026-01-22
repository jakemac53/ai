---
name: contribute-to-flutter
description: Learn about contributing to the Flutter project and its surrounding ecosystem.
metadata:
  url: https://docs.flutter.dev/contribute
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Contribute to Flutter

![Dash and her friends excited for your contribution](/assets/images/dash/dash-contribute.png)

If you would like to contribute to the
Flutter project and its surrounding ecosystem,
we're happy to have your help!


Flutter is an open-source project that thrives on community contributions.
No matter whether you're fixing a bug, proposing a new feature,
improving documentation, or helping others in the community,
your efforts are valuable and appreciated.


This page provides a non-exhaustive overview of how you can get involved.
If you need help contributing or would like more suggestions on getting started,
consider reaching out on the [Flutter contributors Discord](https://flutter.dev/chat).


feedbackImportant

Before beginning your journey of contributing to Flutter,
please make sure to read and follow Flutter's [Code of conduct](https://github.com/flutter/flutter/blob/main/CODE_OF_CONDUCT.md).


Also, learn more about Flutter's [culture of inclusivity](https://flutter.dev/culture) and
[core values](https://github.com/flutter/flutter/blob/main/docs/about/Values.md).


[Use Flutter\
\
Create your own apps with Flutter and provide valuable feedback.](#develop-with-flutter) [Contribute code\
\
Contribute directly to the code underlying Flutter.](#contribute-code) [Write docs\
\
Enhance the Flutter learning experience by writing documentation.](#write-documentation) [Triage issues\
\
Ensure Flutter contributors can make the most impact.](#triage-issues) [Develop packages\
\
Strengthen the Dart and Flutter package ecosystem.](#strengthen-the-package-ecosystem) [Support the community\
\
Help other Flutter developers benefit from your expertise.](#support-the-community)

## Develop with Flutter

[#](#develop-with-flutter)

Even just using Flutter and providing feedback is a valuable contribution!

### Provide feedback

[#](#provide-feedback)

Sharing your feedback and experiences helps the Flutter team
understand and prioritize developer needs and pain points.


You can provide valuable feedback through many avenues, including:

- Upvoting existing issues

  If you're experiencing an issue that has already been reported,
   consider upvoting it to help the Flutter team understand its importance.

  Avoid otherwise empty thumbs up, +1, or similar comments.
   However, if you have additional information,
   such as reproduction steps or additional version information,
   do consider providing those details in a new comment.

- Reporting new bugs

  If you experience a bug with Flutter that hasn't yet been reported,
   do [open a new issue](https://github.com/flutter/flutter/issues/new)
   with reproduction information.

- Requesting features

  If there's a feature you think Flutter should add or implement
   but hasn't yet been suggested, do [open a new issue](https://github.com/flutter/flutter/issues/new)
   with
   all relevant information as well as your use case.

- Partaking in surveys

  Occasionally, the Flutter team will run developer surveys and studies.
   To help understand pain points and improve the Flutter developer experience,
   consider responding with as much feedback and details as possible.

  To sign up for future UX research studies,
   visit [flutter.dev/research-signup](https://flutter.dev/research-signup).

- Discussing proposals

  Major changes to Flutter are often discussed through [design documents](https://github.com/flutter/flutter/blob/main/docs/contributing/Design-Documents.md).
   Consider reading and providing feedback on proposals that are
   relevant to you or your apps.

  To find current design docs and proposals,
   check out [issues with the `design doc` label](https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22design+doc%22)
   on
   the GitHub issue database.

- Reviewing pull requests

  If you're familiar with a particular area of Flutter
   or a solution to a particular issue is important to you,
   consider reviewing open pull requests, trying them with your app,
   and providing any relevant feedback.


### Try out the beta channel

[#](#try-out-the-beta-channel)

To help ensure Flutter's stability and improve upcoming features,
help test upcoming releases before they reach the stable channel.


Consider testing releases on the `beta` channel,
both for general development and for testing compatibility with your apps.


Any feedback you have or regressions you encounter,
make sure to [report them](https://github.com/flutter/flutter/issues/new/choose)
to the Flutter team.


To get started,
[switch](/install/upgrade#change-channels) to the [`beta` channel](/install/upgrade#the-beta-channel)
today
and account for any [necessary migrations](/release/breaking-changes).


## Contribute code

[#](#contribute-code)

Directly improve Flutter's codebase and related tools.

### Flutter framework

[#](#flutter-framework)

Found a bug in a built-in widget, have an idea for a new one,
love adding tests, or just interested in the internals of Flutter?
Consider contributing to the Flutter framework itself
and improving the core of Flutter for everyone.


To learn about contributing to the Flutter framework,
check out the Flutter [contribution guide](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md).


### Flutter engine

[#](#flutter-engine)

Interested in implementing the primitives and platform integrations
that underlay Flutter or have a knack for graphics programming?
Consider contributing to the Flutter engine and
making Flutter even more portable, performant, and powerful.


To learn about contributing to the Flutter engine,
check out the Flutter [contribution guide](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)

and how to [Set up the engine development environment](https://github.com/flutter/flutter/blob/main/engine/src/flutter/docs/contributing/Setting-up-the-Engine-development-environment.md).


### Flutter packages

[#](#flutter-packages)

Contribute to first-party packages that are
maintained by the Flutter team.
The first-party packages provide essential functionality for apps
as well as encapsulate various platform-specific functionality.


To learn about contributing to the first-party packages,
check out the Flutter [contribution guide](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)

as well as the packages-specific [contribution guide](https://github.com/flutter/packages/blob/main/CONTRIBUTING.md).


### DevTools

[#](#devtools)

Contributing to the [Dart and Flutter DevTools](/tools/devtools) is a
great place to begin contributing due to its relatively low-cost setup.
Enhance and fixes can greatly impact the developer experience
for Flutter developers and perhaps help you develop your own apps.


To get started, check out
the [DevTools `CONTRIBUTING.md` guide](https://github.com/flutter/devtools/blob/master/CONTRIBUTING.md).


### Site infrastructure

[#](#site-infrastructure)

Fix bugs, improve accessibility, or add features to the
Dart and Flutter websites.


If you're familiar with web development or site generation,
contributing to the Dart and Flutter websites can be a great avenue
to improve the learning experience of Flutter developers.


Depending on your interests,
you might want to contribute to:


- The pub.dev site
  - **Live site:** [`pub.dev`](https://pub.dev)
  - **Repository:** [`dart-lang/pub-dev`](https://github.com/dart-lang/pub-dev)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/dart-lang/pub-dev/blob/master/CONTRIBUTING.md)
- The Flutter documentation site
  - **Live site:** [`docs.flutter.dev`](https://docs.flutter.dev)
  - **Repository:** [`flutter/website`](https://github.com/flutter/website)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/flutter/website/blob/main/CONTRIBUTING.md)
- The Dart documentation site
  - **Live site:** [`dart.dev`](https://dart.dev)
  - **Repository:** [`dart-lang/site-www`](https://github.com/dart-lang/site-www)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/dart-lang/site-www/blob/main/CONTRIBUTING.md)
- DartPad
  - **Live site:** [`dartpad.dev`](https://dartpad.dev)
  - **Repository:** [`dart-lang/dart-pad`](https://github.com/dart-lang/dart-pad)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/dart-lang/dart-pad/blob/main/CONTRIBUTING.md)
- The `dartdoc` tool
  - **Live site:** [`api.flutter.dev`](https://api.flutter.dev)
  - **Repository:** [`dart-lang/dartdoc`](https://github.com/dart-lang/dartdoc)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/dart-lang/dartdoc/blob/main/CONTRIBUTING.md)

### Dart SDK

[#](#dart-sdk)

Contribute to the Dart language and surrounding tooling,
improving the client-optimized language that
forms the foundation of Flutter's excellent developer experience.


Dart's contribution workflow is slightly different,
so if you're interested, make sure to check out its
[contribution](https://github.com/dart-lang/sdk/blob/main/CONTRIBUTING.md)
and [building](https://github.com/dart-lang/sdk/blob/main/docs/Building.md) guides.


### Code samples

[#](#code-samples)

Improve or add samples demonstrating Flutter features,
helping developers that prefer to learn by example.


You can always share your own samples or templates,
or you can contribute to Flutter-maintained samples:


- Full project samples
  - **Location:** [`flutter/samples`](https://github.com/flutter/samples)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/flutter/samples/blob/main/CONTRIBUTING.md)
- API doc samples
  - **Location:** [`flutter/flutter/packages/flutter`](https://github.com/flutter/flutter/tree/main/packages/flutter)
  - **Contribution guide:** [`README.md`](https://github.com/flutter/flutter/tree/main/dev/snippets)
- Website code snippets
  - **Location:** [`flutter/website/examples`](https://github.com/flutter/website/tree/main/examples)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/flutter/website/blob/main/CONTRIBUTING.md)
- Flutter repo samples
  - **Location:** [`flutter/flutter/examples`](https://github.com/flutter/flutter/tree/main/examples)
  - **Contribution guide:** [`CONTRIBUTING.md`](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md)

## Write documentation

[#](#write-documentation)

Contributing to Flutter documentation, no matter the form,
is one of the most impactful ways you can help Flutter.


### Flutter API docs

[#](#flutter-api-docs)

The API docs are heavily relied on by many Flutter developers,
both online and in their code editors.


Whether you're interested in writing new docs, updating existing ones,
adding relevant code snippets, or even creating new visuals like diagrams,
your contribution to the API docs will be
appreciated by every Flutter developer.


To get started, check out
the [Flutter SDK contribution guide](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md),
particularly its section on [API documentation](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md#api-documentation)

### Documentation website

[#](#documentation-website)

Consider contributing to this very site,
guiding developers as they learn and explore Flutter.


To learn about contributing to the Flutter documentation website,
check out the website's [contribution documentation](https://github.com/flutter/website/blob/main/CONTRIBUTING.md).


You can also contribute to the [Dart website](https://dart.dev),
enhancing the documentation for the client-optimized language
that forms the foundation of Flutter.
To learn how to contribute,
check out the [`dart-lang/site-www` contribution docs](https://github.com/dart-lang/site-www/tree/main?tab=readme-ov-file#getting-started).


## Triage issues

[#](#triage-issues)

Help the Flutter team by triaging incoming bug reports and feature requests.

There are plenty of ways to help in [Flutter's issue database](https://github.com/flutter/flutter/issues),
including but not limited to:


- Determining issue validity
- Ensuring actionability
- Documenting affected versions
- Adding reproduction steps
- Identifying duplicate or resolved issues
- Solving or redirecting support queries

To get started helping with issues,
read about [helping out in the issue database](https://github.com/flutter/flutter/blob/main/CONTRIBUTING.md#helping-out-in-the-issue-database)
and
learn about Flutter's approach to
[issue triage](https://github.com/flutter/flutter/blob/main/docs/triage/README.md)
and [issue hygiene](https://github.com/flutter/flutter/tree/main/docs/contributing/issue_hygiene).


## Strengthen the package ecosystem

[#](#strengthen-the-package-ecosystem)

Help grow and support the collection of
available Dart and Flutter packages on [pub.dev](https://pub.dev/).


### Contribute to packages you use

[#](#contribute-to-packages-you-use)

To give back to packages you depend on and potentially even help your own apps,
find packages you rely on and contribute back to them.


To contribute to a package,
navigate to its page on the [pub.dev site](https://pub.dev)
and find the repository linked in the page's sidenav.


Before contributing, do make sure to
follow each package's contribution guide,
discuss your contribution with the maintainers, and
keep in mind Flutter's [Code of conduct](https://github.com/flutter/flutter/blob/main/CODE_OF_CONDUCT.md).


### Open source reusable functionality from your app

[#](#open-source-reusable-functionality-from-your-app)

If you've built a cool, generic widget or utility in your app,
consider extracting it into a package and publishing it to pub.dev.


To get started, learn about
[Creating Dart packages](https://dart.dev/tools/pub/create-packages) and
[Developing Flutter packages](/packages-and-plugins/developing-packages).
Then, when you're ready to publish your package to the [pub.dev site](https://pub.dev),
follow the guide and best practices on [Publishing packages](https://dart.dev/tools/pub/publishing).


### Add Dart or Flutter support to popular SDKs

[#](#add-dart-or-flutter-support-to-popular-sdks)

Create or contribute to packages that wrap native SDKs or web APIs.

Before creating a new package,
first try to find any existing wrappers that you
could use or contribute to on the [pub.dev site](https://pub.dev).


Depending on the SDK and platform,
you might need to [Write platform-specific code](/platform-integration/platform-channels),
use [JS interop](https://dart.dev/interop/js-interop), wrap a REST API using
[`package:http`](https://pub.dev/packages/http),
or reimplement the required functionality in Dart.


If you're planning to create a new package, learn about
[Creating Dart packages](https://dart.dev/tools/pub/create-packages) and
[Developing Flutter packages](/packages-and-plugins/developing-packages).
Then, when you're ready to publish your package to the [pub.dev site](https://pub.dev),
follow the guide and best practices on [Publishing packages](https://dart.dev/tools/pub/publishing).


## Support the community

[#](#support-the-community)

Help other developers learn Flutter and
succeed as they build their own apps.


### Help other developers

[#](#help-other-developers)

Share your Flutter knowledge and expertise
to help your fellow Flutter developers succeed.


This can take many forms from starting a Flutter help channel in your company
to answering questions on public forums.


Some common locations Flutter developers look for help include:

- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Dev Discord](https://discord.com/invite/rflutterdev)
- [Dart Community Discord](https://discord.com/invite/Qt6DgfAWWx)
- [r/FlutterDev on Reddit](https://www.reddit.com/r/FlutterDev)
- [GitHub issues](https://github.com/flutter/flutter/issues)
- [Flutter Forum](https://forum.itsallwidgets.com/)

### Host events

[#](#host-events)

Connect with other Flutter enthusiasts and
organize local, national, and even virtual events.
Events can be anything, from study groups and simple meetups,
to workshops and hackathons.


For inspiration and support,
check out existing [Flutter events](https://flutter.dev/events),
learn more about the [Flutter community](https://flutter.dev/community), and
explore the [Flutter Meetup Network](https://www.meetup.com/pro/flutter/).


### Post about Flutter

[#](#post-about-flutter)

Share your insights and projects with the wider Flutter community.

There are endless options for sharing about Flutter
and connecting with the developer community.
Some common outlets include:


- Blog posts
- Video tutorials
- Short-form posts
- Forum threads
- GitHub discussions
- Link aggregation boards

Post or share about whatever you're passionate about,
but if you're not sure what to post,
consider posting about topics that developers often ask about.


If the platform you're posting on supports tagging posts,
consider adding the `#Flutter` and `#FlutterDev` hashtags
to help other developers find your content.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-9-5. [View source](https://github.com/flutter/website/blob/main/src/content/contribute/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/contribute&page-source=https://github.com/flutter/website/blob/main/src/content/contribute/index.md "Report an issue with this page").