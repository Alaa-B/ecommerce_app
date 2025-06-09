import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(
      MockCartServicesRepository cartService) {
    final container = ProviderContainer(
      overrides: [
        cartServicesProvider.overrideWithValue(cartService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });
  const productId = '5';
  group('UpdateQuantity', () {
    test('updateItemQuantity success', () async {
      const item = Item(productId: productId, quantity: 3);
      final cartServices = MockCartServicesRepository();
      final container = makeProviderContainer(cartServices);
      when(() => cartServices.setItem(Item(productId: productId, quantity: 3)))
          .thenAnswer((_) => Future.value(null));
      final controller =
          container.read(shoppingCartScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        shoppingCartScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      await controller.updateItemQuantity(productId, 3);
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => cartServices.setItem(item)).called(1);
    });

    test('updateItemQuantity failed', () async {
      const item = Item(productId: productId, quantity: 3);
      final cartService = MockCartServicesRepository();
      when(() => cartService.setItem(item)).thenThrow(
        (_) => Exception('Connection failed'),
      );
      final container = makeProviderContainer(cartService);
      final controller =
          container.read(shoppingCartScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        shoppingCartScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      // run
      await controller.updateItemQuantity(productId, 3);
      // verify
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => cartService.setItem(item)).called(1);
    });
  });

  group('RemoveItemById', () {
    test('removeItemById success', () async {
      // setup
      final cartService = MockCartServicesRepository();
      when(() => cartService.removeItem(productId)).thenAnswer(
        (_) => Future.value(null),
      );
      final container = makeProviderContainer(cartService);
      final controller =
          container.read(shoppingCartScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        shoppingCartScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      // run
      await controller.removeItemById(productId);
      // verify
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => cartService.removeItem(productId)).called(1);
    });

    test('removeItemById failed', () async {
      final cartService = MockCartServicesRepository();
      when(() => cartService.removeItem(productId)).thenThrow(
        (_) => Exception('Connection failed'),
      );
      final container = makeProviderContainer(cartService);
      final controller =
          container.read(shoppingCartScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        shoppingCartScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      verify(() => listener(null, data));
      // run
      await controller.removeItemById(productId);
      // verify
      verifyInOrder([
        () => listener(data, any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => cartService.removeItem(productId)).called(1);
    });
  });
}
