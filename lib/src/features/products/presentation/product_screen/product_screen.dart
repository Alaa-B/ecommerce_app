import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';

import '../../../cart/presentation/add_to_cart/add_to_cart_widget.dart';
import '../home_app_bar/home_app_bar.dart';
import 'leave_review_action.dart';
import 'product_average_rating.dart';
import '../../../reviews/presentation/product_reviews/product_reviews_list.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../common_widgets/empty_placeholder_widget.dart';
import '../../../../utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import '../../../../common_widgets/custom_image.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../common_widgets/responsive_two_column_layout.dart';
import '../../../../constants/app_sizes.dart';
import '../../domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shows the product page for a given product ID.
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      // ignore: unnecessary_null_comparison
      body: Consumer(
        builder: (context, ref, _) {
          final product = ref.watch(productStreamByIdProvider(productId));
          return AsyncValueWidget<Product?>(
            value: product,
            data: (product) => product == null
                ? EmptyPlaceholderWidget(
                    message: 'Product not found'.hardcoded,
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: ProductDetails(product: product),
                      ),
                      ProductReviewsList(productId: productId),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends ConsumerWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted =
        ref.watch(currencyFormatterProvider).format(product.price);
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: product.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title,
                  style: Theme.of(context).textTheme.titleLarge),
              gapH8,
              Text(product.description),
              // Only show average if there is at least one rating
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH8,
              const Divider(),
              gapH8,
              Text(priceFormatted,
                  style: Theme.of(context).textTheme.headlineSmall),
              gapH8,
              LeaveReviewAction(productId: product.id),
              const Divider(),
              gapH8,
              AddToCartWidget(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
