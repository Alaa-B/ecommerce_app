import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartController extends StateNotifier<AsyncValue<int>> {
  AddToCartController({required this.cartServices}) : super(AsyncData(1));

  final CartServices cartServices;
  void updateQuantity(int quantity) {
    state = AsyncData(quantity);
  }

  Future<void> addToCart(Product product) async {
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final item = Item(productId: product.id, quantity: state.value!);
    final value = await AsyncValue.guard(() => cartServices.addItem(item));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData(1);
    }
  }
}

final addToCartControllerProvider =
    StateNotifierProvider<AddToCartController, AsyncValue<int>>((ref) {
  return AddToCartController(cartServices: ref.watch(cartServicesProvider));
});
