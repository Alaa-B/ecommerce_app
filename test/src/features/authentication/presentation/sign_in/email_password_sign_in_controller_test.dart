// ignore: library_annotations
@Timeout(Duration(microseconds: 500))

import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });

  const email = 'test@test.com';
  const password = 'password';
  const formType = EmailPasswordSignInFormType.signIn;

  group('SignInSubmit', () {
    test('''
    Given formType is signIn
    When signInWithEmailAndPassword succeeds
    Then return true
    And state is AsyncData
    ''', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(() => authRepository.signInWithEmailAndPassword(
            email,
            password,
          )).thenAnswer((_) => Future.value());
      final container = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        emailPasswordSignInControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      // verify initial value from build method
      verify(() => listener(null, data));
      // run
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      final result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );
      // verify
      expect(result, true);
      verifyInOrder([
        // set loading state
        () => listener(data, any(that: isA<AsyncLoading>())),
        // data when complete
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
    });
    test('''
    Given formType is signIn
    When signInWithEmailAndPassword fails
    Then return false
    And state is AsyncError
    ''', () async {
      // setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Connection failed');
      when(() => authRepository.signInWithEmailAndPassword(
            email,
            password,
          )).thenThrow(exception);
      final container = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        emailPasswordSignInControllerProvider,
        listener.call,
        fireImmediately: true,
      );
      // verify initial value from build method
      verify(() => listener(null, const AsyncData<void>(null)));
      // run
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      final result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );
      // verify
      expect(result, false);
      verifyInOrder([
        // set loading state
        () => listener(
            const AsyncData<void>(null), any(that: isA<AsyncLoading>())),
        // error when complete
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
    });
  });
}
