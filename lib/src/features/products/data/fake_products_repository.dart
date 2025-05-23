import 'dart:async';
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
  FakeProductsRepository({this.isDelay = true});

  final _products = kTestProducts;
  late bool isDelay;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProductById(String id) {
    return _getProductById(_products, id);
  }

  Future<List<Product>> fetchProductsList() async {
    await delayed(isDelay);
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await delayed(isDelay);
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
  return FakeProductsRepository(isDelay: false);
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
