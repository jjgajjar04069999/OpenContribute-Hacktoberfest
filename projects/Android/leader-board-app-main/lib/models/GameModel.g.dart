// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameModelHiveGen extends TypeAdapter<GameModel> {
  @override
  final int typeId = 111;

  @override
  GameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModel(
      name: fields[0] as String,
      scoreBoard: (fields[1] as List)
          ?.map((dynamic e) => (e as Map)?.cast<dynamic, dynamic>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.scoreBoard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModelHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
