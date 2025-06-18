import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/fake_app_user.dart';
import '../domain/app_user.dart';
import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.delay = true});
  final _authState = InMemoryStore<AppUser?>(null);

  final bool delay;

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
  @override
  AppUser? get currentUser => _authState.value;

  final List<FakeAppUser> _users = [];

  @override
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

  @override
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
      uid: _createUserId(email),
      email: email,
      password: password,
    );
    _users.add(user);
    _authState.value = user;
  }

  void dispose() {
    // * Dispose the stream of the authState in-memory-store.
    _authState.close();
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  String _createUserId(String value) {
    return value.split('').reversed.join();
  }
}
