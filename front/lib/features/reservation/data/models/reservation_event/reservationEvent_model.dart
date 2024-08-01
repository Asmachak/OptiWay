import 'package:json_annotation/json_annotation.dart';
part 'reservationEvent_model.g.dart';

@JsonSerializable()
class ReservationEventModel {
  String? id;
  String? CreatedAt;
  String? EndedAt;
  String? state;
  String? iduser;
  String? idevent;
  double? tarif;
  int? Nbreticket;

  ReservationEventModel({
    this.id,
    this.CreatedAt,
    this.EndedAt,
    this.state,
    this.iduser,
    this.idevent,
    this.Nbreticket,
    this.tarif,
  });

  factory ReservationEventModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationEventModelToJson(this);
}
