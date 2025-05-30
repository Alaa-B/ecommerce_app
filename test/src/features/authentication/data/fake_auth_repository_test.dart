import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/fake_app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String email = 'test@test.com';
  const String password = '123456789';
  final String uId = email.split('').reversed.join();
  final appUser = FakeAppUser(uid: uId, email: email, password: password);

  FakeAuthRepository fakeAuthRepository() => FakeAuthRepository(delay: false);
  group('Fake Auth Repository', () {
    test('fake auth repository return null', () {
      final authRepo = fakeAuthRepository();
      addTearDown(authRepo.dispose);
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });
    test('sign in with email & password return appUser', () async {
      final authRepo = fakeAuthRepository();
      addTearDown(authRepo.dispose);
      await authRepo.createUserEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
    });
    test('create account with email & password return appUser', () async {
      final authRepo = fakeAuthRepository();
      addTearDown(authRepo.dispose);
      await authRepo.createUserEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
    });
    test('sign out return null appUser', () async {
      final authRepo = fakeAuthRepository();
      addTearDown(authRepo.dispose);
      await authRepo.createUserEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
      await authRepo.signOut();
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });
    test('return error after dispose', () async {
      final authRepo = fakeAuthRepository();
      addTearDown(authRepo.dispose);
      authRepo.dispose();
      expect(() async {
        await authRepo.createUserEmailAndPassword(email, password);
      }, throwsStateError);
    });
  });
}
