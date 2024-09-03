import 'package:json_annotation/json_annotation.dart';
import '../event/event_model.dart';

part 'event_organiser.g.dart';

@JsonSerializable()
class EventOrganiserModel extends EventModel {
  final String type;
  final String place;
  final DateTime createdAt;
  final DateTime endedAt;
  final double unit_price;
  final int capacity;
  final Map<String, dynamic> additional_info;
  //final Map<String, dynamic>? promotion; // Uncomment if needed

  EventOrganiserModel({
    required String id,
    required String title,
    required String image_url,
    required String description,
    double? rating = 0.0, // Default value to avoid null issue
    required List<dynamic> parkings,
    required this.type,
    required this.place,
    required this.createdAt,
    required this.endedAt,
    required this.unit_price,
    required this.capacity,
    required this.additional_info,
    //this.promotion, // Uncomment if needed
  }) : super(
          id: id,
          title: title,
          image_url: image_url,
          description: description,
          rating: rating ?? 0.0, // Ensure it's not null
          parkings: parkings,
        );

  factory EventOrganiserModel.fromJson(Map<String, dynamic> json) =>
      _$EventOrganiserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventOrganiserModelToJson(this);
}
