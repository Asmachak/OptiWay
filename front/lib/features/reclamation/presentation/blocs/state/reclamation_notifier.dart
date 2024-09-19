import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reclamation/domain/use_cases/add_reclamation_use_case.dart';
import 'package:front/features/reclamation/domain/use_cases/reclamation_use_cases.dart';
import 'package:front/features/reclamation/presentation/blocs/state/reclamation_state.dart';
import 'package:front/shared/use_case.dart';

class ReclamationNotifier extends StateNotifier<ReclamationState> {
  final ReclamationUseCases _reclamationUseCases;

  ReclamationNotifier(
    this._reclamationUseCases,
  ) : super(const ReclamationState.initial());

  Future<void> addReclamation(
      String reclaimerId, String targetId, Map<String, dynamic> body) async {
    state = const ReclamationState.loading();
    final result = await _reclamationUseCases.addReclamationUseCases.call(
        AddReclamationParams(
            body: body, reclaimerId: reclaimerId, targetId: targetId));
    result.fold(
      (failure) => state = ReclamationState.failure(failure),
      (reclamation) {
        state = ReclamationState.success(reclamation: reclamation);
      },
    );
  }

  Future<void> getReclamations() async {
    state = const ReclamationState.loading();
    final result =
        await _reclamationUseCases.getReclamationUseCases.call(NoParams());
    result.fold(
      (failure) => state = ReclamationState.failure(failure),
      (reclamations) {
        state = ReclamationState.loaded(reclamations: reclamations);
      },
    );
  }
}
