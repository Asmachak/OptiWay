import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/domain/use_cases/cars_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/get_models.dart';

import 'package:front/features/vehicule/presentation/blocs/state/cars_model/cars_model_state.dart';

class CarsModelNotifier extends StateNotifier<CarModelState> {
  CarsModelUseCases _carModelUseCases;
  CarsModelNotifier(this._carModelUseCases)
      : super(const CarModelState.initial()) {}

  Future<void> getModels(String manufacturerId) async {
    state = const CarModelState.loading();
    final result = await _carModelUseCases.getModelsUseCase
        .call(GetModelsParams(manufacturerId: manufacturerId));
    return result.fold(
      (failure) {
        state = CarModelState.failure(failure);
      },
      (cars) {
        state = CarModelState.loaded(cars: cars);
      },
    );
  }
}
