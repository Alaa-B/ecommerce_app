import 'dart:async';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';
import '../../../utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  // FakeProductsRepository._instance();
  // static final FakeProductsRepository _inst =
  //     FakeProductsRepository._instance();

  // factory FakeProductsRepository({bool isDelay = true}) {
  //   _inst.delay = isDelay;
  //   return _inst;
  // }
  FakeProductsRepository({this.addDelay = true});

  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));
  late bool addDelay;

  List<Product> getProductsList() {
    return _products.value;
  }

  Product? getProductById(String id) {
    return _getProductById(_products.value, id);
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
