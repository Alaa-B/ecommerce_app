import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_repository.g.dart';

class ProductsRepository {
  const ProductsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String productsPath() => 'products';
  static String productPath(ProductID id) => 'products/$id';

  Future<List<Product>> fetchProductsList() async {
    final ref = _productsCollRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<Product>> watchProductsList() {
    final ref = _productsCollRef();
    return ref.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((product) => product.data()).toList());
  }

  Future<Product?> fetchProductById(String id) async {
    final ref = _productDocRef(id);
    final snapShot = await ref.get();
    return snapShot.data();
  }

  Stream<Product?> watchProductById(String id) {
    final ref = _productDocRef(id);
    return ref.snapshots().map((product) => product.data());
  }

  Future<void> createProduct(ProductID id, String imageUrl) {
    return _firestore.doc(productPath(id)).set(
      {
        'id': id,
        'imageUrl': imageUrl,
      },
      // use merge: true to keep old fields (if any)
      SetOptions(merge: true),
    );
  }

  Future<void> updateProduct(Product product) {
    final ref = _productDocRef(product.id);
    return ref.set(product);
  }

  Future<void> deleteProduct(ProductID productId) {
    return _firestore.doc(productPath(productId)).delete();
  }

  Future<List<Product>> fetchSearchProductList(String query) async {
    final productsList = await fetchProductsList();
    return productsList
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Stream<List<Product>> watchSearchProductList(String query) {
    return watchProductsList().map(
      (productList) => productList
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  DocumentReference<Product> _productDocRef(ProductID id) =>
      _firestore.doc(productPath(id)).withConverter(
            fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
            toFirestore: (Product product, options) => product.toMap(),
          );

  Query<Product> _productsCollRef() => _firestore
      .collection(productsPath())
      .withConverter(
        fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
        toFirestore: (Product product, options) => product.toMap(),
      )
      .orderBy('id');
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Product>> productsListStream(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProductsList();
}

@riverpod
Future<List<Product>> productsListFuture(Ref ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.fetchProductsList();
}

@riverpod
Stream<Product?> productStreamById(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductById(id);
}

@riverpod
Future<Product?> productFutureById(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductById(id);
}

@riverpod
Future<List<Product>> fetchProductsListSearch(Ref ref, String query) {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  return ref
      .watch(productsRepositoryProvider)
      .watchSearchProductList(query)
      .first;
}

@riverpod
Stream<List<Product>> watchProductsListSearch(Ref ref, String query) {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  return ref.watch(productsRepositoryProvider).watchSearchProductList(query);
}
