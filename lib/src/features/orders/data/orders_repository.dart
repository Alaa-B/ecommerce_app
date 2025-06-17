import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'orders_repository.g.dart';

abstract class OrdersRepository {
  Stream<List<Order>> watchUserOrders(String uid, {ProductID? productId});
  Future<void> addOrder(String uid, Order order);
}

@riverpod
OrdersRepository ordersRepository(Ref ref) {
  throw UnimplementedError();
}
