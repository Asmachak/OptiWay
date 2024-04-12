import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/usescases/user/auth_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/login_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/register_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/auth_state.dart';
import 'package:get_it/get_it.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCases _authUseCases;

  AuthNotifier(
    this._authUseCases,
  ) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await _authUseCases.loginUseCases
        .call(Params(email: email, password: password));
    result.fold(
      (failure) => state = AuthState.failure(failure),
      (user) {
        state = AuthState.authenticated(user: userModelToEntity(user));
      },
    );
  }

  Future<void> signup(Map<String, dynamic> body) async {
    state = const AuthState.loading();
    final result =
        await _authUseCases.registerUseCases.call(RegistreParams(body: body));
    result.fold(
      (failure) => state = AuthState.failure(failure),
      (user) {
        state = AuthState.success();
      },
    );
  }

  void logout() {
    GetIt.instance.get<AuthLocalDataSource>().logout();
    state = const AuthState.initial();
  }
}
