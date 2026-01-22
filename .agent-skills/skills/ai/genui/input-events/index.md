---
name: input-and-events
description: How input and events are handled in GenUI applications.
metadata:
  url: https://docs.flutter.dev/ai/genui/input-events
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Input and events

This guide explains how user interactions are handled
within the GenUI package, from the initial widget
interaction to the AI agent receiving the event.


constructionExperimental

The `genui` package is in alpha and is likely to change.

## Overview

[#](#overview)

In the GenUI architecture, the UI is driven by the AI,
but user interactions (like clicking a button or submitting a form)
must be communicated back to the AI agent.
This allows the agent to update the UI or perform actions
in response to user input.


The flow of an event is as follows:

1. Interaction: User interacts with a widget;
    for example, the user taps a button.

2. Capture: The widget implementation dispatches a `UiEvent`.
3. Processing: The framework adds context
    (such as a `surfaceId` or data model values)
    and forwards the event.

4. Transmission: The Flutter widget generates the event,
    adds the appropriate context, and routes
    it to the AI through the `ContentGenerator`,
    which forwards it to the AI agent.


## Defining events

[#](#defining-events)

### Protocol level

[#](#protocol-level)

The A2UI protocol defines a `userAction` message used to report events.
A `userAction` contains:


- `name`: The name of the action
   (defined by the AI when generating the component).

- `surfaceId`: The ID of the UI surface where the event occurred.
- `sourceComponentId`: The ID of the component that triggered the event.
- `context`: A JSON object containing data relevant to the event.
- `timestamp`: When the event occurred.

### Dart implementation

[#](#dart-implementation)

In [`package:genui`](https://pub.dev/packages/genui), user events are represented by the
`UiEvent` extension type and its concrete implementation
`UserActionEvent`.


The following structures are defined in
`lib/src/model/ui_models.dart`:


lib/src/model/ui\_models.dart

dart

```
/// A data object that represents a user interaction event in the UI.
extension type UiEvent.fromMap(JsonMap _json) { ... }
​
/// A UI event that represents a user action.
extension type UserActionEvent.fromMap(JsonMap _json) implements UiEvent {
  UserActionEvent({
    String? surfaceId,
    required String name,
    required String sourceComponentId,
    JsonMap? context,
    // ...
  }) : ...
}

```

content\_copy

## Capturing events in widgets

[#](#capturing-events-in-widgets)

Widgets in GenUI are defined in a `Catalog`,
which includes information about what events
the widget can send to the AI.
The AI can then send
information about how to communicate those events back.
When you implement a custom widget (or use the standard widgets),
you use the `dispatchEvent` method in `CatalogItemContext`
to dispatch events.


### Example: Button implementation

[#](#button-example)

The following example shows how a `Button` widget typically captures
a tap and dispatches an event. It retrieves the action definition
(provided by the AI) from its properties,
resolves any data bindings in the context, and sends the event.


dart

```
// Inside a CatalogItem widgetBuilder:
widgetBuilder: (itemContext) {
  // 1. Extract action data from the component properties.
  final buttonData = _ButtonData.fromMap(itemContext.data as JsonMap);
  final JsonMap actionData = buttonData.action;
  final actionName = actionData['name'] as String;
​
  // 2. Extract context definition (which data to send back).
  final List<Object?> contextDefinition =
      (actionData['context'] as List<Object?>?) ?? <Object?>[];
​
  return ElevatedButton(
    onPressed: () {
      // 3. Resolve the context values from the data model.
      final JsonMap resolvedContext = resolveContext(
        itemContext.dataContext,
        contextDefinition,
      );
​
      // 4. Dispatch the event.
      itemContext.dispatchEvent(
        UserActionEvent(
          name: actionName,
          sourceComponentId: itemContext.id,
          context: resolvedContext,
        ),
      );
    },
    child: /* ... */
  );
},

```

content\_copy

## Event processing pipeline

[#](#event-processing-pipeline)

Once `dispatchEvent` is called,
the event travels through the GenUI core layers.


### GenUISurface

[#](#genuisurface)

The `GenUiSurface` widget (in `lib/src/core/genui_surface.dart`)
wraps the rendered widgets.
It provides the dispatchEvent callback implementation.


When `_dispatchEvent` is called:

1. It automatically injects the `surfaceId` into the event,
    ensuring the AI knows which surface the interaction came from.

2. It delegates handling to the `GenUiHost`
    (implemented by `A2uiMessageProcessor`).


dart

```
// GenUiSurface implementation details
void _dispatchEvent(UiEvent event) {
  // ...
  final Map<String, Object?> eventMap = {
    ...event.toMap(),
    surfaceIdKey: widget.surfaceId, // Inject surfaceId
  };
  final UiEvent newEvent = UserActionEvent.fromMap(eventMap);
  widget.host.handleUiEvent(newEvent);
}

```

content\_copy

### A2uiMessageProcessor

[#](#a2uimessageprocessor)

The `A2uiMessageProcessor` (in `lib/src/core/a2ui_message_processor.dart`)
is the central hub for managing UI state.


When `handleUiEvent` is called, it does the following:

1. Verifies the event type.
2. Wraps the event in the `userAction` JSON envelope
    required by the protocol.

3. Emits a `UserUiInteractionMessage` on its `onSubmit` stream.

dart

```
// A2uiMessageProcessor implementation details
@override
void handleUiEvent(UiEvent event) {
  if (event is! UserActionEvent) return;
​
  // Wrap in protocol 'userAction' envelope
  final String eventJsonString = jsonEncode({'userAction': event.toMap()});
​
  // Emit for listeners (like GenUiConversation)
  _onSubmit.add(UserUiInteractionMessage.text(eventJsonString));
}

```

content\_copy

## Transmission to AI

[#](#transmission-to-ai)

The final step sends the event to the AI Agent.
This is typically handled by `GenUiConversation`
(in `lib/src/facade/gen_ui_conversation.dart`).
The `GenUiConversation` listens to the `onSubmit` stream
from the message processor.


dart

```
// GenUiConversation constructor
_userEventSubscription = a2uiMessageProcessor.onSubmit.listen(sendRequest);

```

content\_copy

When an event is received, the `sendRequest` method:

1. Calls `contentGenerator.sendRequest` with the `UserUiInteractionMessage`.
2. The `ContentGenerator` (perhaps `GoogleGenerativeAiContentGenerator` or
    `A2uiContentGenerator`) handles the network transport to the AI Agent.


The AI Agent receives this JSON message, processes the user action,
and might stream back new `surfaceUpdate` or `dataModelUpdate`
messages
to modify the UI, or some other action, completing the full interaction loop.


[chevron\_left\
PreviousGet started with the GenUI SDK for Flutter](/ai/genui/get-started)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2025-12-17. [View source](https://github.com/flutter/website/blob/main/src/content/ai/genui/input-events.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/genui/input-events&page-source=https://github.com/flutter/website/blob/main/src/content/ai/genui/input-events.md "Report an issue with this page").