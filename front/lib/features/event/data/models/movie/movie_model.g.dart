// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      image_url: json['image_url'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      parkings: json['parkings'] as List<dynamic>,
      genres: json['genres'] as String,
      directors:
          (json['directors'] as List<dynamic>).map((e) => e as String).toList(),
      stars: (json['stars'] as List<dynamic>).map((e) => e as String).toList(),
      cinemas: json['cinemas'] as List<dynamic>,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.image_url,
      'description': instance.description,
      'rating': instance.rating,
      'parkings': instance.parkings,
      'genres': instance.genres,
      'directors': instance.directors,
      'stars': instance.stars,
      'cinemas': instance.cinemas,
    };
