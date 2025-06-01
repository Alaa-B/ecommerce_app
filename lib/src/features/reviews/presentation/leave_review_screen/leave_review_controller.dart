import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/application/review_service.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/current_date_provider.dart';
import 'package:riverpod/riverpod.dart';

class LeaveReviewController extends StateNotifier<AsyncValue<void>> {
  LeaveReviewController({
    required this.reviewService,
    required this.buildDateTime,
  }) : super(AsyncData(null));

  final ReviewService reviewService;
  final DateTime Function() buildDateTime;

  Future<void> submitReview({
    Review? previousReview,
    required ProductID productId,
    required String comment,
    required double rating,
    required void Function() onSuccess,
  }) async {
    state = const AsyncLoading();
    final review = Review(
      score: rating,
      comment: comment,
      date: buildDateTime(),
    );
    //* Not storing the same review if it's equal to the previous one
    //* For Optimization
    if (previousReview == null ||
        review.score != previousReview.score ||
        review.comment != previousReview.comment) {
      final newState = await AsyncValue.guard(
          () => reviewService.submitReview(productId, review));
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

final leaveReviewControllerProvider =
    StateNotifierProvider.autoDispose<LeaveReviewController, AsyncValue<void>>(
        (ref) {
  final reviewService = ref.watch(reviewServiceProvider);
  final buildDateTime = ref.watch(currentDateProvider);
  return LeaveReviewController(
      reviewService: reviewService, buildDateTime: buildDateTime);
});
