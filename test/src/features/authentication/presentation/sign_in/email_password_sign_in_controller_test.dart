// ignore: library_annotations
@Timeout(Duration(microseconds: 500))

import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  final email = 'test@test.com';
  final password = 'password';

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
      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.signIn,
        fakeAuthRepository: authRepo,
      );
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: AsyncLoading<void>()),
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: AsyncData<void>(null)),
          ]));
      final result = await controller.submit(email, password);
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
      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.signIn,
        fakeAuthRepository: authRepo,
      );
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: AsyncLoading<void>()),
            predicate<EmailPasswordSignInState>((state) {
              expect(state.formType, EmailPasswordSignInFormType.signIn);
              expect(state.value.hasError, true);
              return true;
            }),
          ]));
      final result = await controller.submit(email, password);
      verify(
        () => authRepo.signInWithEmailAndPassword(email, password),
      ).called(1);
      expect(result, false);
    });
    test('''
    Given formType is register
    When createUserWithEmailAndPassword succeeds
    Then return true
    And state is AsyncData
    ''', () async {
      final authRepo = MockAuthRepository();
      when(
        () => authRepo.createUserEmailAndPassword(email, password),
      ).thenAnswer((_) => Future.value());
      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.register,
        fakeAuthRepository: authRepo,
      );
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: AsyncLoading<void>()),
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: AsyncData<void>(null)),
          ]));
      final result = await controller.submit(email, password);
      verify(
        () => authRepo.createUserEmailAndPassword(email, password),
      ).called(1);
      expect(result, true);
    });
    test('''
    Given formType is register
    When createUserWithEmailAndPassword fails
    Then return false
    And state is AsyncError
    ''', () async {
      final authRepo = MockAuthRepository();
      when(
        () => authRepo.createUserEmailAndPassword(email, password),
      ).thenThrow(Exception('register failed'));
      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.register,
        fakeAuthRepository: authRepo,
      );
      expectLater(
          controller.stream,
          emitsInOrder([
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: AsyncLoading<void>()),
            predicate<EmailPasswordSignInState>((state) {
              expect(state.formType, EmailPasswordSignInFormType.register);
              expect(state.value.hasError, true);
              return true;
            }),
          ]));
      final result = await controller.submit(email, password);
      verify(
        () => authRepo.createUserEmailAndPassword(email, password),
      ).called(1);
      expect(result, false);
    });
  });
  group('toggleFormType', () {
    test('''
Given formType is signIn
When updateFormType is called with register
Then formType is register
''', () {
      final authRepo = MockAuthRepository();
      final controller = EmailPasswordSignInController(
          formType: EmailPasswordSignInFormType.signIn,
          fakeAuthRepository: authRepo);
      controller.updateFormType(EmailPasswordSignInFormType.register);
      expect(
          controller.state,
          EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncData<void>(null)));
    });
  });
}
