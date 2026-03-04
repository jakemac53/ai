import 'dart:async';
import 'package:nocterm/nocterm.dart';

class Spinner extends StatefulComponent {
  final Color? color;
  const Spinner({super.key, this.color});

  static const frames = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'];
  static String getFrame([int? ms]) =>
      frames[((ms ?? DateTime.now().millisecondsSinceEpoch) ~/ 100) %
          frames.length];

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    final frame = Spinner.getFrame();
    return Text(
      frame,
      style: TextStyle(color: component.color ?? theme.primary),
    );
  }
}
