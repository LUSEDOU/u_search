import 'dart:developer';

import 'package:logger/logger.dart';

class LoggerManager {
  factory LoggerManager() {
    return _instance;
  }

  LoggerManager._internal() {
    _logger = Logger(
      level: Level.debug,
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 10,
        lineLength: 60,
        printEmojis: false,
      ),
    );
  }

  static final _instance = LoggerManager._internal();

  late Logger _logger;

  Logger get logger => _logger;

  void i(dynamic message) {
    log(message.toString());
    _instance.logger.i(message);
  }

  void d(dynamic message) {
    log(message.toString());
    _instance.logger.d(message);
  }

  void e(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(message.toString(), error: error, stackTrace: stackTrace);
    _instance.logger.e(message, error: error, stackTrace: stackTrace);
  }
}
