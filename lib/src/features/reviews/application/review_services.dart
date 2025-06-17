import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/data/review_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'review_services.g.dart';

abstract class ReviewServices {
  Future<void> submitReview(ProductID productId, Review review);
}

@riverpod
ReviewServices reviewsService(Ref ref) {
  throw UnimplementedError();
}

@riverpod
Stream<Review?> watchUserReviews(Ref ref, ProductID productId) {
  final user = ref.watch(authStateChangesStreamProvider).value;
  if (user != null) {
    return ref
        .watch(reviewRepositoryProvider)
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
        .watch(reviewRepositoryProvider)
        .fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
}
