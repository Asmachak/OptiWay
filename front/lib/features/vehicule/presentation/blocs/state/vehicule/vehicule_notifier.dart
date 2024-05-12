import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/delete_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/vehicule_uses_cases.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_state.dart';

class VehiculeNotifier extends StateNotifier<VehiculeState> {
  final VehiculeUseCases _vehiculeUseCases;

  VehiculeNotifier(
    this._vehiculeUseCases,
  ) : super(const VehiculeState.initial()) {}

  Future<void> addVehicule(String iduser, Map<String, dynamic> body) async {
    state = const VehiculeState.loading();
    final result = await _vehiculeUseCases.addVehiculeUseCase
        .call(AddVehiculeParams(iduser: iduser, body: body));
    result.fold(
      (failure) => state = VehiculeState.failure(failure),
      (vehicule) {
        state =
            VehiculeState.success(vehicule: vehiculeModelToEntity(vehicule));
      },
    );
  }

  Future<void> deleteVehicule(String id) async {
    state = const VehiculeState.loading();
    final result = await _vehiculeUseCases.deleteVehiculeUseCase
        .call(DeleteVehiculeParams(id: id));
    result.fold((failure) => state = VehiculeState.failure(failure), (msg) {
      if (msg == "Vehicule is deleted successfully") {
        state = const VehiculeState.deleted();
      }
    });
  }
}
