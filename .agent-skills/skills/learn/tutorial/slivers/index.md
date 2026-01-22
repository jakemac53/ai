---
name: advanced-scrolling-and-slivers
description: Learn how to implement performant scrolling with slivers.
metadata:
  url: https://docs.flutter.dev/learn/tutorial/slivers
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Advanced scrolling and slivers

In this lesson, you'll learn about slivers,
which are special widgets that can take advantage of
Flutter's powerful and composable scrolling system.
Slivers enable you to create sophisticated scroll effects,
including collapsible headers, search integration, and custom scroll behaviors.
By the end of this section, you'll understand how to
use `CustomScrollView`, create navigation bars that collapse,
and organize content in scrollable sections.


### What you'll accomplish

view\_dayUnderstand slivers and how they differ from widgets

unfold\_moreBuild scrollable layouts with CustomScrollView

searchCreate collapsible navigation bars with search

sort\_by\_alphaOrganize contacts in alphabetized sections

* * *

## Steps

1

### Slivers and widgets

keyboard\_arrow\_up

Slivers are scrollable areas that can be composed together in a
`CustomScrollView` or other scroll views.
Think of slivers as building blocks that each
contribute a portion of the overall scrollable content.


While slivers and widgets are both fundamental Flutter concepts,
they serve different purposes and aren't interchangeable.


- **Widgets** are general UI building blocks that
can be used anywhere in your widget tree.

- **Slivers** are specialized widgets designed specifically for
scrollable layouts and have some constraints:

- Slivers can **only** be direct children of scroll views, such as
`CustomScrollView` and `NestedScrollView`.

- Some scroll views **only** accept slivers as children.
You can't pass regular widgets to `CustomScrollView.slivers`.

- To use regular widgets within a sliver context,
wrap them in `SliverToBoxAdapter` or `SliverFillRemaining`.


This architectural separation allows Flutter to
optimize scrolling performance while it maintains clear boundaries between
different types of UI components.


Continue

2

### Add a basic sliver structure to contact groups

keyboard\_arrow\_up

First, replace the placeholder content in your contact groups page.
To avoid duplicating code between the phone layout and the tablet sidebar,
you can create a private, reusable widget.


Update `lib/screens/contact_groups.dart` by
adding `_ContactGroupsView` to the bottom of the file.


lib/screens/contact\_groups.dart

dart

```
// New imports
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';
​
// ... ContactGroupsPage widget ...
​
// New
class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.onListSelected,
    this.selectedListId,
  });
​
  final int? selectedListId;
  final Function(ContactGroup) onListSelected;
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Lists'),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (context, contactLists, child) {
                return CupertinoListSection.insetGrouped(
                  header: const Text('iPhone'),
                  children: [
                    for (final ContactGroup contactList in contactLists)
                      CupertinoListTile(
                        title: Text(contactList.label),
                        onTap: () => onListSelected(contactList),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

```

content\_copy

This private widget contains the shared UI for
displaying the list of contact groups.
On small screens, it will be used as a page, and on
large screens it will be used to fill the left column.


This widget introduces several slivers:

- `CupertinoSliverNavigationBar`:
An opinionated navigation bar that collapses as the page scrolls.

- `SliverList`:
A scrollable list of items.

- `SliverFillRemaining`:
A sliver that takes up the remaining space in
the scroll area, and whose child is a non-sliver widget.


It accepts a callback function, `onListSelected`, to handle taps,
which makes it adaptable for both navigation and sidebar selection.


Now, update `ContactGroupsPage` to use your new `_ContactGroupsView` widget:

lib/screens/contact\_groups.dart

dart

```
class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) {
        // TODO: Implement navigation lesson.
        debugPrint(list.toString());
      },
    );
  }
}
// ... _ContactGroupsView from above

```

content\_copy

This structure keeps the `ContactGroupsPage` clean and
focused on its primary responsibility: navigation,
which you'll learn about in the next section of this tutorial.


Continue

3

### Enhance the list with icons and visual elements

keyboard\_arrow\_up

Now, add icons and contact counts to make the list more informative.
Add this `_buildTrailing` helper method to your `_ContactGroupsView`
class:


lib/screens/contact\_groups.dart

dart

```
// Inside _ContactGroupsView:
​
Widget _buildTrailing(List<Contact> contacts, BuildContext context) {
  final TextStyle style = CupertinoTheme.of(
    context,
  ).textTheme.textStyle.copyWith(color: CupertinoColors.systemGrey);
​
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(contacts.length.toString(), style: style),
      const Icon(
        CupertinoIcons.forward,
        color: CupertinoColors.systemGrey3,
        size: 18,
      ),
    ],
  );
}

```

content\_copy

This helper creates the trailing content for each list item.
It shows the contact count and a forward arrow.


