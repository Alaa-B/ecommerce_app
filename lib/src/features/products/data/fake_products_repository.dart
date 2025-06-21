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

  Product? getProductById(String id) {
    return _getProductById(_products.value, id);
  }

  @override
  Future<List<Product>> fetchProductsList() async {
    return Future.value(_products.value);
  }

  @override
  Stream<List<Product>> watchProductsList() {
    return _products.stream;
  }

  // Retrieve a specific product by ID
  @override
  Future<Product?> fetchProductById(String id) {
    return Future.value(_getProductById(_products.value, id));
  }

  // Retrieve a specific product by ID
  @override
  Stream<Product?> watchProductById(String id) {
    return watchProductsList().map((products) => _getProductById(products, id));
  }

  Future<void> setProduct(Product product) async {
    await delayed(addDelay);
    final products = _products.value;
    final index = products.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      // if not found, add as a new product
      products.add(product);
    } else {
      // else, overwrite previous product
      products[index] = product;
    }
    _products.value = products;
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

  static Product? _getProductById(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createProduct(ProductID id, String imageUrl) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(ProductID productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
