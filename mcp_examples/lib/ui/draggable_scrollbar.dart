import 'dart:math' as math;
import 'package:nocterm/nocterm.dart';
import 'package:nocterm/src/framework/terminal_canvas.dart';
import 'package:nocterm/src/rendering/mouse_tracker.dart';
import 'package:nocterm/src/rendering/mouse_hit_test.dart';

class DraggableScrollbar extends StatefulComponent {
  const DraggableScrollbar({
    super.key,
    required this.child,
    required this.controller,
    this.thumbVisibility = true,
    this.thickness = 1.0,
    this.margin = 1.0,
    this.trackColor,
    this.thumbColor,
  });

  final Component child;
  final ScrollController controller;
  final bool thumbVisibility;
  final double thickness;
  final double margin;
  final Color? trackColor;
  final Color? thumbColor;

  @override
  State<DraggableScrollbar> createState() => _DraggableScrollbarState();
}

class _DraggableScrollbarState extends State<DraggableScrollbar> {
  @override
  Component build(BuildContext context) {
    return _DraggableScrollbarRenderObjectWidget(
      controller: component.controller,
      thumbVisibility: component.thumbVisibility,
      thickness: component.thickness,
      margin: component.margin,
      trackColor: component.trackColor,
      thumbColor: component.thumbColor,
      child: component.child,
    );
  }
}

class _DraggableScrollbarRenderObjectWidget
    extends SingleChildRenderObjectComponent {
  const _DraggableScrollbarRenderObjectWidget({
    required this.controller,
    required this.thumbVisibility,
    required this.thickness,
    required this.margin,
    this.trackColor,
    this.thumbColor,
    required super.child,
  });

  final ScrollController controller;
  final bool thumbVisibility;
  final double thickness;
  final double margin;
  final Color? trackColor;
  final Color? thumbColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final theme = TuiTheme.of(context);
    return RenderDraggableScrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      thickness: thickness,
      margin: margin,
      trackColor: trackColor ?? theme.surface,
      thumbColor: thumbColor ?? theme.onSurface,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderDraggableScrollbar renderObject,
  ) {
    final theme = TuiTheme.of(context);
    renderObject
      ..controller = controller
      ..thumbVisibility = thumbVisibility
      ..thickness = thickness
      ..margin = margin
      ..trackColor = trackColor ?? theme.surface
      ..thumbColor = thumbColor ?? theme.onSurface;
  }
}

