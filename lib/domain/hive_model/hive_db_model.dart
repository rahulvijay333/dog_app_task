import 'package:hive_flutter/adapters.dart';
part 'hive_db_model.g.dart';

const dbHistoryName = 'db_history';

@HiveType(typeId: 1)
class HiveHistoryDb {
  @HiveField(0)
  final String imageUrl;

  HiveHistoryDb({required this.imageUrl});
}

const dbCartName = 'db_cart';

@HiveType(typeId: 2)
class HiveCartDb {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1,defaultValue: 5000)
  final int? cost;

  HiveCartDb({required this.imageUrl, required this.cost});
}
