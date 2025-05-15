import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/fake_auth_repository.dart';
import 'email_password_sign_in_state.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController(
      {required EmailPasswordSignInFormType formType,
      required this.fakeAuthRepository})
      : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository fakeAuthRepository;

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _authenticate(email, password));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _authenticate(String email, String password) async {
    if (state.formType == EmailPasswordSignInFormType.signIn) {
      return fakeAuthRepository.signInWithEmailAndPassword(email, password);
    } else {
      return fakeAuthRepository.createUserEmailAndPassword(email, password);
    }
  }

  void updateFormType(EmailPasswordSignInFormType formType) {
    state = state.copyWith(formType: formType);
  }
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>((ref, formType) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return EmailPasswordSignInController(
    formType: formType,
    fakeAuthRepository: fakeAuthRepository,
  );
});
