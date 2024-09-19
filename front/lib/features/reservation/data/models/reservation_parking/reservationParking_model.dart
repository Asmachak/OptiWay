import 'package:json_annotation/json_annotation.dart';
part 'reservationParking_model.g.dart';

@JsonSerializable()
class ReservationParkingModel {
  String? id;
  String? createdAt;
  String? endedAt;
  String? state;
  String? iduser;
  String? idparking;
  String? idvehicule;
  double? amount;
  String? parkingName;

  ReservationParkingModel(
      {this.id,
      this.createdAt,
      this.endedAt,
      this.state,
      this.iduser,
      this.idparking,
      this.idvehicule,
      this.amount,
      this.parkingName});

  factory ReservationParkingModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationParkingModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationParkingModelToJson(this);
}
