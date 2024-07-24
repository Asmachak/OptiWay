import 'package:json_annotation/json_annotation.dart';
import '../event/event_model.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends EventModel {
  final String genres;
  final List<String> directors;
  final List<String> stars;
  final List<dynamic> cinemas;
  final Map<String, dynamic> additional_info;

  MovieModel({
    required String id,
    required String title,
    required String image_url,
    required String description,
    required double? rating,
    required List<dynamic> parkings,
    required this.genres,
    required this.directors,
    required this.stars,
    required this.cinemas,
    required this.additional_info,
  }) : super(
          id: id,
          title: title,
          image_url: image_url,
          description: description,
          rating: rating,
          parkings: parkings,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
