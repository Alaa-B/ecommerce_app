import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  final email = 'test@test.com';
  final password = '123456789';
  testWidgets('test signIn and signOut flow', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    r.expectFindAllProducts();
    await r.openPopUpMenu();
    await r.auth.tapSignInButton();
    await r.auth.tapFormToggleButton();
    await r.auth.enterEmail(email);
    await r.auth.enterPassword(password);
    await r.auth.tapSubmitButton();
    r.expectFindAllProducts();
    await r.openPopUpMenu();
    await r.auth.tapAccountButton();
    r.auth.expectLogoutButton();
    await r.auth.tapLogoutButton();
    r.auth.expectLogOutDialog();
    await r.auth.tapLogoutDialogButton();
    r.expectFindAllProducts();
  });
}
