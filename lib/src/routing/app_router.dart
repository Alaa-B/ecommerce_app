import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/data/fake_auth_repository.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import '../features/checkout/presentation/checkout_screen/checkout_screen.dart';
import '../features/orders/presentation/orders_list/orders_list_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/products/presentation/products_list/products_list_screen.dart';
import '../features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
part 'app_router.g.dart';

enum AppRoutes {
  home,
  cart,
  orders,
  account,
  signIn,
  productDetails,
  leaveReview,
  checkout,
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.uri.path == '/signIn') {
          return '/';
        }
      } else {
        if (state.uri.path == '/account' || state.uri.path == '/orders') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.home.name,
        builder: (context, state) => const ProductsListScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: AppRoutes.productDetails.name,
            builder: (context, state) {
              final productID = state.pathParameters['id']!;
              return ProductScreen(productId: productID);
            },
            routes: [
              GoRoute(
                path: 'review',
                name: AppRoutes.leaveReview.name,
                pageBuilder: (context, state) {
                  final productID = state.pathParameters['id']!;
                  return MaterialPage<void>(
                    fullscreenDialog: true,
                    child: LeaveReviewScreen(
                      productId: productID,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'cart',
            name: AppRoutes.cart.name,
            //* This is the default way to navigate to a new screen using GoRouter.
            // builder: (context, state) => const OrdersListScreen(),
            // * This is the custom way to navigate to a new screen using GoRouter.
            pageBuilder: (context, state) => MaterialPage<void>(
              fullscreenDialog: true,
              child: const ShoppingCartScreen(),
            ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoutes.checkout.name,
                pageBuilder: (context, state) => MaterialPage<void>(
                  fullscreenDialog: true,
                  child: const CheckoutScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'orders',
            name: AppRoutes.orders.name,
            pageBuilder: (context, state) => MaterialPage<void>(
                fullscreenDialog: true, child: const OrdersListScreen()),
          ),
          GoRoute(
            path: 'account',
            name: AppRoutes.account.name,
            pageBuilder: (context, state) => MaterialPage<void>(
              fullscreenDialog: true,
              child: const AccountScreen(),
            ),
          ),
          GoRoute(
            path: 'signIn',
            name: AppRoutes.signIn.name,
            pageBuilder: (context, state) => MaterialPage<void>(
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
