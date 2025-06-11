import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/data/fake_review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fake_review_service.g.dart';

class FakeReviewService {
  FakeReviewService({
    required this.fakeProductsRepository,
    required this.authRepository,
    required this.reviewsRepository,
  });
  final FakeProductsRepository fakeProductsRepository;
  final FakeAuthRepository authRepository;
  final FakeReviewRepository reviewsRepository;

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

@riverpod
FakeReviewService reviewsService(Ref ref) {
  return FakeReviewService(
    fakeProductsRepository: ref.watch(productsRepositoryProvider),
    authRepository: ref.watch(authRepositoryProvider),
    reviewsRepository: ref.watch(fakeReviewRepositoryProvider),
  );
}

@riverpod
Stream<Review?> watchUserReviews(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(fakeReviewRepositoryProvider)
        .watchUserReview(productId, user.uid);
  } else {
    return Stream.value(null);
  }
}

@riverpod
Future<Review?> fetchUserReviews(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(fakeReviewRepositoryProvider)
        .fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
}
