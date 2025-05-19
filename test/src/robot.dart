import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';

class Robot {
  final WidgetTester tester;

  Robot(this.tester) : auth = AuthRobot(tester);
  final AuthRobot auth;

  Future<void> pumpMyApp() async {
    final authRepo = FakeAuthRepository(delay: false);
    final productRepo = FakeProductsRepository(isDelay: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(authRepo),
          productsRepositoryProvider.overrideWithValue(productRepo),
        ],
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  void expectFindAllProducts() {
    final Finder productCard = find.byType(ProductCard);
    expect(productCard, findsExactly(kTestProducts.length));
  }

  Future<void> openPopUpMenu() async {
    final Finder popUpMenu = find.byType(MoreMenuButton);
    final matcher = popUpMenu.evaluate();
    if (matcher.isNotEmpty) {
      tester.tap(popUpMenu);
      await tester.pumpAndSettle();
    }
  }
}
