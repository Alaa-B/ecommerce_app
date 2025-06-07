import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/fake_auth_repository.dart';
part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {}
  FutureOr<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signOut());
  }
}
