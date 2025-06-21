// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_list_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productSearchResultHash() =>
    r'98ea94be3000ff2875ffeb517ed26df3144aa804';

/// See also [productSearchResult].
@ProviderFor(productSearchResult)
final productSearchResultProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
  productSearchResult,
  name: r'productSearchResultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productSearchResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductSearchResultRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$productsListStateHash() => r'08651c199c029a33597273aaf66d2795a7b342ce';

/// See also [ProductsListState].
@ProviderFor(ProductsListState)
final productsListStateProvider =
    AutoDisposeNotifierProvider<ProductsListState, String>.internal(
  ProductsListState.new,
  name: r'productsListStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsListState = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
