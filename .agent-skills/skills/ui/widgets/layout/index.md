---
name: layout-widgets
description: A catalog of Flutter's layout widgets. Arrange other widgets columns, rows, grids, and many other layouts.
metadata:
  url: https://docs.flutter.dev/ui/widgets/layout
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# Layout widgets

Arrange other widgets columns, rows, grids, and many other layouts.

## Single-child layout widgets

[Align\
\
A widget that aligns its child within itself and optionally sizes itself based on the child's size.](https://api.flutter.dev/flutter/widgets/Align-class.html) [AspectRatio\
\
A widget that attempts to size the child to a specific aspect ratio.](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html) [Abc \
\
Baseline\
\
Container that positions its child according to the child's baseline.](https://api.flutter.dev/flutter/widgets/Baseline-class.html) [Center\
\
Alignment block that centers its child within itself.](https://api.flutter.dev/flutter/widgets/Center-class.html) [ConstrainedBox\
\
A widget that imposes additional constraints on its child.](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) [Container\
\
A convenience widget that combines common painting, positioning, and sizing widgets.](https://api.flutter.dev/flutter/widgets/Container-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
CustomSingleChildLayout\
\
A widget that defers the layout of its single child to a delegate.](https://api.flutter.dev/flutter/widgets/CustomSingleChildLayout-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
Expanded\
\
A widget that expands a child of a Row, Column, or Flex.](https://api.flutter.dev/flutter/widgets/Expanded-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
FittedBox\
\
Scales and positions its child within itself according to fit.](https://api.flutter.dev/flutter/widgets/FittedBox-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
FractionallySizedBox\
\
A widget that sizes its child to a fraction of the total available space. For more details about the layout algorithm, see RenderFractionallySizedOverflowBox.](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
IntrinsicHeight\
\
A widget that sizes its child to the child's intrinsic height.](https://api.flutter.dev/flutter/widgets/IntrinsicHeight-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
IntrinsicWidth\
\
A widget that sizes its child to the child's intrinsic width.](https://api.flutter.dev/flutter/widgets/IntrinsicWidth-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
LimitedBox\
\
A box that limits its size only when it's unconstrained.](https://api.flutter.dev/flutter/widgets/LimitedBox-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
Offstage\
\
A widget that lays the child out as if it was in the tree, but without painting anything, without making the child available for hit...](https://api.flutter.dev/flutter/widgets/Offstage-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
OverflowBox\
\
A widget that imposes different constraints on its child than it gets from its parent, possibly allowing the child to overflow the parent.](https://api.flutter.dev/flutter/widgets/OverflowBox-class.html) [Padding\
\
A widget that insets its child by the given padding.](https://api.flutter.dev/flutter/widgets/Padding-class.html) [SizedBox\
\
A box with a specified size. If given a child, this widget forces its child to have a specific width and/or height (assuming values are...](https://api.flutter.dev/flutter/widgets/SizedBox-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SizedOverflowBox\
\
A widget that is a specific size but passes its original constraints through to its child, which will probably overflow.](https://api.flutter.dev/flutter/widgets/SizedOverflowBox-class.html) [Transform\
\
A widget that applies a transformation before painting its child.](https://api.flutter.dev/flutter/widgets/Transform-class.html)

## Multi-child layout widgets

[Column\
\
Layout a list of child widgets in the vertical direction.](https://api.flutter.dev/flutter/widgets/Column-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
CustomMultiChildLayout\
\
A widget that uses a delegate to size and position multiple children.](https://api.flutter.dev/flutter/widgets/CustomMultiChildLayout-class.html) [![Rendered image or visualization of the CarouselView widget.](/assets/images/docs/widget-catalog/material-carousel.png)\
\
CarouselView\
\
A Material carousel widget that presents a scrollable list of items, each of which can dynamically change size based on the chosen layout.](https://main-api.flutter.dev/flutter/material/CarouselView-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
Flow\
\
A widget that implements the flow layout algorithm.](https://api.flutter.dev/flutter/widgets/Flow-class.html) [![Rendered image or visualization of the GridView widget.](/assets/images/docs/widget-catalog/material-grid-view.png)\
\
GridView\
\
A grid list consists of a repeated pattern of cells arrayed in a vertical and horizontal layout. The GridView widget implements this component.](https://api.flutter.dev/flutter/widgets/GridView-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
IndexedStack\
\
A Stack that shows a single child from a list of children.](https://api.flutter.dev/flutter/widgets/IndexedStack-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
LayoutBuilder\
\
Builds a widget tree that can depend on the parent widget's size.](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
ListBody\
\
A widget that arranges its children sequentially along a given axis, forcing them to the dimension of the parent in the other axis.](https://api.flutter.dev/flutter/widgets/ListBody-class.html) [![Rendered image or visualization of the ListView widget.](/assets/images/docs/widget-catalog/material-list-tile.png)\
\
ListView\
\
A scrollable, linear list of widgets. ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction....](https://api.flutter.dev/flutter/widgets/ListView-class.html) [Row\
\
Layout a list of child widgets in the horizontal direction.](https://api.flutter.dev/flutter/widgets/Row-class.html) [Stack\
\
This class is useful if you want to overlap several children in a simple way, for example having some text and an image, overlaid with...](https://api.flutter.dev/flutter/widgets/Stack-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
Table\
\
Displays child widgets in rows and columns.](https://api.flutter.dev/flutter/widgets/Table-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
Wrap\
\
A widget that displays its children in multiple horizontal or vertical runs.](https://api.flutter.dev/flutter/widgets/Wrap-class.html)

## Sliver widgets

[![Rendered image or visualization of the CupertinoSliverNavigationBar widget.](/assets/images/docs/widget-catalog/cupertino-sliver-navigation-bar.png)\
\
CupertinoSliverNavigationBar\
\
A navigation bar with iOS-11-style large titles using slivers.](https://api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
CupertinoSliverRefreshControl\
\
A sliver widget implementing the iOS-style pull to refresh content control.](https://api.flutter.dev/flutter/cupertino/CupertinoSliverRefreshControl-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
CustomScrollView\
\
A ScrollView that creates custom scroll effects using slivers.](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html) [![Rendered image or visualization of the SliverAppBar widget.](/assets/images/docs/widget-catalog/material-app-bar.png)\
\
SliverAppBar\
\
A material design app bar that integrates with a CustomScrollView.](https://api.flutter.dev/flutter/material/SliverAppBar-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverChildBuilderDelegate\
\
A delegate that supplies children for slivers using a builder callback.](https://api.flutter.dev/flutter/widgets/SliverChildBuilderDelegate-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverChildListDelegate\
\
A delegate that supplies children for slivers using an explicit list.](https://api.flutter.dev/flutter/widgets/SliverChildListDelegate-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverFillRemaining\
\
A sliver that contains a single box child that fills the remaining space in the viewport.](https://api.flutter.dev/flutter/widgets/SliverFillRemaining-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverFixedExtentList\
\
A sliver that places multiple box children with the same main axis extent in a linear array.](https://api.flutter.dev/flutter/widgets/SliverFixedExtentList-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverGrid\
\
A sliver that places multiple box children in a two dimensional arrangement.](https://api.flutter.dev/flutter/widgets/SliverGrid-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverList\
\
A sliver that places multiple box children in a linear array along the main axis.](https://api.flutter.dev/flutter/widgets/SliverList-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverPadding\
\
A sliver that applies padding on each side of another sliver.](https://api.flutter.dev/flutter/widgets/SliverPadding-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverPersistentHeader\
\
A sliver whose size varies when the sliver is scrolled to the edge of the viewport opposite the sliver's GrowthDirection.](https://api.flutter.dev/flutter/widgets/SliverPersistentHeader-class.html) [![Placeholder Flutter logo in place of missing widget image or visualization.](/assets/images/docs/catalog-widget-placeholder.png)\
\
SliverToBoxAdapter\
\
A sliver that contains a single box widget.](https://api.flutter.dev/flutter/widgets/SliverToBoxAdapter-class.html)

Find more widgets in the [widget catalog](/ui/widgets).

Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. [Report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ui/widgets/layout "Report an issue with this page").