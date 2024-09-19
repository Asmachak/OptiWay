// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reclamation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReclamationModelAdapter extends TypeAdapter<ReclamationModel> {
  @override
  final int typeId = 3;

  @override
  ReclamationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReclamationModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      targetType: fields[2] as String?,
      iduser: fields[3] as String?,
      idorganiser: fields[4] as String?,
      idevent: fields[5] as String?,
      idparking: fields[6] as String?,
      parkingName: fields[7] as String?,
      eventName: fields[8] as String?,
      userName: fields[9] as String?,
      organiserName: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReclamationModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.targetType)
      ..writeByte(3)
      ..write(obj.iduser)
      ..writeByte(4)
      ..write(obj.idorganiser)
      ..writeByte(5)
      ..write(obj.idevent)
      ..writeByte(6)
      ..write(obj.idparking)
      ..writeByte(7)
      ..write(obj.parkingName)
      ..writeByte(8)
      ..write(obj.eventName)
      ..writeByte(9)
      ..write(obj.userName)
      ..writeByte(10)
      ..write(obj.organiserName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReclamationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReclamationModel _$ReclamationModelFromJson(Map<String, dynamic> json) =>
    ReclamationModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      targetType: json['targetType'] as String?,
      iduser: json['iduser'] as String?,
      idorganiser: json['idorganiser'] as String?,
      idevent: json['idevent'] as String?,
      idparking: json['idparking'] as String?,
      parkingName: json['parkingName'] as String?,
      eventName: json['eventName'] as String?,
      userName: json['userName'] as String?,
      organiserName: json['organiserName'] as String?,
    );

Map<String, dynamic> _$ReclamationModelToJson(ReclamationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'targetType': instance.targetType,
      'iduser': instance.iduser,
      'idorganiser': instance.idorganiser,
      'idevent': instance.idevent,
      'idparking': instance.idparking,
      'parkingName': instance.parkingName,
      'eventName': instance.eventName,
      'userName': instance.userName,
      'organiserName': instance.organiserName,
    };
