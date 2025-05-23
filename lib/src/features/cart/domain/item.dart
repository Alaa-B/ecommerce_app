// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../products/domain/product.dart';

/// A product along with a quantity that can be added to an order/cart
class Item extends Equatable {
  const Item({
    required this.productId,
    required this.quantity,
  });
  final ProductID productId;
  final int quantity;

  @override
  List<Object> get props => [productId, quantity];
}
