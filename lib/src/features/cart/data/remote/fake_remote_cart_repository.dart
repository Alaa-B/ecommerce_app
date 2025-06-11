import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/cart.dart';
import '../../../../utils/delay.dart';
import '../../../../utils/in_memory_store.dart';

part 'fake_remote_cart_repository.g.dart';

class FakeRemoteCartRepository {
  FakeRemoteCartRepository({this.addDelay = true});
  final bool addDelay;

  /// An InMemoryStore containing the shopping cart data for all users, where:
  /// key: uid of the user
  /// value: Cart of that user
  final _carts = InMemoryStore<Map<String, Cart>>({});

  Future<Cart> fetchCart(String uid) {
    return Future.value(_carts.value[uid] ?? const Cart());
  }

  Stream<Cart> watchCart(String uid) {
    return _carts.stream.map((cartData) => cartData[uid] ?? const Cart());
  }

  Future<void> setCart(String uid, Cart cart) async {
    await delayed(addDelay);
    // First, get the current carts data for all users
    final carts = _carts.value;
    // Then, set the cart for the given uid
    carts[uid] = cart;
    // Finally, update the carts data (will emit a new value)
    _carts.value = carts;
  }
}

@Riverpod(keepAlive: true)
FakeRemoteCartRepository remoteCartRepository(Ref ref) {
  return FakeRemoteCartRepository(addDelay: false);
}
