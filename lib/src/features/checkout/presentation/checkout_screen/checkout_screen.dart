import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_form_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../payment/payment_page.dart';
import '../../../../localization/string_hardcoded.dart';

/// The two sub-routes that are presented as part of the checkout flow.
/// TODO: add the address page as well (see [AddressScreen]).
enum CheckoutSubRoute { register, payment }

/// This is the root widget of the checkout flow, which is composed of 2 pages:
/// 1. Register page
/// 2. Payment page
/// The correct page is displayed (and updated) based on whether the user is
/// signed in.
/// The logic for the entire flow is implemented in the
/// [CheckoutScreenController], while UI updates are handled by a
/// [PageController].
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late final PageController _controller;

  var _subRoute = CheckoutSubRoute.register;

  @override
  void initState() {
    super.initState();
    final userState = ref.read(authRepositoryProvider).currentUser;
    if (userState != null) {
      setState(() {
        _subRoute = CheckoutSubRoute.payment;
      });
    }
    _controller = PageController(initialPage: _subRoute.index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSignedIn() {
    setState(() => _subRoute = CheckoutSubRoute.payment);
    // perform a nice scroll animation to reveal the next page
    _controller.animateToPage(
      _subRoute.index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // map subRoute to address
    final title = _subRoute == CheckoutSubRoute.register
        ? 'Register'.hardcoded
        : 'Payment'.hardcoded;
    // * Return a Scaffold with a PageView containing the 2 pages.
    // * This allows for a nice scroll animation when switching between pages.
    // * Note: only the currently active page will be visible.
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PageView(
        // * disable swiping between pages
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          EmailPasswordSignInContents(
            formType: EmailPasswordSignInFormType.register,
            onSignedIn: _onSignedIn,
          ),
          const PaymentPage()
        ],
      ),
    );
  }
}
