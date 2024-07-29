// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      id: json['id'] as String?,
      CreatedAt: json['CreatedAt'] as String?,
      EndedAt: json['EndedAt'] as String?,
      state: json['state'] as String?,
      ReservationEvent: json['ReservationEvent'] as Map<String, dynamic>?,
      ReservationParking: json['ReservationParking'] as Map<String, dynamic>?,
      amount: (json['amount'] as num?)?.toDouble(),
    )..User = json['User'] as Map<String, dynamic>?;

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'CreatedAt': instance.CreatedAt,
      'EndedAt': instance.EndedAt,
      'state': instance.state,
      'User': instance.User,
      'amount': instance.amount,
      'ReservationEvent': instance.ReservationEvent,
      'ReservationParking': instance.ReservationParking,
    };
