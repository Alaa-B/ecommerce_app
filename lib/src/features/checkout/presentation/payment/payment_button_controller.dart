import 'dart:async';

import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'payment_button_controller.g.dart';

@riverpod
class PaymentButtonController extends _$PaymentButtonController {
  bool mounted = true;
  @override
  FutureOr<void> build() {
    ref.onDispose(() {
      mounted = false;
    });
  }

  Future<void> pay() async {
    final checkOutService = ref.watch(checkoutServiceProvider);
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(checkOutService.placeOrder);
    if (mounted) {
      state = newState;
    }
  }
}
