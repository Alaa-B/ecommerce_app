import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'review_repository.g.dart';

abstract class ReviewRepository {
  Stream<Review?> watchUserReview(ProductID productId, String uId);
  Future<Review?> fetchUserReview(ProductID productId, String uId);
  Stream<List<Review>> watchProductReviews(ProductID productId);
  Future<List<Review>> fetchProductReviews(ProductID productId);
  Future<void> setReview({
    required ProductID productId,
    required String uId,
    required Review review,
  });
}

@riverpod
ReviewRepository reviewRepository(Ref ref) {
  throw UnimplementedError();
}

@riverpod
Stream<List<Review>> productReviewStream(Ref ref, ProductID productId) {
  return ref.watch(reviewRepositoryProvider).watchProductReviews(productId);
}
