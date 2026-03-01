import 'dart:async';
import 'package:nocterm/nocterm.dart';
import 'package:mcp_examples/workflow_client.dart';
import 'package:mcp_examples/ui/spinner.dart';

class SplashScreen extends StatefulComponent {
  final WorkflowClient client;
  const SplashScreen({super.key, required this.client});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _x = 2;
  double _y = 2;
  double _dx = 1;
  double _dy = 0.5;
  int _colorIndex = 0;
  static const _colors = [
    Color(0xFF50FA7B), // Green
    Color(0xFF8BE9FD), // Cyan
    Color(0xFFFF79C6), // Pink
    Color(0xFFBD93F9), // Purple
    Color(0xFFFFB86C), // Orange
    Color(0xFFF1FA8C), // Yellow
  ];

  Timer? _timer;
  Size _parentSize = Size.zero;
  Size _childSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _tick();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    if (_parentSize == Size.zero || _childSize == Size.zero) return;

    setState(() {
      _x += _dx;
      _y += _dy;

      final childWidth = _childSize.width;
      final childHeight = _childSize.height;

      bool hit = false;
      if (_x <= 0) {
        _x = 0;
        _dx = -_dx;
        hit = true;
      } else if (_x + childWidth >= _parentSize.width) {
        _x = _parentSize.width - childWidth;
        _dx = -_dx;
        hit = true;
      }

      if (_y <= 0) {
        _y = 0;
        _dy = -_dy;
        hit = true;
      } else if (_y + childHeight >= _parentSize.height) {
        _y = _parentSize.height - childHeight;
        _dy = -_dy;
        hit = true;
      }

      if (hit) {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    final currentColor = _colors[_colorIndex];
    return _BouncingLogo(
      x: _x,
      y: _y,
      onLayout: (parentSize, childSize) {
        _parentSize = parentSize;
        _childSize = childSize;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AsciiText(
            'Dash Client',
            font: AsciiFont.standard,
            style: TextStyle(color: currentColor),
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Initializing servers & skills... ',
                style: TextStyle(color: theme.onSurface.withOpacity(0.7)),
              ),
              const Spinner(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BouncingLogo extends SingleChildRenderObjectComponent {
  final double x;
  final double y;
  final void Function(Size parentSize, Size childSize) onLayout;

  const _BouncingLogo({
    required this.x,
    required this.y,
    required this.onLayout,
    required super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderBouncingLogo(x: x, y: y, onLayout: onLayout);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderBouncingLogo renderObject,
  ) {
    renderObject
      ..x = x
      ..y = y
      ..onLayout = onLayout;
  }
}

class RenderBouncingLogo extends RenderObject
    with RenderObjectWithChildMixin<RenderObject> {
  double x;
  double y;
  void Function(Size parentSize, Size childSize) onLayout;

  RenderBouncingLogo({
    required this.x,
    required this.y,
    required this.onLayout,
  });

  @override
  void performLayout() {
    size = constraints.constrain(Size.infinite);
    if (child != null) {
      child!.layout(constraints.loosen(), parentUsesSize: true);
      onLayout(size, child!.size);
    }
  }

  @override
  void paint(canvas, offset) {
    super.paint(canvas, offset);
    if (child != null) {
      child!.paint(canvas, offset + Offset(x, y));
    }
  }
}
