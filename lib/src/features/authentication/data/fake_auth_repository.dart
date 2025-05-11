import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // *! Simulate a network error
    // throw Exception('Connection failed');
    if (currentUser == null) {
      _authState.value = AppUser(uid: _createUserId(email), email: email);
    }
  }

  Future<void> createUserEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _authState.value = AppUser(uid: _createUserId(email), email: email);
    }
  }

  void dispose() {
    // * Dispose the stream of the authState in-memory-store.
    _authState.close();
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 1));
    // *! Simulate a network error
    // throw Exception('Error signing out');
    _authState.value = null;
  }

  String _createUserId(String value) {
    return value.split('').reversed.join();
  }
}

final authRepositoryProvider = Provider.autoDispose<FakeAuthRepository>((ref) {
  final fakeAuthRepo = FakeAuthRepository();
  ref.onDispose(() => fakeAuthRepo.dispose());
  return fakeAuthRepo;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
