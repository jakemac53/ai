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
  String message;
  final LogLevel level;
  final DateTime timestamp;
  bool isFinished = false;
  bool isCancelled = false;
  String? finishMessage;

  LogEntry(this.message, this.level) : timestamp = DateTime.now();

  String get displayMessage {
    if (isFinished) {
      return '$message ${finishMessage != null ? '- $finishMessage' : '(finished)'}';
    }
    if (isCancelled) {
      return '$message (cancelled)';
    }
    return message;
  }
}

class BufferedLogger implements cli.Logger {
  final String name;
  final List<LogEntry> logEntries = [];
  final List<String> logs = []; // Maintain for compatibility if needed
  final ValueNotifier<int> unreadCount = ValueNotifier(0);
  final StreamController<void> _updateController = StreamController.broadcast();
  Stream<void> get onUpdate => _updateController.stream;

  BufferedLogger({this.name = 'Chat'});

  void markLogsRead() {
    unreadCount.value = 0;
  }

  void notifyUpdate() {
    _updateController.add(null);
  }

  LogEntry _addLog(String message, LogLevel level) {
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
    return entry;
  }

  @override
  cli.Ansi get ansi => cli.Ansi(false);

  @override
  void flush() {}

  @override
  bool get isVerbose => false;

  @override
  cli.Progress progress(String message) {
    final entry = _addLog(message, LogLevel.progress);
    return _BufferedProgress(this, entry, message);
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
  final LogEntry entry;
  final String initialMessage;
  final Stopwatch _stopwatch = Stopwatch()..start();

  _BufferedProgress(this.logger, this.entry, this.initialMessage);

  @override
  Duration get elapsed => _stopwatch.elapsed;

  @override
  String get message => initialMessage;

  @override
  void cancel() {
    _stopwatch.stop();
    entry.isCancelled = true;
    logger.notifyUpdate();
  }

  @override
  void finish({String? message, bool showTiming = false}) {
    _stopwatch.stop();
    entry.isFinished = true;
    entry.finishMessage = message;
    if (showTiming) {
      final timing = '(${elapsed.inMilliseconds}ms)';
      entry.finishMessage =
          entry.finishMessage != null
              ? '${entry.finishMessage} $timing'
              : timing;
    }
    logger.notifyUpdate();
  }
}
