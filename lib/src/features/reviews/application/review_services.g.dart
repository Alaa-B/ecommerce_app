// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewsServiceHash() => r'3573ce379c13e00d1897707c3a0cfcc2d3149c85';

/// See also [reviewsService].
@ProviderFor(reviewsService)
final reviewsServiceProvider = AutoDisposeProvider<ReviewServices>.internal(
  reviewsService,
  name: r'reviewsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewsServiceRef = AutoDisposeProviderRef<ReviewServices>;
String _$watchUserReviewsHash() => r'427a8f43d9d4c6876805b8200d3a86bc28c82fc2';

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

/// See also [watchUserReviews].
@ProviderFor(watchUserReviews)
const watchUserReviewsProvider = WatchUserReviewsFamily();

/// See also [watchUserReviews].
class WatchUserReviewsFamily extends Family<AsyncValue<Review?>> {
  /// See also [watchUserReviews].
  const WatchUserReviewsFamily();

  /// See also [watchUserReviews].
  WatchUserReviewsProvider call(
    String productId,
  ) {
    return WatchUserReviewsProvider(
      productId,
    );
  }

  @override
  WatchUserReviewsProvider getProviderOverride(
    covariant WatchUserReviewsProvider provider,
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
  String? get name => r'watchUserReviewsProvider';
}

/// See also [watchUserReviews].
class WatchUserReviewsProvider extends AutoDisposeStreamProvider<Review?> {
  /// See also [watchUserReviews].
  WatchUserReviewsProvider(
    String productId,
  ) : this._internal(
          (ref) => watchUserReviews(
            ref as WatchUserReviewsRef,
            productId,
          ),
          from: watchUserReviewsProvider,
          name: r'watchUserReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchUserReviewsHash,
          dependencies: WatchUserReviewsFamily._dependencies,
          allTransitiveDependencies:
              WatchUserReviewsFamily._allTransitiveDependencies,
          productId: productId,
        );

  WatchUserReviewsProvider._internal(
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
    Stream<Review?> Function(WatchUserReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchUserReviewsProvider._internal(
        (ref) => create(ref as WatchUserReviewsRef),
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
  AutoDisposeStreamProviderElement<Review?> createElement() {
    return _WatchUserReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchUserReviewsProvider && other.productId == productId;
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
mixin WatchUserReviewsRef on AutoDisposeStreamProviderRef<Review?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _WatchUserReviewsProviderElement
    extends AutoDisposeStreamProviderElement<Review?> with WatchUserReviewsRef {
  _WatchUserReviewsProviderElement(super.provider);

  @override
  String get productId => (origin as WatchUserReviewsProvider).productId;
}

String _$fetchUserReviewsHash() => r'53100d2d8256c223827e31e831375377af44aa0b';

/// See also [fetchUserReviews].
@ProviderFor(fetchUserReviews)
const fetchUserReviewsProvider = FetchUserReviewsFamily();

/// See also [fetchUserReviews].
class FetchUserReviewsFamily extends Family<AsyncValue<Review?>> {
  /// See also [fetchUserReviews].
  const FetchUserReviewsFamily();

  /// See also [fetchUserReviews].
  FetchUserReviewsProvider call(
    String productId,
  ) {
    return FetchUserReviewsProvider(
      productId,
    );
  }

  @override
  FetchUserReviewsProvider getProviderOverride(
    covariant FetchUserReviewsProvider provider,
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
  String? get name => r'fetchUserReviewsProvider';
}

/// See also [fetchUserReviews].
class FetchUserReviewsProvider extends AutoDisposeFutureProvider<Review?> {
  /// See also [fetchUserReviews].
  FetchUserReviewsProvider(
    String productId,
  ) : this._internal(
          (ref) => fetchUserReviews(
            ref as FetchUserReviewsRef,
            productId,
          ),
          from: fetchUserReviewsProvider,
          name: r'fetchUserReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserReviewsHash,
          dependencies: FetchUserReviewsFamily._dependencies,
          allTransitiveDependencies:
              FetchUserReviewsFamily._allTransitiveDependencies,
          productId: productId,
        );

  FetchUserReviewsProvider._internal(
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
    FutureOr<Review?> Function(FetchUserReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserReviewsProvider._internal(
        (ref) => create(ref as FetchUserReviewsRef),
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
  AutoDisposeFutureProviderElement<Review?> createElement() {
    return _FetchUserReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserReviewsProvider && other.productId == productId;
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
mixin FetchUserReviewsRef on AutoDisposeFutureProviderRef<Review?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _FetchUserReviewsProviderElement
    extends AutoDisposeFutureProviderElement<Review?> with FetchUserReviewsRef {
  _FetchUserReviewsProviderElement(super.provider);

  @override
  String get productId => (origin as FetchUserReviewsProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
