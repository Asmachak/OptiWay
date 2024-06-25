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
      genres: json['genres'] as String,
      rating: json['rating'] as String?,
      directors:
          (json['directors'] as List<dynamic>).map((e) => e as String).toList(),
      stars: (json['stars'] as List<dynamic>).map((e) => e as String).toList(),
      cinemas: (json['cinemas'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.image_url,
      'description': instance.description,
      'genres': instance.genres,
      'rating': instance.rating,
      'directors': instance.directors,
      'stars': instance.stars,
      'cinemas': instance.cinemas,
    };
