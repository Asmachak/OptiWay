import 'package:front/features/parking/domain/entities/parking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_model.g.dart';

@JsonSerializable()
class ParkingModel {
  String? id;
  String? parkingName;
  String? adress;
  String? location;
  String? capacity;
  String? description;
  String? phoneContact;
  String? mailContact;

  ParkingModel({
    this.id,
    this.parkingName,
    this.adress,
    this.location,
    this.capacity,
    this.description,
    this.phoneContact,
    this.mailContact,
  });

  factory ParkingModel.fromJson(Map<String, dynamic> json) {
    return ParkingModel(
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

  ParkingEntity parkingModelToEntity(ParkingModel parkingModel) {
    return ParkingEntity(
      id: parkingModel.id!,
      parkingName: parkingModel.parkingName!,
      adress: parkingModel.adress!,
      location: parkingModel.location!,
      capacity: parkingModel.capacity!,
      description: parkingModel.description!,
      phoneContact: parkingModel.phoneContact!,
      mailContact: parkingModel.mailContact!,
    );
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
