import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/domain/providers/vehicule_provider.dart';
import 'package:front/features/vehicule/domain/use_cases/cars_use_case.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_brand/car_brand_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_brand/cars_state.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_model/car_model_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_model/cars_model_state.dart';

final carsBrandNotifierProvider =
    StateNotifierProvider<CarsBrandNotifier, CarBrandState>((ref) {
  final getManufacturerUseCases = ref.read(getManufacturerUseCaseProvider);
  
  final CarsBrandCases = CarsBrandUseCases(
    getManufacturerUseCase: getManufacturerUseCases,
    
  );
  return CarsBrandNotifier(CarsBrandCases);
});

final carsModelNotifierProvider = StateNotifierProvider<CarsModelNotifier, CarModelState>((ref) {
  final getModelsUseCase = ref.read(getModelsUseCaseProvider);

  final carsModelCases = CarsModelUseCases(
    getModelsUseCase: getModelsUseCase,
  );

  return CarsModelNotifier(carsModelCases);
});
