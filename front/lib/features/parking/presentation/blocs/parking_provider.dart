import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/parking/domain/providers/provider.dart';
import 'package:front/features/parking/domain/use_cases/parking_uses_cases.dart';
import 'package:front/features/parking/presentation/blocs/state/parking/parking_notifier.dart';
import 'package:front/features/parking/presentation/blocs/state/parking/parking_state.dart';

final parkingNotifierProvider =
    StateNotifierProvider<ParkingNotifier, ParkingState>((ref) {
  final getAllParkingsUseCases = ref.read(getAllParkingsUseCaseProvider);

  final parkingUseCases = ParkingUseCases(
    getAllParkingsUseCase: getAllParkingsUseCases,
  );

  return ParkingNotifier(parkingUseCases);
});
