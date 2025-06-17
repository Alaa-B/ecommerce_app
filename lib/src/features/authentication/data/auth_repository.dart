import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repository.g.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserEmailAndPassword(String email, String password);
  Future<void> signOut();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChangesStream(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
