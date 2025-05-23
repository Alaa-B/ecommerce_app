import 'local_cart_repository.dart';
import '../../domain/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastCartRepository implements LocalCartRepository {
  SembastCartRepository(this.dp);
  final Database dp;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String fileName) async {
    if (!kIsWeb) {
      final appDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDir.path}/fileName');
    } else {
      return databaseFactoryWeb.openDatabase(fileName);
    }
  }

  static Future<SembastCartRepository> makeDefault() async {
    return SembastCartRepository(await createDatabase('default.dp'));
  }

  final String cartItemsKey = 'cart-items';

  @override
  Future<Cart> fetchCart() async {
    final cartJson = store.record(cartItemsKey).get(dp) as String?;
    if (cartJson != null) {
      return Cart.fromJson(cartJson);
    } else {}
    return Cart();
  }

  @override
  Future<void> setCart(Cart cart) {
    return store.record(cartItemsKey).put(dp, cart.toJson());
  }

  @override
  Stream<Cart> watchCart() {
    final record = store.record(cartItemsKey);
    return record.onSnapshot(dp).map((snapShot) {
      if (snapShot != null) {
        return Cart.fromJson(snapShot.value as String);
      } else {
        return const Cart();
      }
    });
  }
}
