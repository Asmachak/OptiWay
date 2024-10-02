import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/usescases/user/delete_user_use_case.dart';
import 'package:front/features/user/presentation/blocs/state/delete/delete_user_state.dart';

class DeleteNotifier extends StateNotifier<DeleteUserState> {
  final DeleteUseCases _DeleteUseCases;

  DeleteNotifier(
    this._DeleteUseCases,
  ) : super(const DeleteUserState.initial());

  Future<void> deleteUSer(String id) async {
    state = const DeleteUserState.loading();
    final result =
        await _DeleteUseCases.deleteUseCases.call(DeleteUserParams(id: id));
    result.fold(
      (failure) => state = DeleteUserState.failure(failure),
      (msg) {
        state = DeleteUserState.deleted(msg);
      },
    );
  }
}
