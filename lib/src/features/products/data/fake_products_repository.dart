import 'dart:async';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';
import '../../../utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'fake_products_repository.g.dart';

class FakeProductsRepository {
  FakeProductsRepository({this.addDelay = true});

  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));
  late bool addDelay;

  List<Product> getProductsList() {
    return _products.value;
  }

  Product? getProductById(String id) {
    return _getProductById(_products.value, id);
  }

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

  Future<List<Product>> fetchProductsList() async {
    return Future.value(_products.value);
  }

  Stream<List<Product>> watchProductsList() {
    return _products.stream;
  }

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

@riverpod
FakeProductsRepository productsRepository(Ref ref) {
  return FakeProductsRepository(addDelay: false);
}

@riverpod
Stream<List<Product>> productsListStream(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProductsList();
}

@riverpod
Future<List<Product>> productsListFuture(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.fetchProductsList();
}

@riverpod
Stream<Product?> productStreamById(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductById(id);
}

@riverpod
Future<List<Product>> productsListSearch(Ref ref, String query) {
  final link = ref.keepAlive();
  // * keep previous search results in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  return ref.watch(productsRepositoryProvider).searchProductList(query);
}
