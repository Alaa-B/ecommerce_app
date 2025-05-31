import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeReviewRepository {
  FakeReviewRepository({this.addDelay = true});
  final bool addDelay;
  final _reviews = InMemoryStore<Map<ProductID, Map<String, Review>>>({});

  Stream<Review?> watchUserReview(String productId, String uId) {
    return _reviews.stream.map((value) {
      return value[productId]?[uId];
    });
  }

  Future<Review?> fetchUserReview(String productId, String uId) async {
    await delayed(addDelay);
    return Future.value(_reviews.value[productId]?[uId]);
  }

  Stream<List<Review>> watchProductReviews(String productId) {
    return _reviews.stream.map((value) {
      final reviews = value[productId];
      if (reviews != null) {
        return reviews.values.toList();
      } else {
        return [];
      }
    });
  }

  Future<List<Review>> fetchProductReviews(String productId) {
    final reviews = _reviews.value[productId];
    if (reviews != null) {
      return Future.value(reviews.values.toList());
    } else {
      return Future.value([]);
    }
  }

  Future<void> setReview({
    required ProductID productId,
    required String uId,
    required Review review,
  }) async {
    await delayed(addDelay);
    final allReviews = _reviews.value;
    final reviews = allReviews[productId];
    if (reviews != null) {
      reviews[uId] = review;
    } else {
      allReviews[productId] = {uId: review};
    }
    _reviews.value = allReviews;
  }
}

final fakeReviewRepositoryProvider = Provider<FakeReviewRepository>((ref) {
  return FakeReviewRepository();
});

final reviewRepositoryStreamProvider = StreamProvider.autoDispose
    .family<List<Review>, ProductID>((ref, productId) {
  return ref.watch(fakeReviewRepositoryProvider).watchProductReviews(productId);
});
