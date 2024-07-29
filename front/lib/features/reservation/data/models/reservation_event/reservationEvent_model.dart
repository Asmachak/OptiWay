import 'package:json_annotation/json_annotation.dart';
part 'reservationEvent_model.g.dart';

@JsonSerializable()
class ReservationEventModel {
  String? id;
  String? createdAt;
  String? endedAt;
  String? state;
  String? iduser;
  String? idevent;
  double? tarif;
  int? nbreticket;


  ReservationEventModel(
      {this.id,
      this.createdAt,
      this.endedAt,
      this.state,
      this.iduser,
      this.idevent,
      this.nbreticket,
      this.tarif});

  factory ReservationEventModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationEventModelToJson(this);
}
