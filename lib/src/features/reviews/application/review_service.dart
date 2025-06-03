import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/data/fake_review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewService {
  final Ref ref;

  ReviewService({required this.ref});
  Future<void> submitReview(
    ProductID productId,
    Review review,
  ) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t submit a review if the user is not signed in'.hardcoded);
    }
    await ref.read(fakeReviewRepositoryProvider).setReview(
          productId: productId,
          uId: user.uid,
          review: review,
        );
    _updateAvgReviewsRating(productId);
  }

  Future<void> _updateAvgReviewsRating(ProductID productId) async {
    final reviews = await ref
        .read(fakeReviewRepositoryProvider)
        .fetchProductReviews(productId);
    final avgRating = _avgReviewRating(reviews);
    final product =
        ref.read(productsRepositoryProvider).getProductById(productId);
    if (product == null) {
      throw StateError("this product isn't found $productId".hardcoded);
    }
    final updatedProduct = product.copyWith(
      avgRating: avgRating,
      numRatings: reviews.length,
    );
    await ref.read(productsRepositoryProvider).setProduct(updatedProduct);
  }

  double _avgReviewRating(List<Review> reviews) {
    if (reviews.isNotEmpty) {
      double total = 0.0;
      for (var review in reviews) {
        total += review.score;
      }
      final avgRating = total / reviews.length;
      return avgRating;
    } else {
      return 0.0;
    }
  }
}

final reviewServiceProvider = Provider<ReviewService>((ref) {
  return ReviewService(ref: ref);
});

final watchUserReviewsProvider =
    StreamProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(fakeReviewRepositoryProvider)
        .watchUserReview(productId, user.uid);
  } else {
    return Stream.value(null);
  }
});

final fetchUserReviewsProvider =
    FutureProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(fakeReviewRepositoryProvider)
        .fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
});
