import 'package:front/features/parking/data/models/parking_model.dart';

class ParkingEntity {
  final String id;
  final String parkingName;
  final String adress;
  final String location;
  final String capacity;
  final String description;
  final String phoneContact;
  final String mailContact;

  ParkingEntity(
      {required this.id,
      required this.parkingName,
      required this.adress,
      required this.location,
      required this.capacity,
      required this.description,
      required this.phoneContact,
      required this.mailContact});

  factory ParkingEntity.fromJson(Map<String, dynamic> json) {
    return ParkingEntity(
      id: json['id'],
      parkingName: json['parkingName'],
      adress: json['adress'],
      location: json['location'],
      capacity: json['capacity'],
      description: json['description'],
      phoneContact: json['phoneContact'],
      mailContact: json['mailContact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parkingName': parkingName,
      'adress': adress,
      'location': location,
      'capacity': capacity,
      'description': description,
      'phoneContact': phoneContact,
      'mailContact': mailContact,
    };
  }

  ParkingModel parkingEntityToModel(ParkingEntity parkingEntity) {
    return ParkingModel(
      id: parkingEntity.id,
      parkingName: parkingEntity.parkingName,
      adress: parkingEntity.adress,
      location: parkingEntity.location,
      capacity: parkingEntity.capacity,
      description: parkingEntity.description,
      phoneContact: parkingEntity.phoneContact,
      mailContact: parkingEntity.mailContact,
    );
  }
}
