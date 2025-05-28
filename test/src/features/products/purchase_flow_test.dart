import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  testWidgets('Full purchase flow', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    r.products.expectFindAllProductCards();
    // add to cart flows
    await r.products.selectProduct();
    await r.products.setProductQuantity(3);
    await r.cart.addToCart();
    await r.cart.openCart();
    r.cart.expectFindNCartItems(1);
    await r.closePage();
    // sign in
    await r.openPopUpMenu();
    await r.auth.tapSignInButton();
    await r.auth.signInWithEmailAndPassword();
    r.products.expectFindAllProductCards();
    // check cart again (to verify cart synchronization)
    await r.cart.openCart();
    //* wait for the local database to load cart items
    tester.runAsync(() async {
      await Future.delayed(Duration(seconds: 5));
      r.cart.expectFindNCartItems(1);
    });
    await r.closePage();
    // sign out
    await r.openPopUpMenu();
    await r.auth.tapAccountButton();
    await r.auth.tapLogoutButton();
    await r.auth.tapLogoutDialogButton();
    r.products.expectFindAllProductCards();
  });
}
