import 'package:logger/logger.dart';

enum DebugLevel {
  none, // Aucun log
  info, // Logs basiques
  debug, // Logs détaillés
  verbose // Logs très détaillés avec stack traces
}

class LogConfig {
  static DebugLevel _level = DebugLevel.info;

  static DebugLevel get level => _level;

  static void setLogLevel(DebugLevel level) {
    _level = level;
  }

  static bool get showStackTrace => _level == DebugLevel.verbose;

  static bool get showDebugLogs => _level.index >= DebugLevel.debug.index;

  static bool get showInfoLogs => _level.index >= DebugLevel.info.index;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static Future<void> initialize() async {
    // Initialisation des configurations de log si nécessaire
  }

  static Logger get logger => _logger;
}
