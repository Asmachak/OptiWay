// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_login_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminLoginResponseModelAdapter
    extends TypeAdapter<AdminLoginResponseModel> {
  @override
  final int typeId = 0;

  @override
  AdminLoginResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminLoginResponseModel(
      message: fields[0] as String,
      data: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminLoginResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminLoginResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
