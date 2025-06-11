import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/fake_local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';
import 'features/cart/cart_robot.dart';
import 'features/checkout/checkout_robot.dart';
import 'features/orders/orders_robot.dart';
import 'features/products/products_robot.dart';

class Robot {
  final WidgetTester tester;

  Robot(this.tester)
      : auth = AuthRobot(tester),
        cart = CartRobot(tester),
        products = ProductsRobot(tester),
        checkout = CheckoutRobot(tester),
        order = OrdersRobot(tester);

  final AuthRobot auth;
  final CartRobot cart;
  final ProductsRobot products;
  final CheckoutRobot checkout;
  final OrdersRobot order;

  Future<void> pumpMyApp() async {
    final authRepo = FakeAuthRepository(delay: false);
    final productRepo = FakeProductsRepository(addDelay: false);
    final localCartRepo = FakeLocalCartRepository(addDelay: false);
    final remoteCartRepo = FakeRemoteCartRepository(addDelay: false);
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepo),
      productsRepositoryProvider.overrideWithValue(productRepo),
      localCartRepositoryProvider.overrideWithValue(localCartRepo),
      remoteCartRepositoryProvider.overrideWithValue(remoteCartRepo),
    ]);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
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

  Future<void> closePage() async {
    final finder = find.byTooltip('Close');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    final finder = find.byTooltip('Back');
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}
