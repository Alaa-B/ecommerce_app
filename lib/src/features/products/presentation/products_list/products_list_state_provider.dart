import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_list_state_provider.g.dart';

final productsListStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Product>> productSearchResult(Ref ref) {
  final searchQuery = ref.watch(productsListStateProvider);
  return ref.watch(productsListSearchProvider(searchQuery).future);
}
