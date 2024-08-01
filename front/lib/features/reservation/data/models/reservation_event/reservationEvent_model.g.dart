// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservationEvent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationEventModel _$ReservationEventModelFromJson(
        Map<String, dynamic> json) =>
    ReservationEventModel(
      id: json['id'] as String?,
      CreatedAt: json['CreatedAt'] as String?,
      EndedAt: json['EndedAt'] as String?,
      state: json['state'] as String?,
      iduser: json['iduser'] as String?,
      idevent: json['idevent'] as String?,
      Nbreticket: (json['Nbreticket'] as num?)?.toInt(),
      tarif: (json['tarif'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReservationEventModelToJson(
        ReservationEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'CreatedAt': instance.CreatedAt,
      'EndedAt': instance.EndedAt,
      'state': instance.state,
      'iduser': instance.iduser,
      'idevent': instance.idevent,
      'tarif': instance.tarif,
      'Nbreticket': instance.Nbreticket,
    };
