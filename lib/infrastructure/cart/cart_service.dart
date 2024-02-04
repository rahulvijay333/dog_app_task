import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_test/domain/hive_model/hive_db_model.dart';

class CartDbService {
  Future<bool> addToCart({required String imageUrl}) async {
    final db = await Hive.openBox<HiveCartDb>(dbCartName);

    if (db.get(imageUrl) == null) {
      await db.put(imageUrl, HiveCartDb(imageUrl: imageUrl, cost: 5000));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFromCart({required String key}) async {
    final db = await Hive.openBox<HiveCartDb>(dbCartName);
    final value = db.get(key);
    if (value == null) {
      return false;
    } else {
     await db.delete(key);
     return true;
    }
  }

  Future<List<HiveCartDb>> getCartDetails() async {
    final db = await Hive.openBox<HiveCartDb>(dbCartName);

    return db.values.toList();
  }
}
