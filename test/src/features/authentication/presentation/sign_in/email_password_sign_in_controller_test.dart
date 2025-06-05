// ignore: library_annotations
@Timeout(Duration(microseconds: 500))

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
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
      final authRepo = MockAuthRepository();
      when(
        () => authRepo.signInWithEmailAndPassword(email, password),
      ).thenAnswer((_) => Future.value());
      final container = makeProviderContainer(authRepo);
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      expectLater(
          controller.stream,
          emitsInOrder([
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]));
      final result = await controller.submit(
          email: email, password: password, formType: formType);
      verify(
        () => authRepo.signInWithEmailAndPassword(email, password),
      ).called(1);
      expect(result, true);
    });
    test('''
    Given formType is signIn
    When signInWithEmailAndPassword fails
    Then return false
    And state is AsyncError
    ''', () async {
      final authRepo = MockAuthRepository();
      when(
        () => authRepo.signInWithEmailAndPassword(email, password),
      ).thenThrow(Exception('signIn failed'));
      final container = makeProviderContainer(authRepo);
      final controller =
          container.read(emailPasswordSignInControllerProvider.notifier);
      expectLater(
          controller.stream,
          emitsInOrder([
            AsyncLoading<void>(),
            predicate<AsyncValue<void>>((state) {
              expect(state.hasError, true);
              return true;
            }),
          ]));
      final result = await controller.submit(
          email: email, password: password, formType: formType);

      expect(result, false);
    });
  });
}
