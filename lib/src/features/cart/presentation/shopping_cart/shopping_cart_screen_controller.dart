import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_cart_screen_controller.g.dart';

@riverpod
class ShoppingCartScreenController extends _$ShoppingCartScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> updateItemQuantity(ProductID productId, int quantity) async {
    state = const AsyncLoading();
    final updatedItem = Item(productId: productId, quantity: quantity);
    state = await AsyncValue.guard(
        () => ref.watch(cartServicesProvider).setItem(updatedItem));
  }

  Future<void> removeItemById(ProductID productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.watch(cartServicesProvider).removeItem(productId));
  }
}
