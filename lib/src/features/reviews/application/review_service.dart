import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
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
