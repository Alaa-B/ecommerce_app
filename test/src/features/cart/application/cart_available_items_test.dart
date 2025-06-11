import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvailableItemsProviderTest', () {
    ProviderContainer makeProviderContainer({required Stream<Cart> cart}) {
      final container = ProviderContainer(overrides: [
        cartServicesStreamProvider.overrideWith((ref) => cart),
      ]);
      addTearDown(container.dispose);
      return container;
    }

    test('loading cart', () async {
      final container = makeProviderContainer(cart: const Stream.empty());
      final availableQuantity =
          container.read(availableItemsQuantityProvider(kTestProducts[0]));
      expect(availableQuantity, 30);
    });
    test('empty cart', () async {
      final container = makeProviderContainer(cart: Stream.value(Cart()));
      final availableQuantity =
          container.read(availableItemsQuantityProvider(kTestProducts[0]));
      expect(availableQuantity, 30);
    });
    test('product with only 1 item available', () async {
      final container =
          makeProviderContainer(cart: Stream.value(Cart({'1': 1})));
      await container.read(cartServicesStreamProvider.future);
      final availableQuantity =
          container.read(availableItemsQuantityProvider(kTestProducts[0]));
      expect(availableQuantity, 29);
    });
    test('product with 10 item available', () async {
      final container =
          makeProviderContainer(cart: Stream.value(Cart({'1': 10})));
      await container.read(cartServicesStreamProvider.future);
      final availableQuantity =
          container.read(availableItemsQuantityProvider(kTestProducts[0]));
      expect(availableQuantity, 20);
    });
  });
}
