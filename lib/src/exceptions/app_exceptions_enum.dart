import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

enum AppExceptionEnum {
  // Auth
  emailAlreadyInUse('email-already-in-use'),
  weakPassword('weak-password'),
  wrongPassword('wrong-password'),
  userNotFound('user-not-found'),
  // Cart
  cartSyncFailed('cart-sync-failed'),
  // Checkout
  paymentFailureEmptyCart('payment-failure-empty-cart'),
  // Orders
  parseOrderFailure('parse-order-failure');

  const AppExceptionEnum(this.code);

  final String code;

  String get message {
    return switch (this) {
      emailAlreadyInUse => 'Email already in use'.hardcoded,
      weakPassword => 'Password is too weak'.hardcoded,
      wrongPassword => 'Wrong password'.hardcoded,
      userNotFound => 'User not found'.hardcoded,
      // Cart
      cartSyncFailed =>
        'An error has occurred while updating the shopping cart'.hardcoded,
      // Checkout
      paymentFailureEmptyCart =>
        'Can\'t place an order if the cart is empty'.hardcoded,
      // Orders
      parseOrderFailure => 'Could not parse order status'.hardcoded,
    };
  }
}
