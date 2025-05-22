import 'dart:async';
import '../../data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.fakeAuthRepository})
      : super(const AsyncData(null));

  final FakeAuthRepository fakeAuthRepository;

  FutureOr<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fakeAuthRepository.signOut());
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(fakeAuthRepository: fakeAuthRepository);
});
