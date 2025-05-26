import 'package:ecommerce_app/src/features/cart/application/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/currency_formatter.dart';

/// Text widget for showing the total price of the cart
class CartTotalText extends ConsumerWidget {
  const CartTotalText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Inject formatter
    final cartTotal = ref.watch(cartTotalProvider);
    final totalFormatted = kCurrencyFormatter.format(cartTotal);
    return Text(
      'Total: $totalFormatted',
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}
