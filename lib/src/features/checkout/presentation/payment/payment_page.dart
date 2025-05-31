import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../cart/presentation/shopping_cart/shopping_cart_item.dart';
import '../../../cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'payment_button.dart';

/// Payment screen showing the items in the cart (with read-only quantities) and
/// a button to checkout.
class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(cartItemsCountProvider, (_, next) {
      if (next == 0) context.goNamed(AppRoutes.orders.name);
    });
    final cartItems = ref.watch(cartServicesStreamProvider);
    return AsyncValueWidget<Cart>(
      value: cartItems,
      data: (cart) => ShoppingCartItemsBuilder(
        items: cart.toItemsList(),
        itemBuilder: (_, item, index) => ShoppingCartItem(
          item: item,
          itemIndex: index,
          isEditable: false,
        ),
        ctaBuilder: (_) => const PaymentButton(),
      ),
    );
  }
}
