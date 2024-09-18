import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/use_cases/auth_use_cases.dart';
import 'package:front/features/admin/domain/use_cases/login_use_case.dart';
import 'package:front/features/admin/domain/use_cases/signup_use_case.dart';
import 'package:front/features/admin/presentation/blocs/state/auth/admin_auth_state.dart';
import 'package:get_it/get_it.dart';

class AuthAdminNotifier extends StateNotifier<AdminAuthState> {
  final AuthAdminUseCases _authUseCases;

  AuthAdminNotifier(
    this._authUseCases,
  ) : super(const AdminAuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AdminAuthState.loading();
    final result = await _authUseCases.loginUseCases
        .call(AdminLoginParams(email: email, password: password));
    result.fold(
      (failure) => state = AdminAuthState.failure(failure),
      (admin) {
        state = AdminAuthState.authenticated(admin: adminModelToEntity(admin));
      },
    );
  }

  Future<void> signup(Map<String, dynamic> body) async {
    state = const AdminAuthState.loading();
    final result = await _authUseCases.registerUseCases
        .call(AdminRegistreParams(body: body));
    result.fold(
      (failure) => state = AdminAuthState.failure(failure),
      (user) {
        state = const AdminAuthState.success();
      },
    );
  }

  void logout() {
    GetIt.instance.get<AdminLocalDataSource>().logout();
    state = const AdminAuthState.initial();
  }
}
