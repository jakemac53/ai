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

enum LogLevel { stdout, stderr, progress, trace }

class LogEntry {
  final String message;
  final LogLevel level;
  final DateTime timestamp;

  LogEntry(this.message, this.level) : timestamp = DateTime.now();
}

class BufferedLogger implements cli.Logger {
  final List<LogEntry> logEntries = [];
  final List<String> logs = []; // Maintain for compatibility if needed
  final ValueNotifier<int> unreadCount = ValueNotifier(0);
  final StreamController<void> _updateController = StreamController.broadcast();
  Stream<void> get onUpdate => _updateController.stream;

  void markLogsRead() {
    unreadCount.value = 0;
  }

  void _addLog(String message, LogLevel level) {
    final entry = LogEntry(message, level);
    logEntries.add(entry);
    
    // Maintain the old string-based list for compatibility
    String prefix = '';
    switch (level) {
      case LogLevel.stderr:
        prefix = 'ERROR: ';
      case LogLevel.progress:
        prefix = 'PROGRESS: ';
      case LogLevel.trace:
        prefix = 'TRACE: ';
      case LogLevel.stdout:
        prefix = '';
    }
    logs.add('$prefix$message');
    
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
    _addLog(message, LogLevel.progress);
    return _BufferedProgress(this, message);
  }

  @override
  void stderr(String message) {
    _addLog(message, LogLevel.stderr);
  }

  @override
  void stdout(String message) {
    _addLog(message, LogLevel.stdout);
  }

  @override
  void trace(String message) {
    _addLog(message, LogLevel.trace);
  }

  @override
  void write(String message) {
    _addLog(message, LogLevel.stdout);
  }

  @override
  void writeCharCode(int charCode) {
    _addLog(String.fromCharCode(charCode), LogLevel.stdout);
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
    logger._addLog(initialMessage, LogLevel.progress); // Mark cancellation
  }

  @override
  void finish({String? message, bool showTiming = false}) {
    _stopwatch.stop();
    logger._addLog(
      '$initialMessage ${message != null ? '- $message' : ''}',
      LogLevel.progress,
    );
  }
}
