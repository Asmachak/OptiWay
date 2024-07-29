// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservationEvent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationEventModel _$ReservationEventModelFromJson(
        Map<String, dynamic> json) =>
    ReservationEventModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      endedAt: json['endedAt'] as String?,
      state: json['state'] as String?,
      iduser: json['iduser'] as String?,
      idevent: json['idevent'] as String?,
      nbreticket: (json['nbreticket'] as num?)?.toInt(),
      tarif: (json['tarif'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReservationEventModelToJson(
        ReservationEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'endedAt': instance.endedAt,
      'state': instance.state,
      'iduser': instance.iduser,
      'idevent': instance.idevent,
      'tarif': instance.tarif,
      'nbreticket': instance.nbreticket,
    };
