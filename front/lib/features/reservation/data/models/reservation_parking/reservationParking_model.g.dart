// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservationParking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationParkingModel _$ReservationParkingModelFromJson(
        Map<String, dynamic> json) =>
    ReservationParkingModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      endedAt: json['endedAt'] as String?,
      state: json['state'] as String?,
      iduser: json['iduser'] as String?,
      idparking: json['idparking'] as String?,
      idvehicule: json['idvehicule'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReservationParkingModelToJson(
        ReservationParkingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'endedAt': instance.endedAt,
      'state': instance.state,
      'iduser': instance.iduser,
      'idparking': instance.idparking,
      'idvehicule': instance.idvehicule,
      'amount': instance.amount,
    };
