import 'dart:async';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';
import '../../../utils/delay.dart';

class FakeProductsRepository implements ProductsRepository {
  FakeProductsRepository({this.addDelay = true});

  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));
  late bool addDelay;

  @override
  List<Product> getProductsList() {
    return _products.value;
  }

  @override
  Product? getProductById(String id) {
    return _getProductById(_products.value, id);
  }

  @override
  Future<List<Product>> searchProductList(String query) async {
    final products = await fetchProductsList();
    final lowerCaseQuery = query.toLowerCase();
    assert(
      products.length <= 100,
      'the length of the product is too long to search on client side',
    );
    return products.where((p) {
      return p.title.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  @override
  Future<List<Product>> fetchProductsList() async {
    return Future.value(_products.value);
  }

  @override
  Stream<List<Product>> watchProductsList() {
    return _products.stream;
  }

  @override
  Stream<Product?> watchProductById(String id) {
    return watchProductsList().map(
      (product) => _getProductById(product, id),
    );
  }

  static Product? _getProductById(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setProduct(Product product) async {
    await delayed(addDelay);
    final products = _products.value;
    final index = products.indexWhere((p) => p.id == product.id);
    //* indexWhere return -1 if the product isn't found
    if (index == -1) {
      products.add(product);
    } else {
      products[index] = product;
    }
    _products.value = products;
  }
}
