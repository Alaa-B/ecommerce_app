import 'package:flutter_test/flutter_test.dart';
import '../../../../robot.dart';

void main() {
  group('shopping cart', () {
    testWidgets('Empty shopping cart', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      r.products.expectFindNProductCards(15); // check all products are found
      await r.cart.openCart();
      r.cart.expectShoppingCartIsEmpty();
    });

    testWidgets('Add product with quantity = 1', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.cart.addToCart();
      await r.cart.openCart();
      r.cart.expectItemQuantity(quantity: 1, atIndex: 0);
      r.cart.expectShoppingCartTotalIs('Total: \$12.99');
    });

    testWidgets('Add product with quantity = 5', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(5);
      await r.cart.addToCart();
      await r.cart.openCart();
      r.cart.expectItemQuantity(quantity: 5, atIndex: 0);
      r.cart.expectShoppingCartTotalIs('Total: \$64.95');
    });

    testWidgets('Add product with quantity = 6', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(5);
      await r.cart.addToCart();
      await r.cart.openCart();
      r.cart.expectItemQuantity(quantity: 5, atIndex: 0);
      r.cart.expectShoppingCartTotalIs('Total: \$64.95');
    });

    testWidgets('Add product with quantity = 2, then increment by 2',
        (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(2);
      await r.cart.addToCart();
      await r.cart.openCart();
      await r.cart.incrementCartItemQuantity(quantity: 2, atIndex: 0);
      r.cart.expectItemQuantity(quantity: 4, atIndex: 0);
      r.cart.expectShoppingCartTotalIs('Total: \$51.96');
    });

    testWidgets('Add product with quantity = 5, then decrement by 2',
        (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(5);
      await r.cart.addToCart();
      await r.cart.openCart();
      await r.cart.decrementCartItemQuantity(quantity: 2, atIndex: 0);
      r.cart.expectItemQuantity(quantity: 3, atIndex: 0);
      r.cart.expectShoppingCartTotalIs('Total: \$38.97');
    });

    testWidgets('Add two products', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      // add first product
      await r.products.selectProduct(atIndex: 0);
      await r.cart.addToCart();
      await r.goBack();
      // add second product
      await r.products.selectProduct(atIndex: 1);
      await r.cart.addToCart();
      await r.cart.openCart();
      r.cart.expectFindNCartItems(2);
      r.cart.expectShoppingCartTotalIs('Total: \$27.49');
    });

    testWidgets('Add product, then delete it', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.cart.addToCart();
      await r.cart.openCart();
      await r.cart.deleteCartItem(atIndex: 0);
      r.cart.expectShoppingCartIsEmpty();
    });

    testWidgets('Add product with quantity = 5, goes out of stock',
        (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(30);
      await r.cart.addToCart();
      r.cart.expectProductIsOutOfStock();
    });

    testWidgets(
        'Add product with quantity = 5, remains out of stock when opened again',
        (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      await r.products.selectProduct();
      await r.products.setProductQuantity(30);
      await r.cart.addToCart();
      await r.goBack();
      await r.products.selectProduct();
      r.cart.expectProductIsOutOfStock();
    });
  });
}
