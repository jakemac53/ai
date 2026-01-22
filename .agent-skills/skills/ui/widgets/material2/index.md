---
name: material-2-component-widgets
description: A catalog of Flutter's material 2 component widgets. Widgets implementing the Material 2 design guidelines.
metadata:
  url: https://docs.flutter.dev/ui/widgets/material2
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Material 2 component widgets

Flutter provides a variety of widgets
that implement the [Material 2](https://m2.material.io/design) design guidelines,
enabling you to create intuitive and beautiful apps.


merge\_typeVersion note

[Material 3](https://m3.material.io/), the latest version of Material Design, is
Flutter's default design language as of Flutter 3.16.


Material 2 will eventually be deprecated.
To learn more about this transition, check out
the [Migrate to Material 3](/release/breaking-changes/material-3-migration)
migration guide.


Also check out the [Material 3 widget catalog](/ui/widgets/material).

Widgets implementing the Material 2 design guidelines.

## App structure and navigation

[![Rendered image or visualization of the AppBar widget.](/assets/images/docs/widget-catalog/material-3-top-app-bar.png)\
\
AppBar\
\
Container that displays content and actions at the top of a screen.](https://api.flutter.dev/flutter/material/AppBar-class.html) [![Rendered image or visualization of the BottomNavigationBar widget.](/assets/images/docs/widget-catalog/material-bottom-navigation-bar.png)\
\
BottomNavigationBar\
\
Container that includes tools to explore and switch between top-level views in a single tap.](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) [![Rendered image or visualization of the Drawer widget.](/assets/images/docs/widget-catalog/material-drawer.png)\
\
Drawer\
\
A Material Design panel that slides in horizontally from the edge of a Scaffold to show navigation links in an application.](https://api.flutter.dev/flutter/material/Drawer-class.html) [![Rendered image or visualization of the MaterialApp widget.](https://storage.googleapis.com/material-design/publish/material_v_11/assets/0Bx4BSt6jniD7Y1huOXVQdlFPMmM/materialdesign_introduction.png)\
\
MaterialApp\
\
A convenience widget that wraps a number of widgets that are commonly required for applications implementing Material Design.](https://api.flutter.dev/flutter/material/MaterialApp-class.html) [![Rendered image or visualization of the Scaffold widget.](https://storage.googleapis.com/material-design/publish/material_v_11/assets/0Bx4BSt6jniD7T0hfM01sSmRyTG8/layout_structure_regions_mobile.png)\
\
Scaffold\
\
Implements the basic Material Design visual layout structure. This class provides APIs for showing drawers, snack bars, and bottom sheets.](https://api.flutter.dev/flutter/material/Scaffold-class.html) [![Rendered image or visualization of the SliverAppBar widget.](/assets/images/docs/widget-catalog/material-app-bar.png)\
\
SliverAppBar\
\
A material design app bar that integrates with a CustomScrollView.](https://api.flutter.dev/flutter/material/SliverAppBar-class.html) [![Rendered image or visualization of the TabBar widget.](/assets/images/docs/widget-catalog/material-3-tab-bar.png)\
\
TabBar\
\
Layered containers that organize content across different screens, data sets, and other interactions.](https://api.flutter.dev/flutter/material/TabBar-class.html) [![Rendered image or visualization of the TabBarView widget.](/assets/images/docs/widget-catalog/material-tab-bar.png)\
\
TabBarView\
\
A page view that displays the widget which corresponds to the currently selected tab. Typically used in conjunction with a TabBar.](https://api.flutter.dev/flutter/material/TabBarView-class.html) [![Rendered image or visualization of the TabController widget.](/assets/images/docs/widget-catalog/material-tab-bar.png)\
\
TabController\
\
Coordinates tab selection between a TabBar and a TabBarView.](https://api.flutter.dev/flutter/material/TabController-class.html) [![Rendered image or visualization of the TabPageSelector widget.](/assets/images/docs/widget-catalog/material-tab-bar.png)\
\
TabPageSelector\
\
Displays a row of small circular indicators, one per tab. The selected tab's indicator is highlighted. Often used in conjunction with a TabBarView.](https://api.flutter.dev/flutter/material/TabPageSelector-class.html) [![Rendered image or visualization of the WidgetsApp widget.](/assets/images/docs/widget-catalog/material-widgets-app.png)\
\
WidgetsApp\
\
A convenience class that wraps a number of widgets that are commonly required for an application.](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html)

## Buttons

[![Rendered image or visualization of the DropdownButton widget.](https://storage.googleapis.com/material-design/publish/material_v_11/assets/0B7WCemMG6e0VakJ6a0F2MFJaaDQ/components_menus.png)\
\
DropdownButton\
\
Shows the currently selected item and an arrow that opens a menu for selecting another item.](https://api.flutter.dev/flutter/material/DropdownButton-class.html) [![Rendered image or visualization of the ElevatedButton widget.](/assets/images/docs/widget-catalog/material-elevated-button.png)\
\
ElevatedButton\
\
A Material Design elevated button. A filled button whose material elevates when pressed.](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) [![Rendered image or visualization of the FloatingActionButton widget.](/assets/images/docs/widget-catalog/material-3-floating-action-button.png)\
\
FloatingActionButton\
\
Clickable block containing an icon that keeps a key action always in reach.](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html) [![Rendered image or visualization of the Extended FloatingActionButton widget.](/assets/images/docs/widget-catalog/material-3-extended-fab.png)\
\
Extended FloatingActionButton\
\
Clickable block that triggers an action. These wider blocks can fit a text label and provide a larger target area.](https://api.flutter.dev/flutter/material/FloatingActionButton/FloatingActionButton.extended.html) [![Rendered image or visualization of the IconButton widget.](/assets/images/docs/widget-catalog/material-3-icon-button.png)\
\
IconButton\
\
Clickable icons to prompt app users to take supplementary actions.](https://api.flutter.dev/flutter/material/IconButton-class.html) [![Rendered image or visualization of the OutlinedButton widget.](/assets/images/docs/widget-catalog/material-outlined-button.png)\
\
OutlinedButton\
\
A Material Design outlined button, essentially a TextButton with an outlined border.](https://api.flutter.dev/flutter/material/OutlinedButton-class.html) [![Rendered image or visualization of the PopupMenuButton widget.](/assets/images/docs/widget-catalog/material-popup-menu-button.png)\
\
PopupMenuButton\
\
Displays a menu when pressed and calls onSelected when the menu is dismissed because an item was selected.](https://api.flutter.dev/flutter/material/PopupMenuButton-class.html) [![Rendered image or visualization of the TextButton widget.](https://material-design.storage.googleapis.com/publish/material_v_9/0B7WCemMG6e0VNDg3V3ZjU2hsNGc/components_buttons_usage3.png)\
\
TextButton\
\
A Material Design text button. A simple flat button without a border outline.](https://api.flutter.dev/flutter/material/TextButton-class.html)

## Input and selections

[![Rendered image or visualization of the Checkbox widget.](/assets/images/docs/widget-catalog/material-3-checkbox.png)\
\
Checkbox\
\
Form control that app users can set or clear to select one or more options from a set.](https://api.flutter.dev/flutter/material/Checkbox-class.html) [![Rendered image or visualization of the DatePicker widget.](/assets/images/docs/widget-catalog/material-3-date-picker.png)\
\
DatePicker\
\
Calendar interface used to select a date or a range of dates.](https://api.flutter.dev/flutter/material/showDatePicker.html) [![Rendered image or visualization of the Radio widget.](/assets/images/docs/widget-catalog/material-3-radio-button.png)\
\
Radio\
\
Form control that app users can set or clear to select only one option from a set.](https://api.flutter.dev/flutter/material/Radio-class.html) [![Rendered image or visualization of the Slider widget.](/assets/images/docs/widget-catalog/material-3-slider.png)\
\
Slider\
\
Form control that enables selecting a range of values.](https://api.flutter.dev/flutter/material/Slider-class.html) [![Rendered image or visualization of the Switch widget.](/assets/images/docs/widget-catalog/material-3-switch.png)\
\
Switch\
\
Toggle control that changes the state of a single item to on or off.](https://api.flutter.dev/flutter/material/Switch-class.html) [![Rendered image or visualization of the TextField widget.](/assets/images/docs/widget-catalog/material-3-text-field.png)\
\
TextField\
\
Box into which app users can enter text. They appear in forms and dialogs.](https://api.flutter.dev/flutter/material/TextField-class.html)

## Dialogs, alerts, and panels

[![Rendered image or visualization of the AlertDialog widget.](/assets/images/docs/widget-catalog/material-3-dialog.png)\
\
AlertDialog\
\
Hovering containers that prompt app users to provide more data or make a decision.](https://api.flutter.dev/flutter/material/AlertDialog-class.html) [![Rendered image or visualization of the ExpansionPanel widget.](https://material-design.storage.googleapis.com/publish/material_v_9/0B7WCemMG6e0VOXF3eEJ3azZMSjg/components_expansion_panels.png)\
\
ExpansionPanel\
\
Expansion panels contain creation flows and allow lightweight editing of an element. The ExpansionPanel widget implements this component.](https://api.flutter.dev/flutter/material/ExpansionPanel-class.html) [![Rendered image or visualization of the SimpleDialog widget.](https://material-design.storage.googleapis.com/publish/material_v_9/0B7WCemMG6e0VVGNnN3NvMGdoQTg/components_dialogs.png)\
\
SimpleDialog\
\
Simple dialogs can provide additional details or actions about a list item. For example they can display avatars icons clarifying subtext or orthogonal actions (such...](https://api.flutter.dev/flutter/material/SimpleDialog-class.html) [![Rendered image or visualization of the SnackBar widget.](/assets/images/docs/widget-catalog/material-3-snackbar.png)\
\
SnackBar\
\
Brief messages about app processes that display at the bottom of the screen.](https://api.flutter.dev/flutter/material/SnackBar-class.html)

## Information displays

[![Rendered image or visualization of the Card widget.](/assets/images/docs/widget-catalog/material-3-card.png)\
\
Card\
\
Container for short, related pieces of content displayed in a box with rounded corners and a drop shadow.](https://api.flutter.dev/flutter/material/Card-class.html) [![Rendered image or visualization of the Chip widget.](/assets/images/docs/widget-catalog/material-3-chip.png)\
\
Chip\
\
Small blocks that simplify entering information, making selections, filtering content, or triggering actions.](https://api.flutter.dev/flutter/material/Chip-class.html) [![Rendered image or visualization of the CircularProgressIndicator widget.](/assets/images/docs/widget-catalog/material-circular-progress-indicator.png)\
\
CircularProgressIndicator\
\
Circular progress indicator that spins to indicate a busy application.](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html) [![Rendered image or visualization of the DataTable widget.](/assets/images/docs/widget-catalog/material-data-table.png)\
\
DataTable\
\
Data tables display sets of raw data. They usually appear in desktop enterprise products. The DataTable widget implements this component.](https://api.flutter.dev/flutter/material/DataTable-class.html) [![Rendered image or visualization of the GridView widget.](/assets/images/docs/widget-catalog/material-grid-view.png)\
\
GridView\
\
A grid list consists of a repeated pattern of cells arrayed in a vertical and horizontal layout. The GridView widget implements this component.](https://api.flutter.dev/flutter/widgets/GridView-class.html) [![Rendered image or visualization of the Icon widget.](https://flutter.github.io/assets-for-api-docs/assets/widgets/icon.png)\
\
Icon\
\
A Material Design icon.](https://api.flutter.dev/flutter/widgets/Icon-class.html) [Image\
\
A widget that displays an image.](https://api.flutter.dev/flutter/widgets/Image-class.html) [![Rendered image or visualization of the LinearProgressIndicator widget.](/assets/images/docs/widget-catalog/material-3-progress-indicator.png)\
\
LinearProgressIndicator\
\
Vertical line that changes color as an ongoing process, such as loading an app or submitting a form, completes.](https://api.flutter.dev/flutter/material/LinearProgressIndicator-class.html) [![Rendered image or visualization of the Tooltip widget.](/assets/images/docs/widget-catalog/material-tooltip.png)\
\
Tooltip\
\
Tooltips provide text labels that help explain the function of a button or other user interface action. Wrap the button in a Tooltip widget to...](https://api.flutter.dev/flutter/material/Tooltip-class.html)

## Layout

[![Rendered image or visualization of the Divider widget.](/assets/images/docs/widget-catalog/material-3-divider.png)\
\
Divider\
\
Thin line that groups content in lists and containers.](https://api.flutter.dev/flutter/material/Divider-class.html) [![Rendered image or visualization of the ListTile widget.](/assets/images/docs/widget-catalog/material-3-list.png)\
\
ListTile\
\
A single fixed-height row that typically contains some text as well as a leading or trailing icon.](https://api.flutter.dev/flutter/material/ListTile-class.html) [![Rendered image or visualization of the Stepper widget.](https://material-design.storage.googleapis.com/publish/material_v_9/0B7WCemMG6e0VTndyUnNCR2tQREE/components_steppers.png)\
\
Stepper\
\
A Material Design stepper widget that displays progress through a sequence of steps.](https://api.flutter.dev/flutter/material/Stepper-class.html)

Find more widgets in the [widget catalog](/ui/widgets).

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. [Report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/widgets/material2 "Report an issue with this page").