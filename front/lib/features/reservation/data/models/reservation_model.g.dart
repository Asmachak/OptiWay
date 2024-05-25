// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      endedAt: json['endedAt'] as String?,
      state: json['state'] as String?,
      iduser: json['iduser'] as String?,
      idevent: json['idevent'] as String?,
      idparking: json['idparking'] as String?,
      idvehicule: json['idvehicule'] as String?,
      parking: json['parking'] as Map<String, dynamic>?,
      vehicle: json['vehicle'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'endedAt': instance.endedAt,
      'state': instance.state,
      'iduser': instance.iduser,
      'idevent': instance.idevent,
      'idparking': instance.idparking,
      'idvehicule': instance.idvehicule,
      'parking': instance.parking,
      'vehicle': instance.vehicle,
    };
