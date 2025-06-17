import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/application/review_services.dart';
import 'package:ecommerce_app/src/features/reviews/data/fake_review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

class FakeReviewService implements ReviewServices {
  FakeReviewService({
    required this.fakeProductsRepository,
    required this.authRepository,
    required this.reviewsRepository,
  });
  final FakeProductsRepository fakeProductsRepository;
  final FakeAuthRepository authRepository;
  final FakeReviewRepository reviewsRepository;

  @override
  Future<void> submitReview(
    ProductID productId,
    Review review,
  ) async {
    final user = authRepository.currentUser;
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t submit a review if the user is not signed in'.hardcoded);
    }
    await reviewsRepository.setReview(
      productId: productId,
      uId: user.uid,
      review: review,
    );
    _updateAvgReviewsRating(productId);
  }

  Future<void> _updateAvgReviewsRating(ProductID productId) async {
    final reviews = await reviewsRepository.fetchProductReviews(productId);
    final avgRating = _avgReviewRating(reviews);
    final product = fakeProductsRepository.getProductById(productId);
    if (product == null) {
      throw StateError("this product isn't found $productId".hardcoded);
    }
    final updatedProduct = product.copyWith(
      avgRating: avgRating,
      numRatings: reviews.length,
    );
    await fakeProductsRepository.setProduct(updatedProduct);
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
