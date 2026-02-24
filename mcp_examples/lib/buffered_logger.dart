import 'dart:async';
import 'package:cli_util/cli_logging.dart' as cli;
import 'package:nocterm/nocterm.dart' hide Logger;

class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {
  T _value;
  ValueNotifier(this._value);

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}

class BufferedLogger implements cli.Logger {
  final List<String> logs = [];
  final ValueNotifier<int> unreadCount = ValueNotifier(0);
  final StreamController<void> _updateController = StreamController.broadcast();
  Stream<void> get onUpdate => _updateController.stream;

  void markLogsRead() {
    unreadCount.value = 0;
  }

  void _addLog(String message) {
    logs.add(message);
    unreadCount.value++;
    _updateController.add(null);
  }

  @override
  cli.Ansi get ansi => cli.Ansi(false);

  @override
  void flush() {}

  @override
  bool get isVerbose => false;

  @override
  cli.Progress progress(String message) {
    _addLog('PROGRESS: $message');
    return _BufferedProgress(this, message);
  }

  @override
  void stderr(String message) {
    _addLog('ERROR: $message');
  }

  @override
  void stdout(String message) {
    _addLog(message);
  }

  @override
  void trace(String message) {
    _addLog('TRACE: $message');
  }

  @override
  void write(String message) {
    _addLog(message);
  }

  @override
  void writeCharCode(int charCode) {
    _addLog(String.fromCharCode(charCode));
  }
}

class _BufferedProgress implements cli.Progress {
  final BufferedLogger logger;
  final String initialMessage;
  final Stopwatch _stopwatch = Stopwatch()..start();

  _BufferedProgress(this.logger, this.initialMessage);

  @override
  Duration get elapsed => _stopwatch.elapsed;

  @override
  String get message => initialMessage;

  @override
  void cancel() {
    _stopwatch.stop();
    logger._addLog('CANCELLED: $initialMessage');
  }

  @override
  void finish({String? message, bool showTiming = false}) {
    _stopwatch.stop();
    logger._addLog(
      'FINISHED: $initialMessage ${message != null ? '- $message' : ''}',
    );
  }
}
