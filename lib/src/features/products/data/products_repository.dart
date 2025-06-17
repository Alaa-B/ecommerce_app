import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_repository.g.dart';

abstract class ProductsRepository {
  List<Product> getProductsList();
  Product? getProductById(String id);
  Future<List<Product>> searchProductList(String query);
  Future<List<Product>> fetchProductsList();
  Stream<List<Product>> watchProductsList();
  Stream<Product?> watchProductById(String id);
  Future<void> setProduct(Product product);
}

@riverpod
ProductsRepository productsRepository(Ref ref) {
  throw UnimplementedError();
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
  // final link = ref.keepAlive();
  // // * keep previous search results in memory for 60 seconds
  // final timer = Timer(const Duration(seconds: 60), () {
  //   link.close();
  // });
  // ref.onDispose(() => timer.cancel());
  return ref.watch(productsRepositoryProvider).searchProductList(query);
}
