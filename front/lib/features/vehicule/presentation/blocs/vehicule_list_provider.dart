import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/domain/providers/vehicule_provider.dart';
import 'package:front/features/vehicule/domain/use_cases/list_vehicule_use_cases.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_notifier.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_state.dart';

final vehiculeListNotifierProvider =
    StateNotifierProvider<VehiculeListNotifier, VehiculeListState>((ref) {
  final getVehiculeUseCases = ref.read(getAllVehiculeUseCaseProvider);

  final vehiculeUseCases = VehiculeListUseCases(
    getVehiculeUseCase: getVehiculeUseCases,
  );
  return VehiculeListNotifier(vehiculeUseCases);
});
