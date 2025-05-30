import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/src/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Full purchase flow', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    r.products.expectFindAllProductCards();
    // add cart item
    await r.products.selectProduct();
    await r.products.setProductQuantity(3);
    await r.cart.addToCart();
    await r.cart.openCart();
    r.cart.expectFindNCartItems(1);
    // checkout and pay
    await r.checkout.startCheckout();
    await r.auth.tapFormToggleButton();
    await r.auth.signInWithEmailAndPassword();
    tester.runAsync(() async {
      // add latency for the cartSync to read from memory
      await Future.delayed(Duration(seconds: 3));
      r.products.expectFindNProductCards(2);
      r.checkout.expectPayButtonFound();
      await r.checkout.startPayment();
      r.order.expectFindNOrders(1);
      await r.closePage();
      // cart is empty
      await r.cart.openCart();
      r.cart.expectFindZeroCartItems();
      // logout
      await r.openPopUpMenu();
      await r.auth.tapAccountButton();
      await r.auth.tapLogoutButton();
      await r.auth.tapLogoutDialogButton();
      r.products.expectFindAllProductCards();
    });
  });
}
