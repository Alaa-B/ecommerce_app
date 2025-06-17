import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'remote_cart_repository.g.dart';

abstract class RemoteCartRepository {
  Future<void> setCart(String uid, Cart cart);
  Future<Cart> fetchCart(String uid);
  Stream<Cart> watchCart(String uid);
}

@Riverpod(keepAlive: true)
RemoteCartRepository remoteCartRepository(Ref ref) {
  // TODO: create and return repository
  throw UnimplementedError();
}
