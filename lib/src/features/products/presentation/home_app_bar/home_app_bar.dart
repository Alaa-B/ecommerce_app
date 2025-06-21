import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';

import '../../../../constants/breakpoints.dart';
import 'more_menu_button.dart';
import 'shopping_cart_icon.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../routing/app_router.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/action_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesStreamProvider).value;
    final isAdminUser = user != null;

    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text('FeastNow'.hardcoded),
        actions: [
          ShoppingCartIcon(),
          const ShoppingCartIcon(),
          MoreMenuButton(user: user, isAdministrator: isAdminUser),
        ],
      );
    } else {
      return AppBar(
        title: Text('FeastNow'.hardcoded),
        actions: [
          const ShoppingCartIcon(),
          // ignore: unnecessary_null_comparison
          if (user != null) ...[
            ActionTextButton(
              key: MoreMenuButton.ordersKey,
              text: 'Orders'.hardcoded,
              onPressed: () => context.goNamed(AppRoutes.orders.name),
            ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: 'Account'.hardcoded,
              onPressed: () => context.goNamed(AppRoutes.account.name),
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context.goNamed(AppRoutes.signIn.name),
            ),
          if (isAdminUser)
            ActionTextButton(
              key: MoreMenuButton.adminKey,
              text: 'Admin'.hardcoded,
              onPressed: () => context.pushNamed(AppRoutes.admin.name),
            ),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
