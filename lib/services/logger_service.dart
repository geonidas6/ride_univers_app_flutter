import '../core/config/log_config.dart';
import '../core/enums/log_level.dart';

typedef LogCallback = void Function(String message,
    {LogLevel level, Object? error, StackTrace? stackTrace});

class LoggerService {
  static final List<LogCallback> _callbacks = [];

  static void addCallback(LogCallback callback) {
    _callbacks.add(callback);
  }

  static void removeCallback(LogCallback callback) {
    _callbacks.remove(callback);
  }

  static void _notifyCallbacks(String message,
      {LogLevel level = LogLevel.info, Object? error, StackTrace? stackTrace}) {
    for (var callback in _callbacks) {
      callback(message, level: level, error: error, stackTrace: stackTrace);
    }
  }

  static void debug(String message) {
    _notifyCallbacks(message, level: LogLevel.debug);
  }

  static void info(String message) {
    _notifyCallbacks(message, level: LogLevel.info);
  }

  static void warning(String message) {
    _notifyCallbacks(message, level: LogLevel.warning);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _notifyCallbacks(message,
        level: LogLevel.error, error: error, stackTrace: stackTrace);
  }

  static void verbose(String message) {
    LogConfig.logger.v(message);
  }
}
