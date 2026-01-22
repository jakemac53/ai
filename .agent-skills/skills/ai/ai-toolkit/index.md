---
name: flutter-ai-toolkit
description: Learn how to add the AI Toolkit chatbot to your Flutter application.
metadata:
  url: https://docs.flutter.dev/ai/ai-toolkit
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Flutter AI Toolkit

Hello and welcome to the Flutter AI Toolkit!

The AI Toolkit is a set of AI chat-related widgets that make it easy to add an
AI chat window to your Flutter app. The AI Toolkit is organized around an
abstract LLM provider API to make it easy to swap out the LLM provider that
you'd like your chat provider to use. Out of the box, it comes with support for
[Firebase AI Logic](https://firebase.google.com/docs/ai-logic).


## Key features

[#](#key-features)

- **Multiturn chat**: Maintains context across multiple interactions.
- **Streaming responses**: Displays AI responses in real-time as they are
   generated.

- **Rich text display**: Supports formatted text in chat messages.
- **Voice input**: Allows users to input prompts using speech.
- **Multimedia attachments**: Enables sending and receiving various media types.
- **Function calling**: Supports tool calls to the LLM provider.
- **Custom styling**: Offers extensive customization to match your app's design.
- **Chat serialization/deserialization**: Store and retrieve conversations
   between app sessions.

- **Custom response widgets**: Introduce specialized UI components to present
   LLM responses.

- **Pluggable LLM support**: Implement a simple interface to plug in your own
   LLM.

- **Cross-platform support**: Compatible with Android, iOS, web, and macOS
   platforms.


## Demo

[#](#demo)

Here's what the demo example looks like hosting the AI Toolkit:

![AI demo app](/assets/images/docs/ai-toolkit/ai-toolkit-app.png)

The [source code for this demo](https://github.com/flutter/ai/blob/main/example/lib/demo/demo.dart)
is available in the repo on GitHub.


Or, you can open it in [Firebase Studio](https://firebase.studio/), Google's full-stack AI workspace and
IDE that runs in the cloud:


[![Try in Firebase Studio](https://cdn.firebasestudio.dev/btn/try_blue_32.svg)](https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fai)

## Get started

[#](#get-started)

1. **Installation**
   Add the following dependencies to your `pubspec.yaml` file:



   yaml

   ```
   dependencies:
     flutter_ai_toolkit: ^latest_version
     firebase_ai: ^latest_version
     firebase_core: ^latest_version

   ```

   content\_copy

2. **Configuration**
   The AI Toolkit supports both the Gemini endpoint (for prototyping) and the
   Vertex endpoint (for production). Both require a Firebase project and the
   `firebase_core` package to be initialized, as described in the [Get started with\
   the Gemini API using the Firebase AI Logic SDKs](https://firebase.google.com/docs/ai-logic/get-started?platform=flutter) docs.

   Once that's complete, integrate the new Firebase project into your Flutter app
   using the `flutterfire CLI` tool, as described in the [Add Firebase to your\
   Flutter app](https://firebase.google.com/docs/flutter/setup) docs.

   After following these instructions, you're ready to use Firebase to integrate AI
   in your Flutter app. Start by initializing Firebase:



   dart

   ```
   import 'package:firebase_core/firebase_core.dart';
   import 'package:firebase_ai/firebase_ai.dart';
   import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
   ​
   // ... other imports
   ​
   import 'firebase_options.dart'; // from `flutterfire config`
   ​
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
     runApp(const App());
   }
   ​
   // ...app stuff here

   ```

   content\_copy



   With Firebase properly initialized in your Flutter app, you're now ready to
   create an instance of the Firebase provider. You can do this in two ways. For
   prototyping, consider the Gemini AI endpoint:



   dart

   ```
   import 'package:firebase_ai/firebase_ai.dart';
   import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
   ​
   // ... app stuff here
   ​
   class ChatPage extends StatelessWidget {
     const ChatPage({super.key});
   ​
     @override
     Widget build(BuildContext context) => Scaffold(
           appBar: AppBar(title: const Text(App.title)),
           // create the chat view, passing in the Firebase provider
           body: LlmChatView(
             provider: FirebaseProvider(
               // Use the Google AI endpoint
               model: FirebaseAI.googleAI().generativeModel(
                 model: 'gemini-2.5-flash',
               ),
             ),
           ),
         );
   }

   ```

   content\_copy



   The `FirebaseProvider` class exposes the Firebase AI Logic SDK to the
   `LlmChatView`. Note that you provide a model name ( [you have several\
   options](https://firebase.google.com/docs/vertex-ai/gemini-models#available-model-names) from which to choose), but you do not provide an API key. All
   of that is handled as part of the Firebase project.

   For production workloads, it's easy to swap in the Firebase Logic AI endpoint:



   dart

   ```
   class ChatPage extends StatelessWidget {
     const ChatPage({super.key});
   ​
     @override
     Widget build(BuildContext context) => Scaffold(
           appBar: AppBar(title: const Text(App.title)),
           body: LlmChatView(
             provider: FirebaseProvider(
               // Use the Vertex AI endpoint
               model: FirebaseAI.vertexAI().generativeModel(
                 model: 'gemini-2.5-flash',
               ),
             ),
           ),
         );
   }

   ```

   content\_copy



   For a complete example, check out the [gemini.dart](https://github.com/flutter/ai/blob/main/example/lib/gemini/gemini.dart) and [vertex.dart](https://github.com/flutter/ai/blob/main/example/lib/vertex/vertex.dart)
   examples.

3. **Set up device permissions**
   To enable your users to take advantage of features like voice input and media
   attachments, ensure that your app has the necessary permissions:

   - **Network access:** To enable network access on macOS, add the following to
     your `*.entitlements` files:



     xml

     ```
     <plist version="1.0">
       <dict>
         ...
         <key>com.apple.security.network.client</key>
         <true/>
       </dict>
     </plist>

     ```

     content\_copy



     To enable network access on Android, ensure that your `AndroidManifest.xml`
     file contains the following:



     xml

     ```
     <manifest xmlns:android="http://schemas.android.com/apk/res/android">
         ...
         <uses-permission android:name="android.permission.INTERNET"/>
     </manifest>

     ```

     content\_copy

   - **Microphone access**: Configure according to the [record package's permission\
     setup instructions](https://pub.dev/packages/record#setup-permissions-and-others).

   - **File selection**: Follow the [file\_selector plugin's instructions](https://pub.dev/packages/file_selector#usage).

   - **Image selection**: To take a picture on _or_ select a picture from their
     device, refer to the [image\_picker plugin's installation\
     instructions](https://pub.dev/packages/image_picker#installation).

   - **Web photo**: To take a picture on the web, configure the app according to
     the [camera plugin's setup instructions](https://pub.dev/packages/camera#setup).

## Examples

[#](#examples)

**firebase\_options.dart**

To use the [Vertex AI example app](https://github.com/flutter/ai/blob/main/example/lib/vertex/vertex.dart), place your Firebase configuration
details into the `example/lib/firebase_options.dart` file. You can do this with
the `flutterfire CLI` tool as described in the [Add Firebase to your Flutter\
app](https://firebase.google.com/docs/flutter/setup) docs **from within the `example` directory**.


:::
note **Be careful not to check the `firebase_options.dart` file into your git**
**repo.**
:::


## Feedback

[#](#feedback)

Along the way, as you use this package, please [log issues and feature\
requests](https://github.com/flutter/ai/issues) as well as submit any [code you'd like to\
contribute](https://github.com/flutter/ai/pulls). We want your feedback and your contributions to ensure that
the AI Toolkit is just as robust and useful as it can be for your real-world
apps.


[NextUser experience\
chevron\_right](/ai/ai-toolkit/user-experience)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-7. [View source](https://github.com/flutter/website/blob/main/src/content/ai/ai-toolkit/index.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/ai-toolkit&page-source=https://github.com/flutter/website/blob/main/src/content/ai/ai-toolkit/index.md "Report an issue with this page").