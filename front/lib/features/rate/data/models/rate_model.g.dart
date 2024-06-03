// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      id: json['id'] as String?,
      reservation: json['reservation'] as String?,
      user: json['user'] as String?,
      description: json['description'] as String?,
      eventRate: (json['eventRate'] as num?)?.toDouble(),
      parkingRate: (json['parkingRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'reservation': instance.reservation,
      'description': instance.description,
      'parkingRate': instance.parkingRate,
      'eventRate': instance.eventRate,
    };
