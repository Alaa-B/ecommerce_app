import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_app/src/features/orders/presentation/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/product_screen.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import 'package:ecommerce_app/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
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
                  key: state.pageKey,
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
            key: state.pageKey,
            child: const ShoppingCartScreen(),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              name: AppRoutes.checkout.name,
              pageBuilder: (context, state) => MaterialPage<void>(
                fullscreenDialog: true,
                key: state.pageKey,
                child: const CheckoutScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'orders',
          name: AppRoutes.orders.name,
          pageBuilder: (context, state) => MaterialPage<void>(
              fullscreenDialog: true,
              key: state.pageKey,
              child: const OrdersListScreen()),
        ),
        GoRoute(
          path: 'account',
          name: AppRoutes.account.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            fullscreenDialog: true,
            key: state.pageKey,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoutes.signIn.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            fullscreenDialog: true,
            key: state.pageKey,
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
