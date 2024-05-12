import 'package:front/features/vehicule/domain/use_cases/get_manufacturer.dart';
import 'package:front/features/vehicule/domain/use_cases/get_models.dart';

class CarsModelUseCases {
  final GetModelsUseCase getModelsUseCase;

  CarsModelUseCases({
    required this.getModelsUseCase,
  });
}

class CarsBrandUseCases {
  final GetManufacturerUseCase getManufacturerUseCase;

  CarsBrandUseCases({
    required this.getManufacturerUseCase,
  });
}
