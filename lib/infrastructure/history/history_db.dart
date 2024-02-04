import 'package:hive_flutter/adapters.dart';
import 'package:machine_test/domain/hive_model/hive_db_model.dart';

class HistoryDbOp {
  Future<void> addtoHistory({required String imageUrl}) async {
    final db = await Hive.openBox<HiveHistoryDb>(dbHistoryName);

    await db.add(HiveHistoryDb(imageUrl: imageUrl));
  }

  Future<List<HiveHistoryDb>> getFromHistory() async {
    final db = await Hive.openBox<HiveHistoryDb>(dbHistoryName);
    final values = db.values.toList();

    return values;
  }

  Future<void> clearHistory() async {
    final db = await Hive.openBox<HiveHistoryDb>(dbHistoryName);
    db.clear();
  }
}
