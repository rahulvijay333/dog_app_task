// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveHistoryDbAdapter extends TypeAdapter<HiveHistoryDb> {
  @override
  final int typeId = 1;

  @override
  HiveHistoryDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveHistoryDb(
      imageUrl: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveHistoryDb obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveHistoryDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveCartDbAdapter extends TypeAdapter<HiveCartDb> {
  @override
  final int typeId = 2;

  @override
  HiveCartDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartDb(
      imageUrl: fields[0] as String,
      cost: fields[1] == null ? 5000 : fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartDb obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
