import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fake Products Repository', () {
    FakeProductsRepository fakeProductsRepository() =>
        FakeProductsRepository(isDelay: false);
    test('fake auth repository return kTestProducts', () {
      final productsRepository = fakeProductsRepository();
      expect(productsRepository.getProductsList(), kTestProducts);
    });
    test('return null product for fault Id', () {
      final productsRepository = fakeProductsRepository();
      expect(
        productsRepository.getProductById('100'),
        null,
      );
    });
    test('return product by Id', () {
      final productsRepository = fakeProductsRepository();
      expect(
        productsRepository.getProductById('1'),
        kTestProducts[0],
      );
    });

    test('fetch products list return _kTestProducts', () async {
      final productsRepository = fakeProductsRepository();
      expect(
        await productsRepository.fetchProductsList(),
        kTestProducts,
      );
    });
    test('watch products list return _kTestProducts', () {
      final productsRepository = fakeProductsRepository();
      expect(
        productsRepository.watchProductsList(),
        emits(kTestProducts),
      );
    });
    test('watch products by Id return product[id]', () {
      final productsRepository = fakeProductsRepository();
      expect(
        productsRepository.watchProductById('1'),
        emits(kTestProducts[0]),
      );
    });
    test('watch products by Id [100] return null', () {
      final productsRepository = fakeProductsRepository();
      expect(
        productsRepository.watchProductById('100'),
        emits(null),
      );
    });
  });
}
