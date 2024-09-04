// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organiser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventOrganiserModel _$EventOrganiserModelFromJson(Map<String, dynamic> json) =>
    EventOrganiserModel(
      id: json['id'] as String,
      title: json['title'] as String,
      image_url: json['image_url'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      parkings: json['parkings'] as List<dynamic>,
      type: json['type'] as String,
      place: json['place'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      unit_price: (json['unit_price'] as num).toDouble(),
      capacity: (json['capacity'] as num).toInt(),
      additional_info: json['additional_info'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$EventOrganiserModelToJson(
        EventOrganiserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.image_url,
      'description': instance.description,
      'rating': instance.rating,
      'parkings': instance.parkings,
      'type': instance.type,
      'place': instance.place,
      'createdAt': instance.createdAt.toIso8601String(),
      'endedAt': instance.endedAt.toIso8601String(),
      'unit_price': instance.unit_price,
      'capacity': instance.capacity,
      'additional_info': instance.additional_info,
    };
