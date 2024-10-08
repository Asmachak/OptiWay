import 'package:json_annotation/json_annotation.dart';
part 'reservation_model.g.dart';

@JsonSerializable()
class ReservationModel {
  String? id;
  String? CreatedAt;
  String? EndedAt;
  String? state;
  Map<String, dynamic>? User;
  double? amount;
  Map<String, dynamic>? ReservationEvent;
  Map<String, dynamic>? ReservationParking;

  ReservationModel(
      {this.id,
      this.CreatedAt,
      this.EndedAt,
      this.state,
      this.ReservationEvent,
      this.ReservationParking,
      this.User,
      this.amount});

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
