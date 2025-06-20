import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets('cancel logout', (tester) async {
    final r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    when(authRepository.signOut).thenAnswer(
      (_) => Future.value(),
    );
    when(authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(
        const AppUser(uid: '123', email: 'test@test.com'),
      ),
    );
    await r.pumpAccountScreen(fakeAuthRepository: authRepository);
    r.expectLogoutButton();
    await r.tapLogoutButton();
    r.expectLogOutDialog();
    await r.tapCancelButton();
    r.expectLogOutDialogNotFound();
  });
  testWidgets('confirm logout,success', (tester) async {
    final r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    when(authRepository.signOut).thenAnswer(
      (_) => Future.value(),
    );
    when(authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(
        const AppUser(uid: '123', email: 'test@test.com'),
      ),
    );
    await r.pumpAccountScreen(fakeAuthRepository: authRepository);
    await r.tapLogoutButton();
    r.expectLogOutDialog();
    await r.tapLogoutDialogButton();
    r.expectLogOutDialogNotFound();
    r.expectErrorDialogNotFound();
  });
  testWidgets('confirm logout,failure', (tester) async {
    final r = AuthRobot(tester);
    final authRepo = MockAuthRepository();
    when(authRepo.signOut).thenThrow(Exception('Connection Failed'));
    when(authRepo.authStateChanges).thenAnswer(
      (_) => Stream.value(
        AppUser(uid: '132154654', email: 'test@test.com'),
      ),
    );
    await r.pumpAccountScreen(fakeAuthRepository: authRepo);
    await r.tapLogoutButton();
    r.expectLogOutDialog();
    await r.tapLogoutDialogButton();
    r.expectErrorDialog();
  });
  testWidgets('confirm logout,Loading', (tester) async {
    final r = AuthRobot(tester);
    final authRepo = MockAuthRepository();
    when(authRepo.authStateChanges).thenAnswer(
      (_) => Stream.value(
        AppUser(uid: '125161', email: 'test@test.com'),
      ),
    );
    when(authRepo.signOut)
        .thenAnswer((_) => Future.delayed(Duration(seconds: 2)));
    await r.pumpAccountScreen(fakeAuthRepository: authRepo);
    await tester.runAsync(() async {
      await r.tapLogoutButton();
      r.expectLogOutDialog();
      await r.tapLogoutDialogButton();
      r.expectCircularProgressIndicator();
    });
  });
}
