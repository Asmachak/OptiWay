import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/domain/use_cases/get_all_parkings_use_case.dart';
import 'package:front/features/parking/domain/use_cases/parking_uses_cases.dart';
import 'package:front/shared/use_case.dart';
import 'package:hive/hive.dart';
import 'parking_state.dart';

class ParkingNotifier extends StateNotifier<ParkingState> {
  final ParkingUseCases _parkingUseCases;

  ParkingNotifier(
    this._parkingUseCases,
  ) : super(const ParkingState.initial()) {
    getParkings(); // Fetch data on initialization
  }

  Future<void> getParkings() async {
    state = const ParkingState.loading();
    final result =
        await _parkingUseCases.getAllParkingsUseCase.call(NoParams());
    return result.fold(
      (failure) {
        state = ParkingState.failure(failure);
      },
      (parkings) {
        state = ParkingState.loaded(parkings: parkings);
      },
    );
  }
}
