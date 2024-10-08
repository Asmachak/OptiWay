import 'package:front/features/vehicule/data/models/vehicule_model.dart';

class VehiculeEntity {
  final String id;
  final String matricule;
  final String model;
  final String marque;
  final String iduser;
  final String color;
  final String state;

  VehiculeEntity(
      {required this.id,
      required this.matricule,
      required this.model,
      required this.marque,
      required this.iduser,
      required this.color,
      required this.state,
      y});

  factory VehiculeEntity.fromJson(Map<String, dynamic> json) {
    return VehiculeEntity(
      id: json['id'],
      matricule: json['matricule'],
      marque: json['marque'],
      model: json['last_matricule'],
      iduser: json['iduser'],
      color: json['color'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'marque': marque,
      'last_matricule': model,
      'iduser': iduser,
      'color': color,
      'state': state,
    };
  }

  VehiculeModel vehiculeEntityToModel(VehiculeEntity vehiculeEntity) {
    return VehiculeModel(
      id: vehiculeEntity.id,
      matricule: vehiculeEntity.matricule,
      marque: vehiculeEntity.marque,
      iduser: vehiculeEntity.iduser,
      model: vehiculeEntity.model,
      color: vehiculeEntity.color,
      state: vehiculeEntity.state,
    );
  }
}
