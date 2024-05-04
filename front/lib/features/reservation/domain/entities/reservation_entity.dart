import 'package:front/features/reservation/data/models/reservation_model.dart';

class ReservationEntity {
  final String id;
  final String createdAt;
  final String endedAt;
  final String state;
  final String iduser;
  final String idevent;
  final String idparking;

  ReservationEntity(
      {required this.id,
      required this.createdAt,
      required this.endedAt,
      required this.state,
      required this.iduser,
      required this.idevent,
      required this.idparking});

  factory ReservationEntity.fromJson(Map<String, dynamic> json) {
    return ReservationEntity(
      id: json['id'],
      createdAt: json['createdAt'],
      endedAt: json['endedAt'],
      state: json['state'],
      iduser: json['iduser'],
      idevent: json['idevent'],
      idparking: json['idparking'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'endedAt': endedAt,
      'state': state,
      'iduser': iduser,
      'idevent': idevent,
      'idparking': idparking,
    };
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
    );
  }
}
