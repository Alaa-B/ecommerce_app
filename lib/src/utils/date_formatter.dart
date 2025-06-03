import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Date formatter to be used in the app.
final dateFormatterProvider = Provider<DateFormat>((ref) {
  return DateFormat.MMMEd();
});
