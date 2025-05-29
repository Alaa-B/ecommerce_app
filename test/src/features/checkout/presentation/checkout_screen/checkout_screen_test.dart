import 'package:flutter_test/flutter_test.dart';

import '../../../../robot.dart';

void main() {
  testWidgets('checkout when not previously signed in', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    // add a product and start checkout
    await r.products.selectProduct();
    await r.cart.addToCart();
    await r.cart.openCart();
    await r.checkout.startCheckout();
    // sign in from checkout screen
    r.auth.expectEmailAndPasswordFieldsFound();
    await r.auth.signInWithEmailAndPassword();
    // check that we move to the payment page
    tester.runAsync(() async {
      await Future.delayed(Duration(seconds: 1));
      r.checkout.expectPayButtonFound();
    });
  });

  testWidgets('checkout when previously signed in', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    // create an account first
    await r.auth.tapSignInButton();
    await r.auth.tapFormToggleButton();
    await r.auth.signInWithEmailAndPassword();
    // then add a product and start checkout
    tester.runAsync(() async {
      //* wait for the products to load from memory.
      await Future.delayed(Duration(seconds: 1));
      await r.products.selectProduct();
      await r.cart.addToCart();
      await Future.delayed(Duration(seconds: 1));
      await r.cart.openCart();
      await r.checkout.startCheckout();
      await Future.delayed(Duration(milliseconds: 500));
      // expect that we see the payment page right away
      r.checkout.expectPayButtonFound();
    });
  });
}
