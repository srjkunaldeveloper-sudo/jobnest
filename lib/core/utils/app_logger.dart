import 'package:logger/logger.dart';

/// Global application logger utilizing the `logger` package.
///
/// SOLID: Single Responsibility Principle - Responsible exclusively for formatting
/// and outputting application logs.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  /// Log an informational message.
  static void i(dynamic message) {
    _logger.i(message);
  }

  /// Log a debug message.
  static void d(dynamic message) {
    _logger.d(message);
  }

  /// Log a warning message.
  static void w(dynamic message) {
    _logger.w(message);
  }

  /// Log an error message with optional exception and stack trace.
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
