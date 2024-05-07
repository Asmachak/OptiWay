import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/domain/providers/vehicule_provider.dart';
import 'package:front/features/vehicule/domain/use_cases/vehicule_uses_cases.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_state.dart';

final vehiculeNotifierProvider =
    StateNotifierProvider<VehiculeNotifier, VehiculeState>((ref) {
  final addVehiculeUseCases = ref.read(addVehiculeUseCaseProvider);
  final deleteVehiculeUseCases = ref.read(deleteVehiculeUseCaseProvider);

  final vehiculeUseCases = VehiculeUseCases(
      addVehiculeUseCase: addVehiculeUseCases,
      deleteVehiculeUseCase: deleteVehiculeUseCases);
  return VehiculeNotifier(vehiculeUseCases);
});
