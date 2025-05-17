import '../domain/app_user.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  FakeAuthRepository({this.delay = true});
  final _authState = InMemoryStore<AppUser?>(null);

  final bool delay;

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delayed(delay);
    _authState.value = AppUser(uid: _createUserId(email), email: email);
  }

  Future<void> createUserEmailAndPassword(String email, String password) async {
    await delayed(delay);
    _authState.value = AppUser(uid: _createUserId(email), email: email);
  }

  void dispose() {
    // * Dispose the stream of the authState in-memory-store.
    _authState.close();
  }

  Future<void> signOut() async {
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
