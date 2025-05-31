import 'package:flutter_riverpod/flutter_riverpod.dart';

//* this provider help us to mock the time and test our app...
final currentDateProvider = Provider<DateTime Function()>((ref) {
  return () => DateTime.now();
});
