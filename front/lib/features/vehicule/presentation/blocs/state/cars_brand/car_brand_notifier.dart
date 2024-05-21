import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/domain/use_cases/cars_use_case.dart';
import 'package:front/features/vehicule/presentation/blocs/state/cars_brand/cars_state.dart';
import 'package:front/shared/use_case.dart';

class CarsBrandNotifier extends StateNotifier<CarBrandState> {
  final CarsBrandUseCases _carsBrandUseCases;

  CarsBrandNotifier(
    this._carsBrandUseCases,
  ) : super(const CarBrandState.initial()) {
    getManufacturer();
  }

  Future<void> getManufacturer() async {
    state = const CarBrandState.loading();
    final result =
        await _carsBrandUseCases.getManufacturerUseCase.call(NoParams());
    return result.fold(
      (failure) {
        state = CarBrandState.failure(failure);
      },
      (cars) {
        state = CarBrandState.loaded(cars: cars);
      },
    );
  }

  void resetState() {
    state = const CarBrandState.initial();
  }
}
