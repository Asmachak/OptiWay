import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/entities/user_entity.dart';
import 'package:front/features/user/domain/usescases/user/auth_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/get_users_use_case.dart';
import 'package:front/features/user/domain/usescases/user/login_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/get_users/get_users_state.dart';
import 'package:front/shared/use_case.dart';

class GetUsersNotifier extends StateNotifier<GetUserState> {
  final GetUsersUseCases _getUserUseCases;

  GetUsersNotifier(
    this._getUserUseCases,
  ) : super(const GetUserState.initial());

  Future<void> getUsers() async {
    state = const GetUserState.loading();
    final result = await _getUserUseCases.getAllUsersUseCases.call(NoParams());
    result.fold(
      (failure) => state = GetUserState.failure(failure),
      (userList) {
        // Convert List<UserModel> to List<UserEntity>
        final List<UserEntity> usersEntityList =
            userList.map((user) => userModelToEntity(user)).toList();
        state = GetUserState.loaded(list: usersEntityList);
      },
    );
  }
}
