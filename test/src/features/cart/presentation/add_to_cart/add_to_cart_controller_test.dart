import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const productId = '5';

  group('AddItem', () {
    test('add to cart controller addItem', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.addItem(Item(productId: productId, quantity: 2)))
          .thenAnswer((_) => Future.value(null));
      final controller = AddToCartController(cartServices: cartServices);
      expect(controller.state, const AsyncData(1));
      controller.updateQuantity(2);
      expect(controller.state, AsyncData(2));
      await controller.addToCart(productId);
      verify(
        () => cartServices.addItem(Item(productId: productId, quantity: 2)),
      ).called(1);
      expect(controller.state, AsyncData(1));
    });
    test('add to cart Controller failed to addItem', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.addItem(Item(productId: productId, quantity: 1)))
          .thenThrow((_) => Exception('connection failed'));
      final controller = AddToCartController(cartServices: cartServices);
      await controller.addToCart(productId);
      verify(() =>
              cartServices.addItem(Item(productId: productId, quantity: 1)))
          .called(1);
      expect(controller.state, predicate<AsyncValue<int>>((value) {
        expect(value.hasError, true);
        return true;
      }));
    });
  });
}
