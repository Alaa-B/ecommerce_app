import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/orders/data/orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userOrdersProvider = StreamProvider.autoDispose<List<Order>>((ref) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    final ordersRepository = ref.watch(ordersRepositoryProvider);
    return ordersRepository.watchUserOrders(user.uid);
  } else {
    // If the user is null, just return an empty screen.
    return const Stream.empty();
  }
});

final matchUserOrdersStreamProvider =
    StreamProvider.autoDispose.family<List<Order>, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(ordersRepositoryProvider)
        .watchUserOrders(user.uid, productId: productId);
  } else {
    return Stream.value([]);
  }
});
