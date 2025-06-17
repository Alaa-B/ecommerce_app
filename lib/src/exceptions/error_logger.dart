import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'error_logger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    //* add crash reporting tool to optimize Error handling...
    debugPrint("$error, $stackTrace");
  }

  void logAppException(AppException exception) {
    debugPrint("$exception");
  }
}

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
}
