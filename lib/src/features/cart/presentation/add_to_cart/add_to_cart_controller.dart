import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_cart_controller.g.dart';

@riverpod
class AddToCartController extends _$AddToCartController {
  @override
  FutureOr<void> build() {}

  Future<void> addToCart(ProductID productId) async {
    final item = Item(
        productId: productId,
        quantity: ref.read(itemQuantityControllerProvider));
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(
        () => ref.watch(cartServicesProvider).addItem(item));

    if (!state.hasError) {
      ref.read(itemQuantityControllerProvider.notifier).updateQuantity(1);
    } else {
      state = AsyncError(state.error!, StackTrace.current);
      state = AsyncData(null);
    }
  }
}

@riverpod
class ItemQuantityController extends _$ItemQuantityController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }
}
