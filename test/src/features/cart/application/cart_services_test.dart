import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockLocalCartRepository localCartRepository;
  late MockRemoteCartRepository remoteCartRepository;
  setUpAll(() {
    registerFallbackValue(Cart());
  });
  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
  });

  CartServices makeCartService() {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      localCartRepositoryProvider.overrideWithValue(localCartRepository),
      remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
    ]);
    addTearDown(container.dispose);
    return container.read(cartServicesProvider);
  }

  group('SetCartIem', () {
    test('null user, set item in local dp', () async {
      final expectedCart = Cart({'147': 1});
      when(() => authRepository.currentUser).thenReturn(null);
      when(localCartRepository.fetchCart)
          .thenAnswer((_) => Future.value(Cart()));
      when(() => localCartRepository.setCart(expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();

      await cartServices.setItem(const Item(productId: '147', quantity: 1));

      verify(() => localCartRepository.setCart(expectedCart)).called(1);
      verifyNever(() => remoteCartRepository.setCart(any(), any()));
    });

    test("user isn't null, set item in remote dp'", () async {
      final expectedCart = Cart({'147': 1});
      when(() => authRepository.currentUser)
          .thenReturn(AppUser(uid: 'uid', email: 'test@test.com'));
      when(() => remoteCartRepository.fetchCart('uid'))
          .thenAnswer((_) => Future.value(Cart()));
      when(() => remoteCartRepository.setCart('uid', expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();

      await cartServices.setItem(const Item(productId: '147', quantity: 1));

      verify(() => remoteCartRepository.setCart('uid', expectedCart)).called(1);
      verifyNever(() => localCartRepository.setCart(any()));
    });
  });

  group('AddItem', () {
    test('null user, add item in local dp', () async {
      final initialCart = Cart({'147': 1});
      final expectedCart = Cart({'147': 2});
      when(() => authRepository.currentUser).thenReturn(null);
      when(localCartRepository.fetchCart)
          .thenAnswer((_) => Future.value(initialCart));
      when(() => localCartRepository.setCart(expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();
      await cartServices.addItem(const Item(productId: '147', quantity: 1));

      verify(() => localCartRepository.setCart(expectedCart)).called(1);
      verifyNever(() => remoteCartRepository.setCart(any(), any()));
    });
    test("user isn't null, add item in remote dp'", () async {
      final initialCart = Cart({'147': 1});
      final expectedCart = Cart({'147': 2});
      when(() => authRepository.currentUser)
          .thenReturn(AppUser(uid: 'uid', email: 'test@test.com'));
      when(() => remoteCartRepository.fetchCart('uid'))
          .thenAnswer((_) => Future.value(initialCart));
      when(() => remoteCartRepository.setCart('uid', expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();

      await cartServices.addItem(const Item(productId: '147', quantity: 1));

      verify(() => remoteCartRepository.setCart('uid', expectedCart)).called(1);
      verifyNever(() => localCartRepository.setCart(any()));
    });
  });
  group('RemoveItem', () {
    test('null user, remove item from local dp', () async {
      final initialCart = Cart({'147': 1, '123': 6});
      final expectedCart = Cart({'123': 6});
      when(() => authRepository.currentUser).thenReturn(null);
      when(localCartRepository.fetchCart)
          .thenAnswer((_) => Future.value(initialCart));
      when(() => localCartRepository.setCart(expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();
      await cartServices.removeItem('147');

      verify(() => localCartRepository.setCart(expectedCart)).called(1);
      verifyNever(() => remoteCartRepository.setCart(any(), any()));
    });
    test("user isn't null, remove item from remote dp'", () async {
      final initialCart = Cart({'147': 1, '123': 6});
      final expectedCart = Cart({'123': 6});
      when(() => authRepository.currentUser)
          .thenReturn(AppUser(uid: 'uid', email: 'test@test.com'));
      when(() => remoteCartRepository.fetchCart('uid'))
          .thenAnswer((_) => Future.value(initialCart));
      when(() => remoteCartRepository.setCart('uid', expectedCart))
          .thenAnswer(Future.value);
      final cartServices = makeCartService();

      await cartServices.removeItem('147');

      verify(() => remoteCartRepository.setCart('uid', expectedCart)).called(1);
      verifyNever(() => localCartRepository.setCart(any()));
    });
  });
}
