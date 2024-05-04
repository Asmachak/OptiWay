import 'package:front/features/vehicule/domain/entities/vehicule_entity.dart';
import 'package:hive/hive.dart';

part 'vehicule_model.g.dart';

@HiveType(typeId: 1)
class VehiculeModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? matricule;

  @HiveField(2)
  final String? model;

  @HiveField(3)
  final String? marque;

  @HiveField(4)
  final String? iduser;

  factory VehiculeModel.fromJson(Map<String, dynamic> json) {
    return VehiculeModel(
      id: json['id'],
      matricule: json['matricule'],
      model: json['model'],
      marque: json['marque'],
      iduser: json['iduser'],
    );
  }

  VehiculeModel({
    this.id,
    this.matricule,
    this.model,
    this.marque,
    this.iduser,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'model': model,
      'marque': marque,
      'iduser': iduser,
    };
  }
}

VehiculeEntity vehiculeModelToEntity(VehiculeModel vehiculeModel) {
  return VehiculeEntity(
    id: vehiculeModel.id!,
    matricule: vehiculeModel.matricule!,
    model: vehiculeModel.model!,
    marque: vehiculeModel.marque!,
    iduser: vehiculeModel.iduser!,
  );
}

VehiculeModel vehiculeEntityToModel(VehiculeEntity userEntity) {
  return VehiculeModel(
    id: userEntity.id,
    matricule: userEntity.matricule,
    model: userEntity.model,
    marque: userEntity.marque,
    iduser: userEntity.iduser,
  );
}
