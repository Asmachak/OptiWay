// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_organiser_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationOrganiserModel _$ReservationOrganiserModelFromJson(
        Map<String, dynamic> json) =>
    ReservationOrganiserModel(
      event: json['event'] as Map<String, dynamic>?,
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ReservationOrganiserModelToJson(
        ReservationOrganiserModel instance) =>
    <String, dynamic>{
      'event': instance.event,
      'reservations': instance.reservations,
    };
