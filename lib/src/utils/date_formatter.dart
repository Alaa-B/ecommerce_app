import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_formatter.g.dart';

@riverpod
DateFormat dateFormatter(Ref ref) {
  return DateFormat.MMMEd();
}

/// Date formatter to be used in the app.
// final dateFormatterProvider = Provider<DateFormat>((ref) {
//   return DateFormat.MMMEd();
// });
