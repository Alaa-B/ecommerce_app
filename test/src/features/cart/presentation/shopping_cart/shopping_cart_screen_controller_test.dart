import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('UpdateQuantity', () {
    const productId = '5';

    test('updateItemQuantity success', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.setItem(Item(productId: productId, quantity: 3)))
          .thenAnswer((_) => Future.value(null));
      final controller =
          ShoppingCartScreenController(cartServices: cartServices);
      expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            const AsyncData<void>(null),
          ]));
      await controller.updateItemQuantity(productId, 3);
    });
    test('updateItemQuantity failed', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.setItem(Item(productId: productId, quantity: 3)))
          .thenThrow((_) => Exception('connection failed'));
      final controller =
          ShoppingCartScreenController(cartServices: cartServices);
      expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ]));
      await controller.updateItemQuantity(productId, 3);
    });
  });
  group('RemoveItemById', () {
    const productId = '5';

    test('removeItemById success', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.removeItem(productId))
          .thenAnswer((_) => Future.value(null));
      final controller =
          ShoppingCartScreenController(cartServices: cartServices);
      expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            const AsyncData<void>(null),
          ]));
      await controller.removeItemById(productId);
    });
    test('removeItemById failed', () async {
      final cartServices = MockCartServicesRepository();
      when(() => cartServices.removeItem(productId))
          .thenThrow((_) => Exception('connection failed'));
      final controller =
          ShoppingCartScreenController(cartServices: cartServices);
      expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncValue<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ]));
      await controller.removeItemById(productId);
    });
  });
}
