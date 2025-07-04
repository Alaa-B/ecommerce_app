import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_rating_bar.dart';
import '../../../../constants/app_sizes.dart';
import '../../domain/review.dart';
import '../../../../utils/date_formatter.dart';

/// Simple card widget to show a product review info (score, comment, date)
class ProductReviewCard extends ConsumerWidget {
  const ProductReviewCard(this.review, {super.key});
  final Review review;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatted = ref.watch(dateFormatterProvider).format(review.date);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductRatingBar(
                  initialRating: review.score,
                  ignoreGestures: true,
                  itemSize: 20,
                  onRatingUpdate: (value) {},
                ),
                Text(dateFormatted,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            if (review.comment.isNotEmpty) ...[
              gapH16,
              Text(
                review.comment,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ],
        ),
      ),
    );
  }
}
