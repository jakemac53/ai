---
name: stack-based-navigation
description: Learn how to navigate from one page to another in a Flutter app.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/navigation
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Stack-based navigation

Learn to navigate between screens with Navigator.push and implement adaptive navigation patterns for different screen sizes.


### What you'll accomplish

open\_in\_newNavigate between screens with Navigator.push

swipe\_rightUse CupertinoPageRoute for iOS-style transitions

devicesCreate different navigation patterns for each screen size

* * *

## Steps

1

### Introduction

keyboard\_arrow\_up

Now that you understand slivers and scrolling,
you can implement navigation between screens.
In this lesson,
you'll update the small-screen view such that when a contact group is tapped,
it navigates to the contact list for that group.


First, revert changes in the adaptive layout widget so that it
displays the `ContactGroupsPage` by default on small screens.


lib/screens/adaptive\_layout.dart

dart

```
class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedListId = 0;
​
  void _onContactListSelected(int listId) {
    setState(() {
      selectedListId = listId;
    });
  }
​
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;
​
        if (isLargeScreen) {
          return _buildLargeScreenLayout();
        } else {
          return const ContactGroupsPage(); // Reverted
        }
      },
    );
  }
}

```

content\_copy

Continue

2

### Add navigation to contact groups

keyboard\_arrow\_up

The `ContactGroupsPage` already uses a `_ContactGroupsView`
and provides it with a callback.
That callback needs to be updated to navigate when a group is tapped,
rather than printing the group to the console.


Ensure that the `onListSelected` callback in
`lib/screens/contact_groups.dart` is implemented as follows:


lib/screens/contact\_groups.dart

dart

```
class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      onListSelected: (list) => Navigator.of(context).push(
        CupertinoPageRoute(
          title: list.title,
          builder: (context) => ContactListsPage(listId: list.id),
        ),
      ),
    );
  }
}

```

content\_copy

This small code block contains the most important new information on this page.

`Navigator.of(context)` retrieves the
nearest `Navigator` widget from the widget tree.
The `push` method adds a new route to the navigator's stack, and
displays the widget returned from the `builder` property.


This is the most basic implementation of using stack-based navigation,
where new screens are pushed on top of the current screen.
To navigate back to the previous screen, you'd use the `Navigator.pop`
method.


`CupertinoPageRoute` creates iOS-style page transitions with
the following features:


- A slide-in animation from the right.
- Automatic back button support.
- Proper title handling.
- Swipe-to-go-back gesture support.

Continue

3

### Create the sidebar component for large screens

keyboard\_arrow\_up

For large screens, you need a sidebar that doesn't navigate but
instead updates the main content area.
Thanks to the refactoring in the previous step,
creating this component is more straightforward.
Add this widget to the bottom of `lib/screens/contact_groups.dart`:


lib/screens/contact\_groups.dart

dart

```
// ...
​
/// A sidebar component for selecting contact groups, designed for large screens.
class ContactGroupsSidebar extends StatelessWidget {
  const ContactGroupsSidebar({
    super.key,
    required this.selectedListId,
    required this.onListSelected,
  });
​
  final int selectedListId;
  final Function(int) onListSelected;
​
  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: selectedListId,
      onListSelected: (list) => onListSelected(list.id),
    );
  }
}

```

content\_copy

This sidebar component reuses the `_ContactGroupsView` and
provides a different callback. Instead of navigating,
it calls `onListSelected` with the ID of the tapped list.
It also passes the `selectedListId` to `_ContactGroupsView`
so that
the selected item can be highlighted.


Continue

4

### Create the detail view for large screens

keyboard\_arrow\_up

For the large screen layout, you need a detail view that
doesn't show navigation controls. Just like the sidebar,
this can be recreated by reusing the `_ContactListView`.
Add this widget to the bottom of your `contacts.dart` file:


lib/screens/contacts.dart

dart

```
// ...
​
/// A detail view component for showing contacts in a specific list.
class ContactListDetail extends StatelessWidget {
  const ContactListDetail({super.key, required this.listId});
​
  final int listId;
​
  @override
  Widget build(BuildContext context) {
    return _ContactListView(
      listId: listId,
      automaticallyImplyLeading: false,
    );
  }
}

```

content\_copy

