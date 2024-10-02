import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/use_cases/delete_organiser_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/deleteOrganiser/delete_organiser_state.dart';

class DeleteOrganiserNotifier extends StateNotifier<DeleteOrganiserState> {
  final DeleteOrganiserUseCases _DeleteUseCases;

  DeleteOrganiserNotifier(
    this._DeleteUseCases,
  ) : super(const DeleteOrganiserState.initial());

  Future<void> deleteOrganiser(String id) async {
    state = const DeleteOrganiserState.loading();
    final result = await _DeleteUseCases.deleteUseCases
        .call(DeleteOrganiserParams(id: id));
    result.fold(
      (failure) => state = DeleteOrganiserState.failure(failure),
      (msg) {
        state = DeleteOrganiserState.deleted(msg);
      },
    );
  }
}
