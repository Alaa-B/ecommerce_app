import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRobot {
  final WidgetTester tester;

  AuthRobot(this.tester);

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
    await tester.pump();
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
    await tester.pump();
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
