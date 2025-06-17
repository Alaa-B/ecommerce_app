import 'dart:async';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/application/review_services.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/current_date_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'leave_review_controller.g.dart';

@riverpod
class LeaveReviewController extends _$LeaveReviewController {
  bool mounted = true;
  @override
  FutureOr build() {
    ref.onDispose(() {
      mounted = false;
    });
  }

  Future<void> submitReview({
    Review? previousReview,
    required ProductID productId,
    required String comment,
    required double rating,
    required void Function() onSuccess,
  }) async {
    final currentDate = ref.read(currentDateProvider);
    state = const AsyncLoading();
    final review = Review(
      score: rating,
      comment: comment,
      date: currentDate(),
    );
    //* Not storing the same review if it's equal to the previous one
    //* For Optimization
    if (previousReview == null ||
        review.score != previousReview.score ||
        review.comment != previousReview.comment) {
      final newState = await AsyncValue.guard(() =>
          ref.watch(reviewsServiceProvider).submitReview(productId, review));
      if (mounted) {
        state = newState;
        if (state.hasError == false) {
          onSuccess();
        }
      }
    } else {
      onSuccess();
    }
  }
}
