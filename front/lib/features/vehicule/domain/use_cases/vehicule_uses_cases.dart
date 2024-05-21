import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/delete_vehicule_use_case.dart';

class VehiculeUseCases {
  final AddVehiculeUseCase addVehiculeUseCase;
  final DeleteVehiculeUseCase deleteVehiculeUseCase;

  VehiculeUseCases(
      {required this.addVehiculeUseCase, required this.deleteVehiculeUseCase});
}
