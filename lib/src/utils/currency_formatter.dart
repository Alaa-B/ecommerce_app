import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_formatter.g.dart';

@riverpod
NumberFormat currencyFormatter(Ref ref) {
  return NumberFormat.simpleCurrency(locale: "en_US");
}
/// Currency formatter to be used in the app.
// final currencyFormatterProvider = Provider<NumberFormat>((ref) {
// });


