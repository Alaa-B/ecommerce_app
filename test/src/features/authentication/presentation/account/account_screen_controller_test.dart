// ignore: library_annotations
@Timeout(Duration(microseconds: 500))

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late FakeAuthRepository authRepo;
  late AccountScreenController controller;
  setUp(() {
    authRepo = MockAuthRepository();
    controller = AccountScreenController(fakeAuthRepository: authRepo);
  });
  group('AccountScreenController', () {
    test(
      'init state is AsyncData',
      () {
        verifyNever(authRepo.signOut);
        expect(controller.state, AsyncData<void>(null));
      },
    );
    test(
      'signOut success',
      () async {
        when(authRepo.signOut).thenAnswer((_) => Future.value());
        expectLater(
            controller.stream,
            emitsInOrder(const [
              AsyncLoading<void>(),
              AsyncData<void>(null),
            ]));
        await controller.signOut();
        verify(authRepo.signOut).called(1);
      },
    );
    test(
      'signOut failure',
      () async {
        when(authRepo.signOut).thenAnswer((_) => Future.error(Exception));
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              isA<AsyncError<void>>(),
            ]));
        await controller.signOut();
        verify(authRepo.signOut).called(1);
      },
    );
  });
}
