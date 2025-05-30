import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentButtonController extends StateNotifier<AsyncValue<void>> {
  PaymentButtonController(this.checkOutService) : super(AsyncData(null));
  final FakeCheckoutService checkOutService;

  Future<void> pay() async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(checkOutService.placeOrder);
    if (mounted) {
      state = newState;
    }
  }
}

final paymentButtonControllerProvider = StateNotifierProvider.autoDispose<
    PaymentButtonController, AsyncValue<void>>((ref) {
  return PaymentButtonController(ref.watch(checkoutServiceProvider));
});
