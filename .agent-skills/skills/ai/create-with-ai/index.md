---
name: create-with-ai
description: Learn how to use AI to build Flutter apps, from powerful SDKs that integrate AI features directly into your app to tools that accelerate your development workflow.
metadata:
  url: https://docs.flutter.dev/ai/create-with-ai
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Create with AI

This guide covers how you can leverage AI tools to build AI-powered
features for your Flutter apps and streamline your
Flutter and Dart development.


## Overview

[#](#overview)

AI can be used for building AI-powered apps with Flutter and for accelerating
your development workflow. You can integrate AI-powered features like natural
language understanding and content generation directly into your Flutter app
using powerful SDKs, like the Firebase SDK for Generative AI. You can also use
AI tools, such as Gemini Code Assist and Gemini CLI, to help with code
generation and scaffolding. These tools are powered by the Dart and Flutter MCP
server, which provides AI with a rich context about your codebase. The Flutter
Extension for Gemini CLI makes it easy to leverage official rules, the MCP server,
and custom commands for building your app. Additionally, rules files help
fine-tune the AI's behavior and enforce project-specific best practices.


## Build AI-powered experiences with Flutter

[#](#build-ai-powered-experiences-with-flutter)

Using AI in your Flutter app unlocks new user experiences that allow your app to
support natural language understanding and content generation.


To get started building AI-powered experiences in Flutter, check out these
resources:


- [Firebase AI Logic](https://firebase.google.com/docs/ai-logic) \- The official Firebase SDK for using generative AI
   features directly in Flutter. Compatible with the Gemini Developer API or
   Vertex AI. To get started, check out the
   [official documentation](https://firebase.google.com/docs/ai-logic/get-started).

- [Flutter AI Toolkit](/ai/ai-toolkit) \- A sample app with pre-built widgets to help you build
   AI-powered features in Flutter.


## AI development tools

[#](#ai-development-tools)

AI isn't only a feature in your app, but can also be a powerful assistant in
your development workflow. Tools like [Antigravity](https://antigravity.google/),
[Gemini Code Assist](https://codeassist.google/), [Gemini CLI](https://geminicli.com/),
[Claude Code](https://www.claude.com/product/claude-code),
[Cursor](https://cursor.com/), and [Windsurf](https://windsurf.com/)
can help you write code faster, understand complex
concepts, and reduce boilerplate.


### GenUI SDK for Flutter

[#](#genui)

The GenUI SDK transforms text-based conversations into rich,
interactive experiences. Essentially, it acts as an orchestration layer
that coordinates the flow of information between your user, your
Flutter widgets, and an AI agent.


[Watch on YouTube in a new tab: "Getting started with GenUI"](https://www.youtube.com/watch/nWr6eZKM6no)

constructionExperimental

The `genui` package is in
alpha and is likely to change.


To learn more, visit the [GenUI SDK for Flutter](/ai/genui) documentation.

### Antigravity

[#](#antigravity)

[Antigravity](https://antigravity.google/) is an in-IDE AI agent that can read and write code, run
terminal commands, and help you build complex features. Some of its capabilities
include:


- **Agentic capabilities**: Unlike chat-based assistants, Antigravity can
   proactively edit files and run terminal commands to complete tasks.

- **Complex reasoning**: It can plan and execute multi-step workflows which
   makes it suitable for larger refactors or feature implementations.

- **Verification**: It can run tests and verify its own changes to ensure
   correctness.


### Gemini Code Assist

[#](#gemini-code-assist)

[Gemini Code Assist](https://codeassist.google/) is an AI-powered collaborator available for IDEs like
Visual Studio Code, JetBrains IDEs, and Android Studio. It has a deep
understanding of your project's codebase and can help you with:


- **Code completion and generation**: It suggests and generates entire blocks of
   code based on the context of what you're writing.

- **In-editor chat**: You can ask questions about your code, Flutter concepts,
   or best practices directly within your IDE.

- **Debugging and explanation**: If you encounter an error, you can ask Gemini
   Code Assist to explain it and suggest a fix, and
   [Dart and Flutter MCP server](#dart-and-flutter-mcp-server)

### Gemini CLI

[#](#gemini-cli)

The [Gemini CLI](https://geminicli.com/) is a command-line AI workflow tool. It allows you to interact
with Gemini models for a variety of tasks without leaving your development
environment. You can use it to:


- Quickly scaffold a new Flutter widget, Dart function, or a complete app.
- Use MCP server tools, such as the Dart and Flutter MCP server
- Automate tasks like committing and pushing changes to a Git repository

To get started, visit the [Gemini CLI](https://geminicli.com/) website, or try this
[Gemini CLI codelab](https://codelabs.developers.google.com/gemini-cli-hands-on).


#### Flutter extension for Gemini CLI

[#](#flutter-extension-for-gemini-cli)

The [Flutter extension for Gemini CLI](https://github.com/gemini-cli-extensions/flutter) combines the
[Dart and Flutter MCP server](https://dart.dev/tools/mcp-server) with rules and commands.
It uses the default set of [AI rules for Flutter and Dart](/ai/ai-rules),
adds commands like `/create-app` and `/modify` to make
structured changes to your app, and automatically configures the
[Dart and Flutter MCP server](https://dart.dev/tools/mcp-server).


You can install it by running the following command:

bash

```
gemini extensions install https://github.com/gemini-cli-extensions/flutter

```

content\_copy

To learn more, check out
[Flutter extension for Gemini CLI](/ai/flutter-ext-for-gemini).


### Dart and Flutter MCP server

[#](#dart-and-flutter-mcp-server)

To provide assistance during Flutter development, AI tools
need to communicate with Dart and Flutter's developer tools.
The Dart and Flutter MCP server facilitates this communication.
The MCP (model context protocol) specification outlines how
development tools can share the context of a user's code with an AI model,
which allows the AI to better understand and interact with the code.


The Dart and Flutter MCP server unlocks the full potential of your AI assistant
by connecting it directly to your development environment. It enables the AI to:


- **Introspect the widget tree**: Visualize and debug layout issues in your running app.

- **Manage dependencies**: Search pub.dev for packages and add them to your project.
- **Control the runtime**: Trigger hot reloads and restarts to see changes instantly.
- **Fix complex errors**: Analyze static and runtime errors with deep context.

This bridges the gap between the AI's natural language understanding,
and Dart and Flutter's suite of developer tools.


To get started, check out the official documentation for the
[Dart and Flutter MCP server](https://dart.dev/tools/mcp-server)
on dart.dev and the [Dart and Flutter MCP repository](https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server).


### Rules for Flutter and Dart

[#](#rules-for-flutter-and-dart)

You can use a rules file with AI-powered editors to provide
context and instructions to an underlying LLM. To get
started, visit the [AI rules for Flutter and Dart](/ai/ai-rules) guide.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/ai/create-with-ai.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/create-with-ai&page-source=https://github.com/flutter/website/blob/main/src/content/ai/create-with-ai.md "Report an issue with this page").