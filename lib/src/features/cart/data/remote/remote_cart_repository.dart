import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';

import '../../domain/cart.dart';
import 'package:riverpod/riverpod.dart';

/// API for reading, watching and writing cart data for a specific user ID
abstract class RemoteCartRepository {
  Future<Cart> fetchCart(String uid);

  Stream<Cart> watchCart(String uid);

  Future<void> setCart(String uid, Cart cart);
}

final remoteCartRepositoryProvider = Provider<RemoteCartRepository>((ref) {
  return FakeRemoteCartRepository(addDelay: false);
});
