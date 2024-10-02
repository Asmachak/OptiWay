import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/delete_user_use_case.dart';
import 'package:front/features/user/presentation/blocs/state/delete/delete_user_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/delete/delete_user_state.dart';

final deleteNotifierProvider =
    StateNotifierProvider<DeleteNotifier, DeleteUserState>((ref) {
  final deleteUserUseCases = ref.read(deleteUsersUseCaseProvider);

  final deleteUseCases = DeleteUseCases(
    deleteUseCases: deleteUserUseCases,
  );
  return DeleteNotifier(deleteUseCases);
});
