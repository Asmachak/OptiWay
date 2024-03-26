import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/features/user/presentation/blocs/state/auth_state.dart';


class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepository userRepository;
  final AuthLocalDataSource _hiveBox;

  AuthNotifier(this.userRepository, this._hiveBox)
      : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result =
        await userRepository.loginUser(email: email, password: password);
    result.fold(
      (failure) => state = AuthState.failure(failure),
      (user) {
        state = AuthState.authenticated(user: userModelToEntity(user));
      },
    );
  }

  Future<void> signup(Map<String, dynamic> body) async {
    state = const AuthState.loading();
    final result = await userRepository.signUpUser(body: body);
    result.fold(
      (failure) => state = AuthState.failure(failure),
      (user) {
        state = AuthState.authenticated(user: userModelToEntity(user));
      },
    );
  }

  void logout() {
    _hiveBox.logout();
    state = const AuthState.initial();
  }
}
