// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 4;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      token: fields[3] as String?,
      phone: fields[4] as String?,
      password: fields[5] as String?,
      photo: fields[6] as String?,
      lastName: fields[7] as String?,
      address: fields[8] as String?,
      city: fields[9] as String?,
      country: fields[10] as String?,
      deviceId: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.photo)
      ..writeByte(7)
      ..write(obj.lastName)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.deviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
