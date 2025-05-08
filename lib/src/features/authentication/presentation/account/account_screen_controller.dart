import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.fakeAuthRepository})
      : super(const AsyncValue<void>.data(null));

  final FakeAuthRepository fakeAuthRepository;
  FutureOr<void> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await fakeAuthRepository.signOut();
      state = const AsyncValue<void>.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue<void>.error(error, stackTrace);
    }
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(fakeAuthRepository: fakeAuthRepository);
});