The detail view reuses `_ContactListView` and sets
the `automaticallyImplyLeading` parameter to `false`
to
hide the back button, as navigation is handled by the sidebar.


Continue

5

### Connect the sidebar to the adaptive layout

keyboard\_arrow\_up

Now, connect the sidebar to your adaptive layout.
Update your `adaptive_layout.dart` file to import the necessary files and
update the large screen layout:


lib/screens/adaptive\_layout.dart

dart

```
import 'package:flutter/cupertino.dart';
import 'package:rolodex/screens/contact_groups.dart';
import 'package:rolodex/screens/contacts.dart';

```

content\_copy

Then update the `_buildLargeScreenLayout` method:

lib/screens/adaptive\_layout.dart

dart

```
Widget _buildLargeScreenLayout() {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.extraLightBackgroundGray,
    child: SafeArea(
      child: Row(
        children: [
          SizedBox(
            width: 320,
            child: ContactGroupsSidebar(
              selectedListId: selectedListId,
              onListSelected: _onContactListSelected,
            ),
          ),
          Container(
            width: 1,
            color: CupertinoColors.separator,
          ),
          Expanded(
            child: ContactListDetail(listId: selectedListId),
          ),
        ],
      ),
    ),
  );
}

```

content\_copy

This code creates the classic menu-detail layout where the sidebar
controls the content of the detail area.


Continue

6

### Test the adaptive navigation behavior

keyboard\_arrow\_up

Hot reload your app and test the navigation:

**Small screens (<600px width):**

- Tap contact groups to navigate to contact details.
- Use the back button or a swipe gesture to return.
- This is a classic stack-based navigation flow.

**Large screens (>600px width):**

- Click contact groups in the sidebar to update the detail view.
- There is no navigation stack. The selection updates the content area.
- This is a master-detail interface pattern.

The app automatically chooses the
appropriate navigation pattern based on screen size.
This provides an optimal experience on both phones and tablets.


Continue

7

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circleopen\_in\_newNavigated between screens with Navigator.pushkeyboard\_arrow\_up

`Navigator.of(context).push` adds a new route to the navigation stack. This is the foundation of stack-based navigation, where screens are pushed on top of each other and popped to go back.


swipe\_rightUsed CupertinoPageRoute for iOS-style transitionskeyboard\_arrow\_up

`CupertinoPageRoute` provides support for native iOS navigation features: slide-in animations from the right, automatic back buttons, proper title handling, and swipe-to-go-back gesture support.


devicesImplemented adaptive navigation patternskeyboard\_arrow\_up

You set up different navigation patterns for small and large screens. Small screens use stack-based navigation where tapping a group pushes a new screen. Large screens use a master-detail pattern where selecting a group updates the detail panel without navigation.


celebrationCompleted the Rolodex appkeyboard\_arrow\_up

You've built a complete iOS-style contacts app with adaptive layouts, advanced scrolling, collapsible headers with search, and responsive navigation. These are common patterns used in production apps!


Continue

8

### Test yourself

keyboard\_arrow\_up

### Navigation Quiz

1 / 2

**What does \`Navigator.of(context).push\` do?**

1. Replaces the current screen with a new one.







Not quite



Push adds to the stack; \`pushReplacement\` replaces the current screen.

2. Adds a new route to the navigation stack, displaying it on top of the current screen.







That's right!



Push adds the new route to the stack, allowing users to go back to the previous screen.

3. Removes the current screen from the navigation stack.







Not quite



That's what \`pop\` does; push adds a new screen.

4. Opens a dialog box over the current screen.







Not quite



Dialogs use \`showDialog\`; Navigator.push navigates to a full screen.


**What does \`Navigator.of(context).pop()\` do?**

1. Closes the entire app.







Not quite



Pop only removes the current route; it doesn't close the app.

2. Removes the current route from the navigation stack, returning to the previous screen.







That's right!



Pop removes the top route from the stack, revealing the screen beneath it.

3. Clears all routes and shows the home screen.







Not quite



That would require popUntil or pushAndRemoveUntil; pop removes only the top route.

4. Refreshes the current screen with new data.







Not quite



Pop navigates back; to refresh, you'd use setState or other state management.


PreviousNext question

Finish

[chevron\_left\
PreviousScrolling and slivers](/learn/tutorial/slivers)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/navigation.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/navigation&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/navigation.md "Report an issue with this page").