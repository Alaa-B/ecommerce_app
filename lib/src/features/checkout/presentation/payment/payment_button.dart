import 'package:ecommerce_app/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../common_widgets/primary_button.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      paymentButtonControllerProvider,
      (_, next) => next.showAlertDialogOnError(context),
    );
    final state = ref.watch(paymentButtonControllerProvider);
    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed: () => state.isLoading
          ? null
          : ref.read(paymentButtonControllerProvider.notifier).pay(),
    );
  }
}
