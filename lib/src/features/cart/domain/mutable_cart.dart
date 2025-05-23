import 'cart.dart';
import 'item.dart';
import '../../products/domain/product.dart';

/// Helper extension used to mutate the items in the shopping cart.
extension MutableCart on Cart {
  /// add an item to the cart by *overriding* the quantity if it already exists
  Cart setItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy[item.productId] = item.quantity;
    return Cart(copy);
  }

  /// add an item to the cart by *updating* the quantity if it already exists
  Cart addItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy.update(
      item.productId,
      (value) => item.quantity + value,
      ifAbsent: () => item.quantity,
    );
    return Cart(copy);
  }

  /// add a list of items to the cart by *updating* the quantities of items that
  /// already exist
  Cart addItems(List<Item> itemsToAdd) {
    final copy = Map<ProductID, int>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.productId,
        (value) => item.quantity + value,
        ifAbsent: () => item.quantity,
      );
    }
    return Cart(copy);
  }

  /// if an item with the given productId is found, remove it
  Cart removeItemById(ProductID productId) {
    final copy = Map<ProductID, int>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }
}
