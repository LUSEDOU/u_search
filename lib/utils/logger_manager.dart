import 'package:logger/logger.dart';

class LoggerManager {
  static final LoggerManager _instance = LoggerManager._internal();

  factory LoggerManager() {
    return _instance;
  }

  late Logger _logger;

  Logger get logger => _logger;

  LoggerManager._internal() {
    // Initialize the logger with your desired configuration
    _logger = Logger(
      level: Level.debug, // Set the log level
      printer: PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 10, // number of method calls if stacktrace is provided
        lineLength: 60, // width of the output
        colors: true, // Colorful log messages
        printEmojis: false, // Print an emoji for each log message
        printTime: false, // Should each log print contain a timestamp
      ), // Use a different log printer
    );
  }
}
