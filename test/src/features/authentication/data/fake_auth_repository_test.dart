import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String email = 'test@test.com';
  const String password = '123456789';
  final String uId = email.split('').reversed.join();
  final appUser = AppUser(uid: uId, email: email);
  group('Fake Auth Repository', () {
    final fakeAuthRepository = FakeAuthRepository(delay: false);
    test('fake auth repository return null', () {
      final authRepo = fakeAuthRepository;
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });
    test('sign in with email & password return appUser', () async {
      final authRepo = fakeAuthRepository;
      await authRepo.signInWithEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
    });
    test('create account with email & password return appUser', () async {
      final authRepo = fakeAuthRepository;
      await authRepo.createUserEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
    });
    test('sign out return null appUser', () async {
      final authRepo = fakeAuthRepository;
      await authRepo.createUserEmailAndPassword(email, password);
      expect(authRepo.currentUser, appUser);
      expect(authRepo.authStateChanges(), emits(appUser));
      await authRepo.signOut();
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });
    test('return error after dispose', () async {
      final authRepo = fakeAuthRepository;
      authRepo.dispose();
      expect(() async {
        await authRepo.createUserEmailAndPassword(email, password);
      }, throwsStateError);
    });
  });
}
