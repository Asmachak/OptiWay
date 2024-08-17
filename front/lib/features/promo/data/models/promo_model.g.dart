// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoModel _$PromoModelFromJson(Map<String, dynamic> json) => PromoModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      EndedAt: json['EndedAt'] as String?,
      state: json['state'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      ticketNumber: (json['ticketNumber'] as num?)?.toInt(),
      percentageEvent: (json['percentageEvent'] as num?)?.toDouble(),
      percentageParking: (json['percentageParking'] as num?)?.toDouble(),
      event: json['event'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PromoModelToJson(PromoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'EndedAt': instance.EndedAt,
      'state': instance.state,
      'title': instance.title,
      'description': instance.description,
      'ticketNumber': instance.ticketNumber,
      'percentageEvent': instance.percentageEvent,
      'percentageParking': instance.percentageParking,
      'event': instance.event,
    };