class RenderDraggableScrollbar extends RenderObject
    with
        RenderObjectWithChildMixin<RenderObject>,
        MouseTrackerAnnotationProvider {
  RenderDraggableScrollbar({
    required ScrollController controller,
    required bool thumbVisibility,
    required double thickness,
    required double margin,
    required Color trackColor,
    required Color thumbColor,
  }) : _controller = controller,
       _thumbVisibility = thumbVisibility,
       _thickness = thickness,
       _margin = margin,
       _trackColor = trackColor,
       _thumbColor = thumbColor {
    _controller.addListener(_handleScrollUpdate);
    _updateAnnotation();
  }

  ScrollController _controller;
  ScrollController get controller => _controller;
  set controller(ScrollController value) {
    if (_controller != value) {
      _controller.removeListener(_handleScrollUpdate);
      _controller = value;
      _controller.addListener(_handleScrollUpdate);
      markNeedsPaint();
    }
  }

  bool _thumbVisibility;
  bool get thumbVisibility => _thumbVisibility;
  set thumbVisibility(bool value) {
    if (_thumbVisibility != value) {
      _thumbVisibility = value;
      markNeedsPaint();
    }
  }

  double _thickness;
  double get thickness => _thickness;
  set thickness(double value) {
    if (_thickness != value) {
      _thickness = value;
      markNeedsLayout();
    }
  }

  double _margin;
  double get margin => _margin;
  set margin(double value) {
    if (_margin != value) {
      _margin = value;
      markNeedsLayout();
    }
  }

  Color _trackColor;
  Color get trackColor => _trackColor;
  set trackColor(Color value) {
    if (_trackColor != value) {
      _trackColor = value;
      markNeedsPaint();
    }
  }

  Color _thumbColor;
  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor != value) {
      _thumbColor = value;
      markNeedsPaint();
    }
  }

  bool _isDragging = false;

  void _handleScrollUpdate() {
    markNeedsPaint();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScrollUpdate);
    super.dispose();
  }

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.constrain(Size.zero);
      return;
    }

    final totalReservedWidth = thickness + margin;
    final childConstraints = BoxConstraints(
      minWidth: math.max(0, constraints.minWidth - totalReservedWidth),
      maxWidth: math.max(0, constraints.maxWidth - totalReservedWidth),
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    );

    child!.layout(childConstraints, parentUsesSize: true);

    size = constraints.constrain(
      Size(child!.size.width + totalReservedWidth, child!.size.height),
    );
  }

  @override
  void paint(TerminalCanvas canvas, Offset offset) {
    super.paint(canvas, offset);
    if (child == null) return;

    child!.paint(canvas, offset);

    if (thumbVisibility) {
      _paintScrollbar(canvas, offset);
    }
  }

  void _paintScrollbar(TerminalCanvas canvas, Offset offset) {
    final scrollbarX = size.width - thickness;
    final scrollbarHeight = size.height;

    // Draw background track
    for (int y = 0; y < scrollbarHeight.toInt(); y++) {
      canvas.drawText(
        offset + Offset(scrollbarX, y.toDouble()),
        ' ',
        style: TextStyle(backgroundColor: _trackColor),
      );
    }

    if (_controller.maxScrollExtent <= 0) return;

    final scrollFraction =
        _controller.viewportDimension /
        (_controller.maxScrollExtent + _controller.viewportDimension);
    final thumbHeight = math.max(1.0, scrollbarHeight * scrollFraction);

    final scrollOffset = _controller.offset / _controller.maxScrollExtent;
    final thumbOffset = scrollOffset * (scrollbarHeight - thumbHeight);

    final thumbStart = thumbOffset.toInt();
    final thumbEnd = math.min(
      (thumbOffset + thumbHeight).toInt(),
      scrollbarHeight.toInt(),
    );

    for (int y = thumbStart; y < thumbEnd; y++) {
      canvas.drawText(
        offset + Offset(scrollbarX, y.toDouble()),
        ' ',
        style: TextStyle(backgroundColor: _thumbColor),
      );
    }
  }

  @override
  bool hitTest(HitTestResult result, {required Offset position}) {
    if (!Rect.fromLTWH(0, 0, size.width, size.height).contains(position)) {
      return false;
    }

    // We hit if the position is on the scrollbar
    bool hitSelf = position.dx >= size.width - thickness;

    if (hitSelf) {
      if (result is MouseHitTestResult) {
        result.addWithPosition(target: this, localPosition: position);
      }
      return true;
    }

    // Otherwise, try children
    if (child != null) {
      return child!.hitTest(result, position: position);
    }

    return false;
  }

  MouseTrackerAnnotation? _annotation;
  @override
  MouseTrackerAnnotation? get annotation => _annotation;

  void _updateAnnotation() {
    _annotation = MouseTrackerAnnotation(
      onEnter: (event) {
        final isLeftDown = event.pressed || event.isPrimaryButtonDown;
        if (isLeftDown) {
          _isDragging = true;
        }
      },
      onExit: (event) {
        _isDragging = false;
      },
      onHover: (event) {
        final isLeftDown = event.pressed || event.isPrimaryButtonDown;

        if (isLeftDown) {
          _isDragging = true;
        } else {
          _isDragging = false;
        }

        if (_isDragging) {
          _updateScrollPosition(event.y.toDouble());
        }
      },
      renderObject: this,
    );
  }

  void _updateScrollPosition(double y) {
    final scrollbarHeight = size.height;
    if (scrollbarHeight <= 0) return;

    // Ideally we would use local position, but assuming global y maps
    // reasonably for this simplified TUI scrollbar.
    final localY = y;

    final scrollFraction =
        _controller.viewportDimension /
        (_controller.maxScrollExtent + _controller.viewportDimension);
    final thumbHeight = math.max(1.0, scrollbarHeight * scrollFraction);

    final targetThumbTop = localY - (thumbHeight / 2);
    final maxThumbTop = scrollbarHeight - thumbHeight;

    final clampedThumbTop = targetThumbTop.clamp(0.0, maxThumbTop);

    double newScrollOffset;
    if (maxThumbTop > 0) {
      newScrollOffset =
          (clampedThumbTop / maxThumbTop) * _controller.maxScrollExtent;
    } else {
      newScrollOffset = 0;
    }

    _controller.jumpTo(newScrollOffset);
  }
}
