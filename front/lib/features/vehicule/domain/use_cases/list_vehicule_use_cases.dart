import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/get_all_vehicules_use_case.dart';

class VehiculeListUseCases {
  final GetVehiculeUseCase getVehiculeUseCase;

  VehiculeListUseCases({
    required this.getVehiculeUseCase,
  });
}
