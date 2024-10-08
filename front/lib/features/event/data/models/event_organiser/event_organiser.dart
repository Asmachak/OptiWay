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
  final Map<String, dynamic>? additional_info; // Can be null
  final Map<String, dynamic>? promotion; // Can be null
  final List<dynamic> parkings; // List of dynamic values

  EventOrganiserModel({
    required String id,
    required String title,
    required String image_url,
    required String description,
    double? rating = 0.0, // Default value to avoid null issue
    required this.type,
    required this.place,
    required this.createdAt,
    required this.endedAt,
    required this.unit_price,
    required this.capacity,
    required this.parkings,
    this.promotion, // Can be null
    this.additional_info, // Can be null
  }) : super(
          id: id,
          title: title,
          image_url: image_url,
          description: description,
          rating: rating ?? 0.0, // Ensure it's not null
          parkings: parkings,
        );

  factory EventOrganiserModel.fromJson(Map<String, dynamic> json) {
    return EventOrganiserModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image_url: json['image_url'],
      createdAt: DateTime.parse(json['createdAt']),
      endedAt: DateTime.parse(json['endedAt']),
      unit_price: (json['unit_price'] as num).toDouble(),
      capacity: json['capacity'],
      rating: (json['rating'] as num).toDouble(),
      type: json['type'],
      place: json['place'],
      parkings: json['parkings'] ?? [], // Default to empty list if null
      promotion: json['promotion']
          as Map<String, dynamic>?, // Handle promotion as a nullable Map
      additional_info: json['additional_info']
          as Map<String, dynamic>?, // Handle additional_info as nullable Map
    );
  }

  @override
  Map<String, dynamic> toJson() => _$EventOrganiserModelToJson(this);
}
