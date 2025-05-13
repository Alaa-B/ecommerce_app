import 'dart:async';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  FakeProductsRepository._({required this.delay});

// * for testing set delay to false
  static FakeProductsRepository instance =
      FakeProductsRepository._(delay: false);

  final _products = kTestProducts;
  final bool delay;
  List<Product> getProductsList() {
    return _products;
  }

  Product? getProductById(String id) {
    return _getProductById(_products, id);
  }

  Future<List<Product>> fetchProductsList() async {
    await delayed(delay);
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await delayed(delay);
    yield _products;
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
