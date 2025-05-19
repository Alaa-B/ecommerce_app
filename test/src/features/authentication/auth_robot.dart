import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRobot {
  final WidgetTester tester;

  AuthRobot(this.tester);

  Future<void> tapSignInButton() async {
    final Finder signInButton = find.byKey(MoreMenuButton.signInKey);
    expect(signInButton, findsOneWidget);
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapAccountButton() async {
    final Finder accountButton = find.byKey(MoreMenuButton.accountKey);
    expect(accountButton, findsOneWidget);
    await tester.tap(accountButton);
    await tester.pumpAndSettle();
  }

  Future<void> pumpEmailPasswordSignInContent({
    required FakeAuthRepository authRepository,
    required EmailPasswordSignInFormType formType,
    VoidCallback? onSignedIn,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(authRepository)],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: formType,
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmitButton() async {
    final Finder signInPrimaryButton = find.byType(PrimaryButton);
    expect(signInPrimaryButton, findsOneWidget);
    await tester.tap(signInPrimaryButton);
    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final Finder emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
    await tester.pump();
  }

  Future<void> enterPassword(String password) async {
    final Finder passwordField =
        find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
    await tester.pump();
  }

  Future<void> pumpAccountScreen(
      {FakeAuthRepository? fakeAuthRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (fakeAuthRepository != null)
            authRepositoryProvider.overrideWithValue(
              fakeAuthRepository,
            )
        ],
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  void expectLogoutButton() {
    final Finder logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
  }

  Future<void> tapLogoutButton() async {
    final Finder logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();
  }

  void expectLogOutDialog() {
    final Finder logoutDialog = find.text('Are you sure?');
    expect(logoutDialog, findsOneWidget);
  }

  void expectLogOutDialogNotFound() {
    final Finder logoutDialog = find.text('Are you sure?');
    expect(logoutDialog, findsNothing);
  }

  Future<void> tapCancelButton() async {
    final Finder cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  Future<void> tapLogoutDialogButton() async {
    final Finder logoutButton = find.byKey(logOutButtonKey);
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();
  }

  void expectErrorDialog() {
    final Finder errorDialog = find.text('logout failed');
    expect(errorDialog, findsOneWidget);
  }

  void expectErrorDialogNotFound() {
    final Finder errorDialog = find.text('logout failed');
    expect(errorDialog, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final Finder circularProgressIndicator =
        find.byType(CircularProgressIndicator);
    expect(circularProgressIndicator, findsOneWidget);
  }
}
