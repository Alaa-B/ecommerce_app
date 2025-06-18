import 'dart:developer';

import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'error_logger.g.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    //* add crash reporting tool to optimize Error handling...
    log('$error, $stackTrace');
  }

  void logAppException(AppException exception) {
    log("$exception");
  }
}

@riverpod
ErrorLogger errorLogger(Ref ref) {
  return ErrorLogger();
}
