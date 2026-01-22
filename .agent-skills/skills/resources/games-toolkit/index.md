---
name: casual-games-toolkit
description: Learn about free & open source multiplatform 2D game development in Flutter.
metadata:
  url: https://docs.flutter.dev/resources/games-toolkit
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Casual Games Toolkit

The Flutter Casual Games Toolkit pulls together new and existing resources
so you can accelerate development of games on mobile platforms.


This page outlines where you can find these available resources.

## Why Flutter for games?

[#](#why-flutter-for-games)

The Flutter framework can create performant apps for six target platforms
from the desktop to mobile devices to the web.


With Flutter's benefits of cross-platform development, performance, and
open source licensing, it makes a great choice for games.


Casual games fall into two categories: turn-based games
and real-time games.
You might be familiar with both types of games,
though perhaps you didn't think about them in quite this way.


_Turn-based games_ cover games meant for a mass market with
simple rules and gameplay.
This includes board games, card games, puzzles, and strategy games.
These games respond to simple user input,
like tapping on a card or entering a number or letter.
These games are well suited for Flutter.


_Real-time games_ cover games with a series of actions that
require real-time responses.
These include endless runner games, racing games, and so on.
You might want to create a game with advanced features like collision detection,
camera views, game loops, and the like.
These types of games could use an open source game engine like the
[Flame game engine](https://flame-engine.org/) built using Flutter.


## What's included in the toolkit

[#](#whats-included-in-the-toolkit)

The Casual Games Toolkit provides the following free resources.

- A repository that includes three game templates that provide
   a starting point for building a casual game.
  1. A [base game template](https://github.com/flutter/games/tree/main/templates/basic)
      that includes the basics for:

     - Main menu
     - Navigation
     - Settings
     - Level selection
     - Player progress
     - Play session management
     - Sound
     - Themes
  2. A [card game template](https://github.com/flutter/games/tree/main/templates/card)
      that includes everything in the base template plus:

     - Drag and drop
     - Game state management
     - Multiplayer integration hooks
  3. An [endless runner template](https://github.com/flutter/games/tree/main/templates/endless_runner)
      created in partnership
      with the open source game engine, Flame. It implements:

     - A FlameGame base template
     - Player steering
     - Collision detection
     - Parallax effects
     - Spawning
     - Different visual effects
  4. A sample game built on top of the endless runner template,
      called SuperDash. You can play the game on iOS, Android,
      or [web](https://superdash.flutter.dev/), [view the open source code repo](https://github.com/flutter/super_dash), or
      [read how the game was created in 6 weeks](https://blog.flutter.dev/how-we-built-the-new-super-dash-demo-in-flutter-and-flame-in-just-six-weeks-9c7aa2a5ad31).
- Developer guides for integrating needed services.

- A link to a [Flame Discord](https://discord.gg/qUyQFVbV45) channel.
   If you have a Discord account, use this [direct link](https://discord.com/login?redirect_to=%2Fchannels%2F509714518008528896%2F788415774938103829).


The included game templates and cookbook recipes make certain choices
to accelerate development.
They include specific packages, like `provider`, `google_mobile_ads`,
`in_app_purchase`, `audioplayers`, `crashlytics`, and
`games_services`.
If you prefer other packages, you can change the code to use them.


The Flutter team understands that monetization might be a future consideration.
Cookbook recipes for advertising and in-app purchases have been added.


As explained on the [Games](https://flutter.dev/games) page,
you can leverage up to $900 in offers when you integrate Google services,
such as [Cloud, Firebase](https://cloud.google.com/free), and [Ads](https://ads.google.com/intl/en_us/home/flutter/#!/), into your game.


feedbackImportant

You must connect your Firebase and GCP accounts to use credits for
Firebase services and verify your business email during sign up to earn
an additional $100 on top of the normal $300 credit.
For the Ads offer, [check your region's eligibility](https://www.google.com/intl/en/ads/coupons/terms/flutter/).


## Get started

[#](#get-started)

Are you ready? To get started:

1. If you haven't done so, [install Flutter](/get-started).

2. [Clone the games repo](https://github.com/flutter/games).

3. Review the `README` file for the first type of game you want to create.
   - [basic game](https://github.com/flutter/games/blob/main/templates/basic/README.md)
   - [card game](https://github.com/flutter/games/blob/main/templates/card/README.md)
   - [runner game](https://github.com/flutter/games/blob/main/templates/endless_runner/README.md)
4. [Join the Flame community on Discord](https://discord.gg/qUyQFVbV45)
    (use the [direct link](https://discord.com/login?redirect_to=%2Fchannels%2F509714518008528896%2F788415774938103829)
    if you already
    have a Discord account).

5. Review the codelabs and cookbook recipes.
   - Build a [multiplayer game](/cookbook/games/firestore-multiplayer) with Cloud Firestore.
   - Build a [word puzzle](https://codelabs.developers.google.com/codelabs/flutter-word-puzzle)
      with Flutter.
   - Make your games more engaging
      with [leaderboards and achievements](/cookbook/games/achievements-leaderboard).
   - Monetize your games with [in-game ads](/cookbook/plugins/google-mobile-ads)
      and [in-app purchases](https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases#0).
   - Add user authentication flow to your game with
      [Firebase Authentication](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#0).
   - Collect analytics about crashes and errors inside your game
      with [Firebase Crashlytics](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter).
6. Set up accounts on AdMob, Firebase, and Cloud, as needed.

7. Write your game!

8. Deploy to both the Google Play and Apple stores.


## Example games

[#](#example-games)

For Google I/O 2022, both the Flutter team
and Very Good Ventures created new games.


- VGV created the [I/O Pinball game](https://pinball.flutter.dev/#/) using the Flame engine.
   To learn about this game,
   check out [I/O Pinball Powered by Flutter and Firebase](https://medium.com/flutter/di-o-pinball-powered-by-flutter-and-firebase-d22423f3f5d)
   on Medium
   and [play the game](https://pinball.flutter.dev/#/) in your browser.

- The Flutter team created [I/O Flip](https://flip.withgoogle.com/#/), a virtual [CCG](https://en.wikipedia.org/wiki/Collectible_card_game).
   To learn more about I/O Flip,
   check out [How It's Made: I/O FLIP adds a twist to a classic card game with generative AI](https://developers.googleblog.com/2023/05/how-its-made-io-flip-adds-twist-to.html)

   on the Google Developers blog and [play the game](https://flip.withgoogle.com/#/)
   in your browser.


## Other resources

[#](#other-resources)

Once you feel ready to go beyond these games templates,
investigate other resources that our community recommended.


FeatureResourcesAnimation and sprites

book\_5 [Special effects](/cookbook/effects)

handyman [Spriter Pro](https://store.steampowered.com/app/332360/Spriter_Pro/)

package\_2 [rive](https://pub.dev/packages/rive)

package\_2 [spritewidget](https://pub.dev/packages/spritewidget)

App review

package\_2 [app\_review](https://pub.dev/packages/app_review)

Audio

package\_2 [audioplayers](https://pub.dev/packages/audioplayers)

package\_2 [flutter\_soloud](https://pub.dev/packages/flutter_soloud)

Authentication

science [User Authentication using Firebase](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#0)

Cloud services

science [Add Firebase to your Flutter game](https://firebase.google.com/docs/flutter/setup)

Debugging

quick\_reference\_all [Firebase Crashlytics overview](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter)

package\_2 [firebase\_crashlytics](https://pub.dev/packages/firebase_crashlytics)

Drivers

package\_2 [win32\_gamepad](https://pub.dev/packages/win32_gamepad)

Game assets

and asset tools

photo\_album [CraftPix](https://craftpix.net)

photo\_album [Game Developer Studio](https://www.gamedeveloperstudio.com)

handyman [GIMP](https://www.gimp.org)

Game engines

package\_2 [Flame](https://pub.dev/packages/flame)

package\_2 [Bonfire](https://pub.dev/packages/bonfire)

package\_2 [forge2d](https://pub.dev/packages/forge2d)

Game features

book\_5 [Add achievements and leaderboards to your game](/cookbook/games/achievements-leaderboard)

book\_5 [Add multiplayer support to your game](/cookbook/games/firestore-multiplayer)

Game services integration

package\_2 [games\_services](https://pub.dev/packages/games_services)

Level editor

handyman [Tiled](https://www.mapeditor.org/)

Monetization

book\_5 [Add advertising to your Flutter game](/cookbook/plugins/google-mobile-ads)

science [Add AdMob ads to a Flutter app](https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter)

science [Add in-app purchases to your Flutter app](https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases#0)

science [Gaming UX and Revenue Optimizations for Apps](https://flutter.dev/go/games-revenue) (PDF)

Persistence

package\_2 [shared\_preferences](https://pub.dev/packages/shared_preferences)

package\_2 [sqflite](https://pub.dev/packages/sqflite)

package\_2 [cbl\_flutter](https://pub.dev/packages/cbl_flutter) (Couchbase Lite)

Special effects

api [Paint API](https://api.flutter.dev/flutter/dart-ui/Paint-class.html)

book\_5 [Special effects](/cookbook/effects)

User Experience

quick\_reference\_all [Best practices for optimizing Flutter web loading speed](https://blog.flutter.dev/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c)

## Other resources

[#](#other-resources-1)

Check out the following videos:

- [Building multiplatform games with Flutter](https://youtube.com/watch?v=7mG_sW40tsw), a talk
   given at the [Game Developer Conference (GDC)](https://gdconf.com/) 2024.

- [How to build a physics-based game with Flutter and Flame's Forge2D](https://youtube.com/watch?v=nsnQJrYHHNQ),
   from Google I/O 2024.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-21. [View source](https://github.com/flutter/website/blob/main/src/content/resources/games-toolkit.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/resources/games-toolkit&page-source=https://github.com/flutter/website/blob/main/src/content/resources/games-toolkit.md "Report an issue with this page").