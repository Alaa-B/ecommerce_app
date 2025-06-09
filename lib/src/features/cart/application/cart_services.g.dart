// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartServicesHash() => r'c1d932caf862230a97f5cca9118808229754b452';

/// See also [cartServices].
@ProviderFor(cartServices)
final cartServicesProvider = Provider<CartServices>.internal(
  cartServices,
  name: r'cartServicesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartServicesRef = ProviderRef<CartServices>;
String _$cartServicesStreamHash() =>
    r'9d0917ad448798aca69b3e7b9e81d323539a6984';

/// See also [cartServicesStream].
@ProviderFor(cartServicesStream)
final cartServicesStreamProvider = StreamProvider<Cart>.internal(
  cartServicesStream,
  name: r'cartServicesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartServicesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartServicesStreamRef = StreamProviderRef<Cart>;
String _$cartItemsCountHash() => r'24aa43e23df7465a832e2a638fef7bd13bbf4c80';

/// See also [cartItemsCount].
@ProviderFor(cartItemsCount)
final cartItemsCountProvider = Provider<int>.internal(
  cartItemsCount,
  name: r'cartItemsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemsCountRef = ProviderRef<int>;
String _$cartTotalPriceHash() => r'd8068573324a0f9432342f72888ee2880e70f3ea';

/// See also [cartTotalPrice].
@ProviderFor(cartTotalPrice)
final cartTotalPriceProvider = Provider<double>.internal(
  cartTotalPrice,
  name: r'cartTotalPriceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalPriceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalPriceRef = ProviderRef<double>;
String _$availableItemsQuantityHash() =>
    r'05f76332f4198a4fb7de0ed44aab4f563030e0b0';

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

/// See also [availableItemsQuantity].
@ProviderFor(availableItemsQuantity)
const availableItemsQuantityProvider = AvailableItemsQuantityFamily();

/// See also [availableItemsQuantity].
class AvailableItemsQuantityFamily extends Family<int> {
  /// See also [availableItemsQuantity].
  const AvailableItemsQuantityFamily();

  /// See also [availableItemsQuantity].
  AvailableItemsQuantityProvider call(
    Product product,
  ) {
    return AvailableItemsQuantityProvider(
      product,
    );
  }

  @override
  AvailableItemsQuantityProvider getProviderOverride(
    covariant AvailableItemsQuantityProvider provider,
  ) {
    return call(
      provider.product,
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
  String? get name => r'availableItemsQuantityProvider';
}

/// See also [availableItemsQuantity].
class AvailableItemsQuantityProvider extends AutoDisposeProvider<int> {
  /// See also [availableItemsQuantity].
  AvailableItemsQuantityProvider(
    Product product,
  ) : this._internal(
          (ref) => availableItemsQuantity(
            ref as AvailableItemsQuantityRef,
            product,
          ),
          from: availableItemsQuantityProvider,
          name: r'availableItemsQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$availableItemsQuantityHash,
          dependencies: AvailableItemsQuantityFamily._dependencies,
          allTransitiveDependencies:
              AvailableItemsQuantityFamily._allTransitiveDependencies,
          product: product,
        );

  AvailableItemsQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    int Function(AvailableItemsQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AvailableItemsQuantityProvider._internal(
        (ref) => create(ref as AvailableItemsQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _AvailableItemsQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AvailableItemsQuantityProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AvailableItemsQuantityRef on AutoDisposeProviderRef<int> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _AvailableItemsQuantityProviderElement
    extends AutoDisposeProviderElement<int> with AvailableItemsQuantityRef {
  _AvailableItemsQuantityProviderElement(super.provider);

  @override
  Product get product => (origin as AvailableItemsQuantityProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
