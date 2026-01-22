---
name: chat-client-sample
description: Learn about the chat client sample included in the AI Toolkit.
metadata:
  url: https://docs.flutter.dev/ai/ai-toolkit/chat-client-sample
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Chat client sample

The AI Chat sample is meant to be a full-fledged chat app built using the
Flutter AI Toolkit and the Firebase AI Logic SDK. In addition to all of the
multi-shot, multi-media, streaming features that it gets from the AI Toolkit,
the AI Chat sample shows how to store and manage multiple chats at once in your
own apps. On desktop form-factors, the AI Chat sample looks like the following:


![Desktop app UI](/assets/images/docs/ai-toolkit/desktop-pluto-convo.png)

On mobile form-factors, it looks like this:

![Mobile app UI](/assets/images/docs/ai-toolkit/mobile-pluto-convo.png)

The chats are stored in an authenticated Cloud Firestore database; any
authenticated user can have as many chats as they like.


In addition, for each new chat, while the user can manually title it whatever
they like, the initial prompt and response is used to ask the LLM what an
appropriate title should be. In fact, the titles of the chats in the screenshots
in this page were set automatically.


To build and run the sample, follow the instructions in the [AI Chat README](https://github.com/csells/flutter_ai_chat).


[chevron\_left\
PreviousCustom LLM providers](/ai/ai-toolkit/custom-llm-providers)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-7. [View source](https://github.com/flutter/website/blob/main/src/content/ai/ai-toolkit/chat-client-sample.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/ai-toolkit/chat-client-sample&page-source=https://github.com/flutter/website/blob/main/src/content/ai/ai-toolkit/chat-client-sample.md "Report an issue with this page").