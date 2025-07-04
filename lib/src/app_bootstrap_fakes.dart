import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/checkout/application/checkout_services.dart';
import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/data/orders_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/reviews/application/fake_review_service.dart';
import 'package:ecommerce_app/src/features/reviews/application/review_services.dart';
import 'package:ecommerce_app/src/features/reviews/data/fake_review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/data/review_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/src/exceptions/async_error_logger.dart';
import 'package:ecommerce_app/src/features/cart/data/local/fake_local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';

Future<ProviderContainer> createFakesProviderContainer(
    {bool addDelay = true}) async {
  final authRepository = FakeAuthRepository(delay: addDelay);
  final productsRepository = FakeProductsRepository(addDelay: addDelay);
  final reviewsRepository = FakeReviewRepository(addDelay: addDelay);
  // * set delay to false to make it easier to add/remove items
  final localCartRepository = FakeLocalCartRepository(addDelay: false);
  final remoteCartRepository = FakeRemoteCartRepository(addDelay: false);
  final ordersRepository = FakeOrdersRepository(delay: addDelay);

  // services
  final checkoutService = FakeCheckoutService(
    authRepository: authRepository,
    remoteCartRepository: remoteCartRepository,
    ordersRepository: ordersRepository,
    productsRepository: productsRepository,
    currentDate: () => DateTime.now(),
  );
  final reviewsService = FakeReviewService(
    fakeProductsRepository: productsRepository,
    authRepository: authRepository,
    reviewsRepository: reviewsRepository,
  );

  return ProviderContainer(
    overrides: [
      // repositories
      authRepositoryProvider.overrideWithValue(authRepository),
      productsRepositoryProvider.overrideWithValue(productsRepository),
      reviewRepositoryProvider.overrideWithValue(reviewsRepository),
      ordersRepositoryProvider.overrideWithValue(ordersRepository),
      localCartRepositoryProvider.overrideWithValue(localCartRepository),
      remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
      // services
      checkoutServiceProvider.overrideWithValue(checkoutService),
      reviewsServiceProvider.overrideWithValue(reviewsService),
    ],
    observers: [AsyncErrorLogger()],
  );
}
