import 'dart:async';

import '../../data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.fakeAuthRepository})
      : super(const AsyncData(null));

  final FakeAuthRepository fakeAuthRepository;
  FutureOr<void> signOut() async {
    // * This is the old way of doing it. It was changed to use AsyncValue.guard.
    // try {
    //   state = const AsyncValue<void>.loading();
    //   await fakeAuthRepository.signOut();
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (error, stackTrace) {
    //   state = AsyncValue<void>.error(error, stackTrace);
    //   return false;
    // }
    // * This is the new way of doing it. It uses AsyncValue.guard.
    // * It handles the loading and error states.
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fakeAuthRepository.signOut());
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(fakeAuthRepository: fakeAuthRepository);
});
