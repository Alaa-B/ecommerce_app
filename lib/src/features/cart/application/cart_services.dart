import '../../authentication/data/fake_auth_repository.dart';
import '../data/local/local_cart_repository.dart';
import '../data/remote/remote_cart_repository.dart';
import '../domain/cart.dart';
import '../domain/item.dart';
import '../domain/mutable_cart.dart';
import '../../products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> removeItem(ProductID prodId) async {
    final cart = await _fetchCart();
    final updatedCart = cart.removeItemById(prodId);
    await _setCart(updatedCart);
  }
}

final cartServicesProvider = Provider<CartServices>((ref) {
  return CartServices(ref);
});
