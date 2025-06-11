import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

class MockLocalCartRepository extends Mock implements LocalCartRepository {}

class MockRemoteCartRepository extends Mock
    implements FakeRemoteCartRepository {}

class MockProductRepository extends Mock implements FakeProductsRepository {}

class MockCartServicesRepository extends Mock implements CartServices {}

class MockOrdersRepository extends Mock implements FakeOrdersRepository {}

class MockCheckoutService extends Mock implements FakeCheckoutService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
