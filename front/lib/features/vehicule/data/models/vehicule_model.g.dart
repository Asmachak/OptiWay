// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehiculeModelAdapter extends TypeAdapter<VehiculeModel> {
  @override
  final int typeId = 1;

  @override
  VehiculeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehiculeModel(
      id: fields[0] as String?,
      matricule: fields[1] as String?,
      model: fields[2] as String?,
      marque: fields[3] as String?,
      iduser: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VehiculeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.matricule)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.marque)
      ..writeByte(4)
      ..write(obj.iduser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehiculeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
