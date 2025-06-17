// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewRepositoryHash() => r'46fcd071b20774e173ed7f9b8be1ccbb8070845a';

/// See also [reviewRepository].
@ProviderFor(reviewRepository)
final reviewRepositoryProvider = AutoDisposeProvider<ReviewRepository>.internal(
  reviewRepository,
  name: r'reviewRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewRepositoryRef = AutoDisposeProviderRef<ReviewRepository>;
String _$productReviewStreamHash() =>
    r'66aa48b0f2bfdae30997fdac19694f8c684747ed';

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

/// See also [productReviewStream].
@ProviderFor(productReviewStream)
const productReviewStreamProvider = ProductReviewStreamFamily();

/// See also [productReviewStream].
class ProductReviewStreamFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [productReviewStream].
  const ProductReviewStreamFamily();

  /// See also [productReviewStream].
  ProductReviewStreamProvider call(
    String productId,
  ) {
    return ProductReviewStreamProvider(
      productId,
    );
  }

  @override
  ProductReviewStreamProvider getProviderOverride(
    covariant ProductReviewStreamProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'productReviewStreamProvider';
}

/// See also [productReviewStream].
class ProductReviewStreamProvider
    extends AutoDisposeStreamProvider<List<Review>> {
  /// See also [productReviewStream].
  ProductReviewStreamProvider(
    String productId,
  ) : this._internal(
          (ref) => productReviewStream(
            ref as ProductReviewStreamRef,
            productId,
          ),
          from: productReviewStreamProvider,
          name: r'productReviewStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productReviewStreamHash,
          dependencies: ProductReviewStreamFamily._dependencies,
          allTransitiveDependencies:
              ProductReviewStreamFamily._allTransitiveDependencies,
          productId: productId,
        );

  ProductReviewStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    Stream<List<Review>> Function(ProductReviewStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductReviewStreamProvider._internal(
        (ref) => create(ref as ProductReviewStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Review>> createElement() {
    return _ProductReviewStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductReviewStreamProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductReviewStreamRef on AutoDisposeStreamProviderRef<List<Review>> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductReviewStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Review>>
    with ProductReviewStreamRef {
  _ProductReviewStreamProviderElement(super.provider);

  @override
  String get productId => (origin as ProductReviewStreamProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
