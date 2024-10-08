// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_organiser_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseOrganiserModelAdapter
    extends TypeAdapter<LoginResponseOrganiserModel> {
  @override
  final int typeId = 0;

  @override
  LoginResponseOrganiserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResponseOrganiserModel(
      message: fields[0] as String,
      data: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResponseOrganiserModel obj) {
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
      other is LoginResponseOrganiserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
