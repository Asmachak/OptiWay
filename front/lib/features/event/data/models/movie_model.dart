import 'package:json_annotation/json_annotation.dart';
import 'event_model.dart';

part 'movie_model.g.dart';

// @JsonSerializable()
// class MovieModel extends EventModel {
//   final String genres;
//   final String? rating; // Make rating nullable
//   final List<String> directors;
//   final List<String> stars;
//   final List<Map<String, String>> cinemas;

//   MovieModel({
//     required String id,
//     required String title,
//     required String imageUrl,
//     required String description,
//     required this.genres,
//     this.rating, // Make rating nullable
//     required this.directors,
//     required this.stars,
//     required this.cinemas,
//   }) : super(
//           id: id,
//           title: title,
//           imageUrl: imageUrl,
//           description: description,
//         );

//   factory MovieModel.fromJson(Map<String, dynamic> json) =>
//       _$MovieModelFromJson(json);
//   @override
//   Map<String, dynamic> toJson() => _$MovieModelToJson(this);
// }
@JsonSerializable()
class MovieModel extends EventModel {
  final String genres;
  final String? rating;
  final List<String> directors;
  final List<String> stars;
  final List<Map<String, String>> cinemas;

  MovieModel(
      {required String id,
      required String title,
      required String image_url,
      required String description,
      required this.genres,
      required this.rating,
      required this.directors,
      required this.stars,
      required this.cinemas})
      : super(
          id: id,
          title: title,
          image_url: image_url,
          description: description,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
