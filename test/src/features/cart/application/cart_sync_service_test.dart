import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_sync_service.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockLocalCartRepository localCartRepository;
  late MockRemoteCartRepository remoteCartRepository;
  late MockProductRepository productRepository;
  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
    productRepository = MockProductRepository();
  });
  CartSyncService makeCartSync() {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      localCartRepositoryProvider.overrideWithValue(localCartRepository),
      remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
      productsRepositoryProvider.overrideWithValue(productRepository),
    ]);
    addTearDown(container.dispose);
    return container.read(cartSyncServiceProvider);
  }

  group('cart sync service', () {
    Future<void> toggleCartSync({
      required Map<ProductID, int> localCart,
      required Map<ProductID, int> remoteCart,
      required Map<ProductID, int> expectedCart,
    }) async {
      const uid = 'asdfg';
      when(authRepository.authStateChanges).thenAnswer(
          (_) => Stream.value(AppUser(uid: uid, email: 'test@test.com')));
      when(productRepository.fetchProductsList)
          .thenAnswer((_) => Future.value(kTestProducts));
      when(localCartRepository.fetchCart)
          .thenAnswer((_) => Future.value(Cart(localCart)));
      when(() => remoteCartRepository.fetchCart(uid))
          .thenAnswer((_) => Future.value(Cart(remoteCart)));
      when(() => localCartRepository.setCart(const Cart()))
          .thenAnswer(Future.value);
      when(() => remoteCartRepository.setCart(uid, Cart(expectedCart)))
          .thenAnswer(Future.value);
      makeCartSync();
      await Future.delayed(Duration(microseconds: 50));
      verify(() => remoteCartRepository.setCart(uid, Cart(expectedCart)))
          .called(1);
      verify(() => localCartRepository.setCart(const Cart())).called(1);
    }

    test('local quantity <= available quantity', () async {
      await toggleCartSync(
        localCart: {'1': 1},
        remoteCart: {},
        expectedCart: {'1': 1},
      );
    });
    test('local quantity > available quantity', () async {
      await toggleCartSync(
        localCart: {'1': 15},
        remoteCart: {},
        expectedCart: {'1': 5},
      );
    });
    test('local + remote quantity <= available quantity', () async {
      await toggleCartSync(
        localCart: {'1': 1},
        remoteCart: {'1': 1},
        expectedCart: {'1': 2},
      );
    });

    test('local + remote quantity > available quantity', () async {
      await toggleCartSync(
        localCart: {'1': 3},
        remoteCart: {'1': 3},
        expectedCart: {'1': 5},
      );
    });

    test('multiple items', () async {
      await toggleCartSync(
        localCart: {'1': 3, '2': 1, '3': 2},
        remoteCart: {'1': 3},
        expectedCart: {'1': 5, '2': 1, '3': 2},
      );
    });
  });
}
