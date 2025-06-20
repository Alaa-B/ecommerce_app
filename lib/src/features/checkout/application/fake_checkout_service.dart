import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/checkout/application/checkout_services.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

/// A fake checkout service that doesn't process real payments.
class FakeCheckoutService implements CheckoutServices {
  FakeCheckoutService({
    required this.authRepository,
    required this.remoteCartRepository,
    required this.ordersRepository,
    required this.productsRepository,
    required this.currentDate,
  });

  final AuthRepository authRepository;
  final RemoteCartRepository remoteCartRepository;
  final FakeOrdersRepository ordersRepository;
  final FakeProductsRepository productsRepository;
  final DateTime Function() currentDate;

  /// Temporary client-side logic for placing an order.
  /// Part of this logic should run on the server, so that we can:
  /// - setup a payment intent
  /// - show the payment UI
  /// - process the payment and fulfill the order
  /// The server-side logic will be covered in course #2
  @override
  Future<void> placeOrder() async {
    // * Assertion operator is ok here since this method is only called from
    // * a place where the user is signed in
    final uid = authRepository.currentUser!.uid;
    // 1. Get the cart object
    final cart = await remoteCartRepository.fetchCart(uid);
    if (cart.items.isNotEmpty) {
      final total = _totalPrice(cart);
      final orderDate = currentDate();
      // * The orderId is a unique string that could be generated with the UUID
      // * package. Since this is a fake service, we just derive it from the date.
      final orderId = orderDate.toIso8601String();
      // 2. Create an order
      final order = Order(
        id: orderId,
        userId: uid,
        items: cart.items,
        productIds: cart.items.keys.toList(),
        orderStatus: OrderStatus.confirmed,
        orderDate: orderDate,
        total: total,
      );
      // 3. Save it using the repository
      await ordersRepository.addOrder(uid, order);
      // 4. Empty the cart
      await remoteCartRepository.setCart(uid, const Cart());
    } else {
      throw StateError('Can\'t place an order if the cart is empty'.hardcoded);
    }
  }

  // Helper method to calculate the total price
  double _totalPrice(Cart cart) {
    if (cart.items.isEmpty) {
      return 0.0;
    }
    return cart.items.entries
        // first extract quantity * price for each item
        .map((entry) =>
            entry.value * // quantity
            productsRepository.getProductById(entry.key)!.price) // price
        // then add them up
        .reduce((value, element) => value + element);
  }
}
