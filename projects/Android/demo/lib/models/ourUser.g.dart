// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ourUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OurUserHiveGen extends TypeAdapter<OurUser> {
  @override
  final int typeId = 133;

  @override
  OurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OurUser(
      uid: fields[0] as String,
      phone: fields[1] as String,
      fullName: fields[2] as String,
      email: fields[4] as String,
      type: fields[3] as String,
      profileImg: fields[5] as String,
      gender: fields[6] as String,
      state: fields[10] as String,
      pincode: fields[11] as String,
      city: fields[9] as String,
      street: fields[8] as String,
      houseNo: fields[7] as String,
      orders: (fields[12] as List)?.cast<dynamic>(),
      dob: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, OurUser obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.profileImg)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.houseNo)
      ..writeByte(8)
      ..write(obj.street)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.pincode)
      ..writeByte(12)
      ..write(obj.orders)
      ..writeByte(13)
      ..write(obj.dob);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OurUserHiveGen &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
