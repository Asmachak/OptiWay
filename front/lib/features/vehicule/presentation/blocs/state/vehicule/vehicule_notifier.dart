import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/get_all_vehicules_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/vehicule_uses_cases.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_state.dart';
import 'package:get_it/get_it.dart';

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
}
