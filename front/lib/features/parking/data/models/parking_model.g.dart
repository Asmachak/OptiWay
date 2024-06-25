// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingModel _$ParkingModelFromJson(Map<String, dynamic> json) => ParkingModel(
      id: json['id'] as String?,
      parkingName: json['parkingName'] as String?,
      adress: json['adress'] as String?,
      location: json['location'] as String?,
      capacity: json['capacity'] as String?,
      description: json['description'] as String?,
      phoneContact: json['phoneContact'] as String?,
      mailContact: json['mailContact'] as String?,
      averageRate: json['averageRate'] as String?,
    );

Map<String, dynamic> _$ParkingModelToJson(ParkingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parkingName': instance.parkingName,
      'adress': instance.adress,
      'location': instance.location,
      'capacity': instance.capacity,
      'description': instance.description,
      'phoneContact': instance.phoneContact,
      'mailContact': instance.mailContact,
      'averageRate': instance.averageRate,
    };
