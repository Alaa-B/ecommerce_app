import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'checkout_services.g.dart';

abstract class CheckoutServices {
  Future<void> placeOrder();
}

@riverpod
CheckoutServices checkoutService(Ref ref) {
  throw UnimplementedError();
}