Now, update the `CupertinoListSection` in `_ContactGroupsView` to
use icons and the trailing helper. Update the code within the
`ListenableBuilder.builder` callback in the `build`
method:


lib/screens/contact\_groups.dart

dart

```
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';
​
class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});
​
  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) {
        // TODO: Implement navigation lesson.
        debugPrint(list.toString());
      },
    );
  }
}
​
class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.onListSelected,
    this.selectedListId,
  });
​
  final int? selectedListId;
  final Function(ContactGroup) onListSelected;
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Lists'),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (context, contactLists, child) {
​
                // New from here:
                const groupIcon = Icon(
                  CupertinoIcons.group,
                  weight: 900,
                  size: 32,
                );
​
                const pairIcon = Icon(
                  CupertinoIcons.person_2,
                  weight: 900,
                  size: 24,
                );
​
                return CupertinoListSection.insetGrouped(
                  header: const Text('iPhone'),
                  children: [
                    for (final ContactGroup contactList in contactLists)
                      CupertinoListTile(
                        leading: contactList.id == 0 ? groupIcon : pairIcon,
                        title: Text(contactList.label),
                        trailing: _buildTrailing(contactList.contacts, context),
                        onTap: () => onListSelected(contactList),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
​
  Widget _buildTrailing(List<Contact> contacts, BuildContext context) {
    //...
  }
}

```

content\_copy

The updated code now shows icons that differentiate between the
main "All iPhone" group and user-created groups, along with
contact counts and navigation indicators.


Continue

4

### Create advanced scrolling for contacts

keyboard\_arrow\_up

Now, work on the contacts page. Just like before,
you'll create a private, reusable view to avoid code duplication.


In the next lesson, you'll implement navigation for small screens.
To see your progress on the contacts list page in the meantime,
update `AdaptiveLayout` to display the contacts list page:


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
          return const ContactsListPage(listId: 0); // New, temporary
        }
      },
    );
  }
}

```

content\_copy

Update `lib/screens/contacts.dart` by adding `_ContactListView` to
the bottom of the file:


lib/screens/contacts.dart

dart

```
class _ContactListView extends StatelessWidget {
  const _ContactListView({
    required this.listId,
    this.automaticallyImplyLeading = true,
  });
​
  final int listId;
  final bool automaticallyImplyLeading;
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (context, contactGroups, child) {
          final ContactGroup contactList =
              contactGroupsModel.findContactList(listId);
​
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(contactList.title),
                automaticallyImplyLeading: automaticallyImplyLeading,
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                      '${contactList.contacts.length} contacts in ${contactList.label}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

```

content\_copy

Now, update `ContactListsPage` to use this view:

lib/screens/contacts.dart

dart

```
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';
​
class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});
​
  final int listId;
​
  @override
  Widget build(BuildContext context) {
    return _ContactListView(listId: listId);
  }
}
​
// ... _ContactListView from above.

