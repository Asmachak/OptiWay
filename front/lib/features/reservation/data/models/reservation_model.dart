import 'package:json_annotation/json_annotation.dart';
import 'package:front/features/reservation/domain/entities/reservation_entity.dart';
part 'reservation_model.g.dart';

@JsonSerializable()
class ReservationModel {
  String? id;
  String? createdAt;
  String? endedAt;
  String? state;
  String? iduser;
  String? idevent;
  String? idparking;
  String? idvehicule;
  Map<String, dynamic>? parking;
  Map<String, dynamic>? vehicle;
  Map<String, dynamic>? user;

  ReservationModel(
      {this.id,
      this.createdAt,
      this.endedAt,
      this.state,
      this.iduser,
      this.idevent,
      this.idparking,
      this.idvehicule,
      this.parking,
      this.vehicle,
       this.user});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      createdAt: json['CreatedAt'],
      endedAt: json['EndedAt'],
      state: json['state'],
      iduser: json['iduser'],
      idevent: json['idevent'],
      idparking: json['idparking'],
      idvehicule: json['idvehicule'],
      parking: json['parking'],
      vehicle: json['vehicle'],
      user: json['user'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CreatedAt': createdAt,
      'EndedAt': endedAt,
      'state': state,
      'iduser': iduser,
      'idevent': idevent,
      'idparking': idparking,
      'idvehicule': idvehicule,
      'parking': parking,
      'vehicle': vehicle,
      'user': user,

    };
  }

  static ReservationEntity reservationModelToEntity(
      ReservationModel reservation) {
    return ReservationEntity(
      id: reservation.id!,
      createdAt: reservation.createdAt!,
      endedAt: reservation.endedAt!,
      state: reservation.state!,
      iduser: reservation.iduser!,
      idevent: reservation.idevent!,
      idparking: reservation.idparking!,
      idvehicule: reservation.idvehicule!,
      parking: reservation.parking!,
      vehicle: reservation.vehicle!,
      user: reservation.user!,

    );
  }

  ReservationModel reservationEntityToModel(
      ReservationEntity reservationEntity) {
    return ReservationModel(
      id: reservationEntity.id,
      createdAt: reservationEntity.createdAt,
      endedAt: reservationEntity.endedAt,
      state: reservationEntity.state,
      iduser: reservationEntity.iduser,
      idevent: reservationEntity.idevent,
      idparking: reservationEntity.idparking,
      idvehicule: reservationEntity.idvehicule,
      parking: reservationEntity.parking,
      vehicle: reservationEntity.vehicle,
      user: reservationEntity.user,

    );
  }
}
