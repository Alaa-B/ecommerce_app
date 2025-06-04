import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsListStateProvider = StateProvider<String>((ref) {
  return '';
});

final productSearchResultProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final searchQuery = ref.watch(productsListStateProvider);
  return ref.watch(productsListSearchProvider(searchQuery).future);
});
