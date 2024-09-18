import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/get_users_use_case.dart';
import 'package:front/features/user/presentation/blocs/state/get_users/get_users_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/get_users/get_users_state.dart';

final getAllUsersNotifierProvider =
    StateNotifierProvider<GetUsersNotifier, GetUserState>((ref) {
  final getAllUsersUseCases = ref.read(getAllUsersUseCaseProvider);

  final getUsersUseCases = GetUsersUseCases(
    getAllUsersUseCases: getAllUsersUseCases,
  );
  return GetUsersNotifier(getUsersUseCases);
});
