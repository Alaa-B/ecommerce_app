import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartScreenController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartScreenController({required this.cartServices})
      : super(AsyncData(null));

  final CartServices cartServices;

  Future<void> updateItemQuantity(ProductID productId, int quantity) async {
    state = const AsyncLoading();
    final updatedItem = Item(productId: productId, quantity: quantity);
    state = await AsyncValue.guard(() => cartServices.setItem(updatedItem));
  }

  Future<void> removeItemById(ProductID productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartServices.removeItem(productId));
  }
}

final shoppingCartScreenControllerProvider =
    StateNotifierProvider<ShoppingCartScreenController, AsyncValue<void>>(
        (ref) {
  final cartServices = ref.watch(cartServicesProvider);
  return ShoppingCartScreenController(cartServices: cartServices);
});