```

content\_copy

This basic implementation demonstrates how to use slivers with dynamic
data in a reusable component.


Continue

5

### Add search integration with slivers

keyboard\_arrow\_up

Now, enhance the contacts page with integrated search functionality UI.
Update the `CustomScrollView` in `_ContactListView`
to use the
`CupertinoSliverNavigationBar.search` constructor instead of the
default `CupertinoSliverNavigationBar` constructor:


dart

```
class _ContactListView extends StatelessWidget {
  const _ContactListView({
    required this.listId,
  });
​
  final int listId;
​
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (context, contactGroups, child) {
          final ContactGroup contactList = contactGroupsModel.findContactList(
            listId,
          );
​
          return CustomScrollView(
            slivers: [
              // New
              CupertinoSliverNavigationBar.search(
                largeTitle: Text(contactList.title),
                searchField: const CupertinoSearchTextField(
                  suffixIcon: Icon(CupertinoIcons.mic_fill),
                  suffixMode: OverlayVisibilityMode.always,
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    '${contactList.contacts.length} contacts in ${contactList.label}',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

```

content\_copy

The `CupertinoSliverNavigationBar.search` constructor provides
integrated search functionality. As you scroll down,
the search field smoothly transitions into the collapsed navigation bar.


Continue

6

### Create alphabetized contact sections

keyboard\_arrow\_up

Real-world contact apps organize contacts alphabetically.
To do this, create sections for each letter.
Add the following widget to the bottom of your `contacts.dart`
file.
This widget doesn't contain any slivers.


lib/screens/contacts.dart

dart

```
// ...
​
class ContactListSection extends StatelessWidget {
  const ContactListSection({
    super.key,
    required this.lastInitial,
    required this.contacts,
  });
​
  final String lastInitial;
  final List<Contact> contacts;
​
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              lastInitial,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CupertinoListSection(
            backgroundColor: CupertinoColors.systemBackground,
            dividerMargin: 0,
            additionalDividerMargin: 0,
            topMargin: 4,
            children: [
              for (final Contact contact in contacts)
                CupertinoListTile(
                  padding: EdgeInsets.all(0),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

```

content\_copy

This widget creates the familiar alphabetized sections that
you see in the iOS Contacts app.


Continue

7

### Use `SliverList` for the alphabetized sections

keyboard\_arrow\_up

Now, replace the placeholder content in `_ContactListView` with
the alphabetized sections:


lib/screens/contacts.dart

dart

```
// Inside _ContactListView's builder:
​
final AlphabetizedContactMap contacts = contactList.alphabetizedContacts;
​
return CustomScrollView(
  slivers: [
    CupertinoSliverNavigationBar.search(
      largeTitle: Text(contactList.title),
      automaticallyImplyLeading: automaticallyImplyLeading,
      searchField: const CupertinoSearchTextField(
        suffixIcon: Icon(CupertinoIcons.mic_fill),
        suffixMode: OverlayVisibilityMode.always,
      ),
    ),
    SliverList.list(
      children: [
        const SizedBox(height: 20),
        ...contacts.keys.map(
          (String initial) => ContactListSection(
            lastInitial: initial,
            contacts: contacts[initial]!,
          ),
        ),
      ],
    ),
  ],
);

```

content\_copy

`SliverList.list` allows you to provide a list of widgets that
become part of the scrollable content. This is the simplest way to
add a list of normal widgets to a scrollable sliver area.


In the next lesson, you'll learn about stack-based navigation and
update the UI on small screens to navigate between
the contacts list view and the contacts view.


Continue

8

### Review

keyboard\_arrow\_up

### What you accomplished

Here's a summary of what you built and learned in this lesson.

check\_circleview\_dayUnderstood slivers and how they differ from widgetskeyboard\_arrow\_up

Slivers are specialized widgets for scrollable layouts. They can only be direct children of scroll views like
`CustomScrollView`. In `CustomScrollView` and other sliver contexts, regular widgets must be wrapped in
`SliverToBoxAdapter` or `SliverFillRemaining`.


unfold\_moreBuilt scrollable layouts with CustomScrollViewkeyboard\_arrow\_up

`CustomScrollView` lets you compose multiple slivers together. You used `CupertinoSliverNavigationBar`,
`SliverFillRemaining`, and `SliverList` to create sophisticated scrollable interfaces.


searchCreated collapsible navigation bars with searchkeyboard\_arrow\_up

You used the `CupertinoSliverNavigationBar.search` constructor to create a collapsible navigation bar with integrated search functionality.


sort\_by\_alphaOrganized contacts in alphabetized sectionskeyboard\_arrow\_up

You created `ContactListSection` widgets grouped by last name initial, then used `SliverList.list`
to add them to the scrollable area. This mirrors the familiar iOS Contacts app experience.


Continue

9

### Test yourself

keyboard\_arrow\_up

### Slivers Quiz

1 / 2

**What is the key difference between slivers and regular widgets?**

1. Slivers are faster to render than regular widgets.







Not quite



Both are optimized; the difference is their purpose and context.

2. Slivers are specialized widgets designed for scrollable layouts and can only be direct children of scroll views.







That's right!



Slivers work within scroll views like CustomScrollView; regular widgets can be used anywhere.

3. Slivers can have an unlimited number of children.







Not quite



Some slivers like SliverList can have many children, but that's not what distinguishes them.

4. Slivers automatically handle user gestures.







Not quite



Gesture handling is separate; slivers are about scrollable layout composition.


**How do you use a regular widget inside a CustomScrollView's slivers list?**

1. Just add it directly; CustomScrollView accepts any widget.







Not quite



CustomScrollView only accepts slivers; regular widgets must be wrapped.

2. Wrap it in a SliverToBoxAdapter or SliverFillRemaining.







That's right!



These adapters convert regular widgets into slivers so they can be used in sliver contexts.

3. Convert the widget to a sliver by calling \`.toSliver()\` on it.







Not quite



There's no \`.toSliver()\` method; you use adapter widgets like SliverToBoxAdapter.

4. Pass it to the \`child\` property instead of \`slivers\`.







Not quite



CustomScrollView uses the slivers property; there's no child property for this purpose.


PreviousNext question

Finish

[chevron\_left\
PreviousAdaptive layouts](/learn/tutorial/adaptive-layout) [NextStack based navigation\
chevron\_right](/learn/tutorial/navigation)

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-13. [View source](https://github.com/flutter/website/blob/main/src/content/learn/tutorial/slivers.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/learn/tutorial/slivers&page-source=https://github.com/flutter/website/blob/main/src/content/learn/tutorial/slivers.md "Report an issue with this page").