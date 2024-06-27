import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final String id;
  final String title;
  final String image_url;
  final String description;
  final double? rating;
  final List<dynamic> parkings;

  EventModel(
      {required this.id,
      required this.title,
      required this.image_url,
      required this.description,
      required this.parkings,
      required this.rating});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
