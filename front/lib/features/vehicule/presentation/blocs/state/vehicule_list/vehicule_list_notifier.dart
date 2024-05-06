import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/get_all_vehicules_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/list_vehicule_use_cases.dart';
import 'package:front/features/vehicule/domain/use_cases/vehicule_uses_cases.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule/vehicule_state.dart';
import 'package:front/features/vehicule/presentation/blocs/state/vehicule_list/vehicule_list_state.dart';
import 'package:get_it/get_it.dart';

class VehiculeListNotifier extends StateNotifier<VehiculeListState> {
  final VehiculeListUseCases _vehiculeListUseCases;

  VehiculeListNotifier(
    this._vehiculeListUseCases,
  ) : super(const VehiculeListState.initial()) {
    getVehicules(GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!);
  }

  Future<void> getVehicules(String iduser) async {
    state = const VehiculeListState.loading();
    final result = await _vehiculeListUseCases.getVehiculeUseCase
        .call(GetVehiculeParams(iduser: iduser));
    return result.fold(
      (failure) {
        state = VehiculeListState.failure(failure);
      },
      (vehicules) {
        state = VehiculeListState.loaded(vehicules: vehicules);
      },
    );
  }
}
