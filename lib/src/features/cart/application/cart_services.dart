import 'dart:math';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/local_cart_repository.dart';
import '../domain/cart.dart';
import '../domain/item.dart';
import '../domain/mutable_cart.dart';
import '../../products/domain/product.dart';

part 'cart_services.g.dart';

class CartServices {
  CartServices(this.ref);
  final Ref ref;

  Future<Cart> _fetchCart() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteCartRepositoryProvider).fetchCart(user.uid);
    } else {
      return ref.read(localCartRepositoryProvider).fetchCart();
    }
  }

  Future<void> _setCart(Cart cart) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref.read(remoteCartRepositoryProvider).setCart(user.uid, cart);
    } else {
      await ref.read(localCartRepositoryProvider).setCart(cart);
    }
  }

  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.setItem(item);
    await _setCart(updatedCart);
  }

  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.addItem(item);
    await _setCart(updatedCart);
  }

  Future<void> removeItem(ProductID productId) async {
    final cart = await _fetchCart();
    final updatedCart = cart.removeItemById(productId);
    await _setCart(updatedCart);
  }
}

@Riverpod(keepAlive: true)
CartServices cartServices(Ref ref) {
  return CartServices(ref);
}

@Riverpod(keepAlive: true)
Stream<Cart> cartServicesStream(Ref ref) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
  } else {
    return ref.read(localCartRepositoryProvider).watchCart();
  }
}

@Riverpod(keepAlive: true)
int cartItemsCount(Ref ref) {
  final cartProductProvider = ref.watch(cartServicesStreamProvider);
  return cartProductProvider.maybeMap(
    data: (cart) => cart.value.items.length,
    orElse: () => 0,
  );
}

@Riverpod(keepAlive: true)
double cartTotalPrice(Ref ref) {
  final productsList = ref.watch(productsListStreamProvider).value ?? [];
  final cartProductsItems =
      ref.watch(cartServicesStreamProvider).value ?? const Cart();
  if (productsList.isNotEmpty && cartProductsItems.items.isNotEmpty) {
    double total = 0.0;
    for (var item in cartProductsItems.toItemsList()) {
      final product = productsList.firstWhere(
        (element) => element.id == item.productId,
      );
      total += item.quantity * product.price;
    }
    return total;
  } else {
    return 0.0;
  }
}

@riverpod
int availableItemsQuantity(Ref ref, Product product) {
  final cartItems = ref.watch(cartServicesStreamProvider).value;
  if (cartItems != null) {
    //* get the item quantity cuz the cart is "Map<ProductID, int> items"
    final itemQuantity = cartItems.items[product.id] ?? 0;
    return max(0, product.availableQuantity - itemQuantity);
  } else {
    return product.availableQuantity;
  }
}
