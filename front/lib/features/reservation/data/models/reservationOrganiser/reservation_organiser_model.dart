import 'package:json_annotation/json_annotation.dart';
part 'reservation_organiser_model.g.dart';

@JsonSerializable()
class ReservationOrganiserModel {
  Map<String, dynamic>? event;
  List<Map<String, dynamic>>? reservations;

  ReservationOrganiserModel({this.event, this.reservations});

  factory ReservationOrganiserModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationOrganiserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationOrganiserModelToJson(this);
}
