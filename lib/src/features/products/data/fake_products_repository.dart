import 'dart:async';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  FakeProductsRepository._();
  static FakeProductsRepository instance = FakeProductsRepository._();

  final _products = kTestProducts;
  List<Product> getProductsList() {
    return _products;
  }

  Product? getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProductById(String id) {
    return watchProductsList().map(
      (product) {
        return product.firstWhere((product) => product.id == id);
      },
    );
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository.instance;
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
