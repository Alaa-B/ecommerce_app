import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final email = 'test@test.com';
  final password = '165165416';
  late MockAuthRepository authRepo;
  setUp(() {
    authRepo = MockAuthRepository();
  });
  testWidgets('''
Given signIn formType
When tap signIn button
SignInWithEmailAndPassword are not called
''', (tester) async {
    final r = AuthRobot(tester);
    await r.pumpEmailPasswordSignInContent(
        authRepository: authRepo, formType: EmailPasswordSignInFormType.signIn);
    await r.tapSubmitButton();
    verifyNever(() => authRepo.signInWithEmailAndPassword(any(), any()));
  });
  testWidgets('''
Given signIn formType
When tap signIn button with valid email & password
SignInWithEmailAndPassword called
the callBack is called
''', (tester) async {
    bool didCallBack = false;
    final r = AuthRobot(tester);
    when(
      () => authRepo.signInWithEmailAndPassword(email, password),
    ).thenAnswer(Future.value);
    await r.pumpEmailPasswordSignInContent(
        authRepository: authRepo,
        formType: EmailPasswordSignInFormType.signIn,
        onSignedIn: () => didCallBack = true);
    await r.enterEmail(email);
    await r.enterPassword(password);
    await r.tapSubmitButton();
    verify(() => authRepo.signInWithEmailAndPassword(email, password))
        .called(1);
    r.expectErrorDialogNotFound();
    expect(didCallBack, true);
  });
}
