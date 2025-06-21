// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'6bb9aac84882ffe94981da5617a35df0343457a6';

/// See also [productsRepository].
@ProviderFor(productsRepository)
final productsRepositoryProvider = Provider<ProductsRepository>.internal(
  productsRepository,
  name: r'productsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRepositoryRef = ProviderRef<ProductsRepository>;
String _$productsListStreamHash() =>
    r'a2bfd3a2a6593ff665a3587a05c9e6d1e9ecc616';

/// See also [productsListStream].
@ProviderFor(productsListStream)
final productsListStreamProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  productsListStream,
  name: r'productsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsListStreamRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$productsListFutureHash() =>
    r'14caf5bab4ad2fea09fa317adfe392402f869041';

/// See also [productsListFuture].
@ProviderFor(productsListFuture)
final productsListFutureProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
  productsListFuture,
  name: r'productsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsListFutureRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$productStreamByIdHash() => r'dc8dcba9f0e9d2a741cc9358edb208f4348822a7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [productStreamById].
@ProviderFor(productStreamById)
const productStreamByIdProvider = ProductStreamByIdFamily();

/// See also [productStreamById].
class ProductStreamByIdFamily extends Family<AsyncValue<Product?>> {
  /// See also [productStreamById].
  const ProductStreamByIdFamily();

  /// See also [productStreamById].
  ProductStreamByIdProvider call(
    String id,
  ) {
    return ProductStreamByIdProvider(
      id,
    );
  }

  @override
  ProductStreamByIdProvider getProviderOverride(
    covariant ProductStreamByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productStreamByIdProvider';
}

/// See also [productStreamById].
class ProductStreamByIdProvider extends AutoDisposeStreamProvider<Product?> {
  /// See also [productStreamById].
  ProductStreamByIdProvider(
    String id,
  ) : this._internal(
          (ref) => productStreamById(
            ref as ProductStreamByIdRef,
            id,
          ),
          from: productStreamByIdProvider,
          name: r'productStreamByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStreamByIdHash,
          dependencies: ProductStreamByIdFamily._dependencies,
          allTransitiveDependencies:
              ProductStreamByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ProductStreamByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Product?> Function(ProductStreamByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductStreamByIdProvider._internal(
        (ref) => create(ref as ProductStreamByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product?> createElement() {
    return _ProductStreamByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStreamByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStreamByIdRef on AutoDisposeStreamProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductStreamByIdProviderElement
    extends AutoDisposeStreamProviderElement<Product?>
    with ProductStreamByIdRef {
  _ProductStreamByIdProviderElement(super.provider);

  @override
  String get id => (origin as ProductStreamByIdProvider).id;
}

String _$productFutureByIdHash() => r'35f8c41a7402394996064136ae8c578ead5836fa';

/// See also [productFutureById].
@ProviderFor(productFutureById)
const productFutureByIdProvider = ProductFutureByIdFamily();

/// See also [productFutureById].
class ProductFutureByIdFamily extends Family<AsyncValue<Product?>> {
  /// See also [productFutureById].
  const ProductFutureByIdFamily();

  /// See also [productFutureById].
  ProductFutureByIdProvider call(
    String id,
  ) {
    return ProductFutureByIdProvider(
      id,
    );
  }

  @override
  ProductFutureByIdProvider getProviderOverride(
    covariant ProductFutureByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productFutureByIdProvider';
}

/// See also [productFutureById].
class ProductFutureByIdProvider extends AutoDisposeFutureProvider<Product?> {
  /// See also [productFutureById].
  ProductFutureByIdProvider(
    String id,
  ) : this._internal(
          (ref) => productFutureById(
            ref as ProductFutureByIdRef,
            id,
          ),
          from: productFutureByIdProvider,
          name: r'productFutureByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productFutureByIdHash,
          dependencies: ProductFutureByIdFamily._dependencies,
          allTransitiveDependencies:
              ProductFutureByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ProductFutureByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Product?> Function(ProductFutureByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductFutureByIdProvider._internal(
        (ref) => create(ref as ProductFutureByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductFutureByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFutureByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductFutureByIdRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductFutureByIdProviderElement
    extends AutoDisposeFutureProviderElement<Product?>
    with ProductFutureByIdRef {
  _ProductFutureByIdProviderElement(super.provider);

  @override
  String get id => (origin as ProductFutureByIdProvider).id;
}

String _$productsListSearchHash() =>
    r'd04141457df8a3af6895006b99dfb16054b9416b';

/// See also [productsListSearch].
@ProviderFor(productsListSearch)
const productsListSearchProvider = ProductsListSearchFamily();

/// See also [productsListSearch].
class ProductsListSearchFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsListSearch].
  const ProductsListSearchFamily();

  /// See also [productsListSearch].
  ProductsListSearchProvider call(
    String query,
  ) {
    return ProductsListSearchProvider(
      query,
    );
  }

  @override
  ProductsListSearchProvider getProviderOverride(
    covariant ProductsListSearchProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsListSearchProvider';
}

/// See also [productsListSearch].
class ProductsListSearchProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [productsListSearch].
  ProductsListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => productsListSearch(
            ref as ProductsListSearchRef,
            query,
          ),
          from: productsListSearchProvider,
          name: r'productsListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productsListSearchHash,
          dependencies: ProductsListSearchFamily._dependencies,
          allTransitiveDependencies:
              ProductsListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  ProductsListSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsListSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsListSearchProvider._internal(
        (ref) => create(ref as ProductsListSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsListSearchRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _ProductsListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsListSearchRef {
  _ProductsListSearchProviderElement(super.provider);

  @override
  String get query => (origin as ProductsListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
