import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/data/review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeReviewRepository implements ReviewRepository {
  FakeReviewRepository({this.addDelay = true});
  final bool addDelay;
  final _reviews = InMemoryStore<Map<ProductID, Map<String, Review>>>({});

  @override
  Stream<Review?> watchUserReview(ProductID productId, String uId) {
    return _reviews.stream.map((value) {
      return value[productId]?[uId];
    });
  }

  @override
  Future<Review?> fetchUserReview(ProductID productId, String uId) async {
    await delayed(addDelay);
    return Future.value(_reviews.value[productId]?[uId]);
  }

  @override
  Stream<List<Review>> watchProductReviews(ProductID productId) {
    return _reviews.stream.map((value) {
      final reviews = value[productId];
      if (reviews != null) {
        return reviews.values.toList();
      } else {
        return [];
      }
    });
  }

  @override
  Future<List<Review>> fetchProductReviews(ProductID productId) {
    final reviews = _reviews.value[productId];
    if (reviews != null) {
      return Future.value(reviews.values.toList());
    } else {
      return Future.value([]);
    }
  }

  @override
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
