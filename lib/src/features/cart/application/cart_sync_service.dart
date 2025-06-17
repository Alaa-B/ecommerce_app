import 'dart:math';
import 'package:ecommerce_app/src/exceptions/error_logger.dart';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cart_sync_service.g.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }
  final Ref ref;
  void _init() {
    ref.listen<AsyncValue<AppUser?>>(
      authStateChangesStreamProvider,
      (previous, next) {
        if (previous?.value == null && next.value != null) {
          _moveItemToRemoteCart(next.value!.uid);
        }
      },
    );
  }

  Future<void> _moveItemToRemoteCart(String uid) async {
    try {
      final localCartRepository = ref.read(localCartRepositoryProvider);
      final cartItems = await localCartRepository.fetchCart();
      if (cartItems.items.isNotEmpty) {
        final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
        final remoteCartItems = await remoteCartRepository.fetchCart(uid);
        final localItems =
            await _getLocalItemsToAdd(cartItems, remoteCartItems);
        final updatedRemoteCart = remoteCartItems.addItems(localItems);
        await remoteCartRepository.setCart(uid, updatedRemoteCart);
        await localCartRepository.setCart(const Cart());
      }
    } catch (error, stackTrace) {
      ref.read(errorLoggerProvider).logError(error, stackTrace);
    }
  }

  Future<List<Item>> _getLocalItemsToAdd(
      Cart localCart, Cart remoteCart) async {
    final productRepository = ref.watch(productsRepositoryProvider);
    final products = await productRepository.fetchProductsList();
    List<Item> itemsToAdd = [];
    for (var localItem in localCart.items.entries) {
      final localProductId = localItem.key;
      final localProductQuantity = localItem.value;
      final remoteProductQuantity = remoteCart.items[localProductId] ?? 0;
      final product =
          products.firstWhere((element) => element.id == localProductId);
      final minLocalQuantity = min(localProductQuantity,
          product.availableQuantity - remoteProductQuantity);
      if (minLocalQuantity > 0) {
        itemsToAdd
            .add(Item(productId: localProductId, quantity: minLocalQuantity));
      }
    }
    return itemsToAdd;
  }
}

@Riverpod(keepAlive: true)
CartSyncService cartSyncService(Ref ref) {
  return CartSyncService(ref);
}
