import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/domain/fake_app_user.dart';
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

  final List<FakeAppUser> _users = [];

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delayed(delay);
    for (var u in _users) {
      if (u.email == email && u.password == password) {
        _authState.value = u;
        return;
      }
      if (u.email == email && u.password != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  Future<void> createUserEmailAndPassword(String email, String password) async {
    await delayed(delay);
    for (final u in _users) {
      if (u.email == email) {
        throw EmailAlreadyInUseException();
      }
    }
    if (password.length < 8) {
      throw WeakPasswordException();
    }
    _createNewUser(email, password);
  }

  void _createNewUser(String email, String password) {
    final user = FakeAppUser(
        uid: _createUserId(email), email: email, password: password);
    _users.add(user);
    _authState.value = user;
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

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final fakeAuthRepo = FakeAuthRepository();
  ref.onDispose(fakeAuthRepo.dispose);
  return fakeAuthRepo;
});

final authStateChangesStreamProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
