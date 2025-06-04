import 'dart:async';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';
import '../../../utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    await delayed(addDelay);
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

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProductsList();
});
final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.fetchProductsList();
});

final productStreamByIdProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  //* this line is used to control the lifecycle of the stream.
  // debugPrint('product stream by Id:$id created');
  // ref.onDispose(() {
  //   debugPrint('product stream by Id:$id disposed');
  // });
  // final link = ref.keepAlive();
  // Timer(Duration(seconds: 5), () {
  //   link.close();
  // });
  return productsRepository.watchProductById(id);
});

final productsListSearchProvider = FutureProvider.family
    .autoDispose<List<Product>, String>((ref, query) async {
  final link = ref.keepAlive();
  Timer(const Duration(seconds: 5), link.close);
  return ref.watch(productsRepositoryProvider).searchProductList(query);
});
