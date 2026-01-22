---
name: google-apis
description: How to use Google APIs with Flutter.
metadata:
  url: https://docs.flutter.dev/data-and-backend/google-apis
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Google APIs

The [Google APIs package](https://pub.dev/packages/googleapis) exposes dozens of Google
services that you can use from Dart projects.


This page describes how to use APIs that interact with
end-user data by using Google authentication.


Examples of user-data APIs include
[Calendar](https://pub.dev/documentation/googleapis/latest/calendar_v3/calendar_v3-library.html),
[Gmail](https://pub.dev/documentation/googleapis/latest/gmail_v1/gmail_v1-library.html), [YouTube](https://pub.dev/documentation/googleapis/latest/youtube_v3/youtube_v3-library.html), and Firebase.


infoNote

The only APIs you should use directly from your Flutter
project are those that access user data using Google authentication.


APIs that require [service accounts](https://cloud.google.com/iam/docs/service-account-overview) **should not**
be used directly from a Flutter application.
Doing so requires shipping service credentials as part
of your application, which is not secure.
To use these APIs,
we recommend creating an intermediate service.


To add authentication to Firebase explicitly, check out the
[Add a user authentication flow to a Flutter app using FirebaseUI](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps)

codelab and the
[Get Started with Firebase Authentication on Flutter](https://firebase.google.com/docs/auth/flutter/start)
docs.


## Overview

[#](#overview)

To use Google APIs, follow these steps:

1. Pick the desired API
2. Enable the API
3. Authenticate and determine the current user
4. Obtain an authenticated HTTP client
5. Create and use the desired API class

## 1\. Pick the desired API

[#](#1-pick-the-desired-api)

The documentation for [`package:googleapis`](https://pub.dev/documentation/googleapis)
lists
each API as a separate Dart library&emdash;in a
`name_version` format.
Check out [`youtube_v3`](https://pub.dev/documentation/googleapis/latest/youtube_v3/youtube_v3-library.html)
as an example.


Each library might provide many types,
but there is one _root_ class that ends in `Api`.
For YouTube, it's [`YouTubeApi`](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi-class.html).


Not only is the `Api` class the one you need to
instantiate (see step 3), but it also
exposes the scopes that represent the permissions
needed to use the API. For example,
the [Constants section](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi-class.html#constants)
of the
`YouTubeApi` class lists the available scopes.
To request access to read (but not write) an end-user's
YouTube data, authenticate the user with
[`youtubeReadonlyScope`](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi/youtubeReadonlyScope-constant.html).


dart

```
/// Provides the `YouTubeApi` class.
import 'package:googleapis/youtube/v3.dart';

```

content\_copy

## 2\. Enable the API

[#](#2-enable-the-api)

To use Google APIs you must have a Google account
and a Google project. You also
need to enable your desired API.


This example enables [YouTube Data API v3](https://console.cloud.google.com/apis/library/youtube.googleapis.com).
For details, see the [getting started instructions](https://cloud.google.com/apis/docs/getting-started).


## 3\. Authenticate and determine the current user

[#](#3-authenticate-and-determine-the-current-user)

Use the [google\_sign\_in](https://pub.dev/packages/google_sign_in) package to
authenticate users with their Google identity.
Configure sign in for each platform you want to support.


dart

```
/// Provides the `GoogleSignIn` class.
import 'package:google_sign_in/google_sign_in.dart';

```

content\_copy

The package's functionality is accessed through
a static instance of the [`GoogleSignIn`](https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html)
class.
Before interacting with the instance,
the `initialize` method must be called and allowed to complete.


dart

```
final _googleSignIn = GoogleSignIn.instance;
​
@override
void initState() {
  super.initState();
  _googleSignIn.initialize();
  // ···
}

```

content\_copy

Once initialization is complete but before user authentication,
listen to authentication events to determine if a user signed in.


dart

```
GoogleSignInAccount? _currentUser;
​
@override
void initState() {
  super.initState();
  _googleSignIn.initialize().then((_) {
    _googleSignIn.authenticationEvents.listen((event) {
      setState(() {
        _currentUser = switch (event) {
          GoogleSignInAuthenticationEventSignIn() => event.user,
          _ => null,
        };
      });
    });
  });
}

```

content\_copy

Once you're listening to any relevant authentication events,
you can attempt to authenticate a previously signed-in user.


dart

```
void initState() {
  super.initState();
  _googleSignIn.initialize().then((_) {
    // ...
    // Attempt to authenticate a previously signed in user.
    _googleSignIn.attemptLightweightAuthentication();
  });
}

```

content\_copy

To also allow for new users to authenticate,
follow the instructions provided by
[`package:google_sign_in`](https://pub.dev/packages/google_sign_in).


Once a user has been authenticated,
you must obtain an authenticated HTTP client.


## 4\. Obtain an authenticated HTTP client

[#](#4-obtain-an-authenticated-http-client)

Once you have a signed-in user, request the
relevant client authorization tokens using [`authorizationForScopes`](https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizationForScopes.html)

for the API scopes that your app requires.


dart

```
const relevantScopes = [YouTubeApi.youtubeReadonlyScope];
final authorization = await currentUser.authorizationClient
    .authorizationForScopes(relevantScopes);

```

content\_copy

infoNote

If your scopes require user interaction,
you'll need to use [`authorizeScopes`](https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignInAuthorizationClient/authorizeScopes.html)
from an interaction handler
instead of `authorizationForScopes`.


Once you have the relevant authorization tokens,
use the [`authClient`](https://pub.dev/documentation/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authClient.html)
extension from
[`package:extension_google_sign_in_as_googleapis_auth`](https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth)
to
set up an authenticated HTTP client with the relevant credentials applied.


dart

```
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

```

content\_copy

dart

```
final authenticatedClient = authorization!.authClient(
  scopes: relevantScopes,
);

```

content\_copy

## 5\. Create and use the desired API class

[#](#5-create-and-use-the-desired-api-class)

Use the API to create the desired API type and call methods.
For instance:


dart

```
final youTubeApi = YouTubeApi(authenticatedClient);
​
final favorites = await youTubeApi.playlistItems.list(
  ['snippet'],
  playlistId: 'LL', // Liked List
);

```

content\_copy

## More information

[#](#more-information)

You might want to check out the following:

- The [`extension_google_sign_in_as_googleapis_auth` example](https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth/example)

   is a working implementation of the concepts described on this page.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-10-30. [View source](https://github.com/flutter/website/blob/main/src/content/data-and-backend/google-apis.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/data-and-backend/google-apis&page-source=https://github.com/flutter/website/blob/main/src/content/data-and-backend/google-apis.md "Report an issue with this page").