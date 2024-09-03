import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/use_cases/auth_use_cases.dart';
import 'package:front/features/organiser/domain/use_cases/login_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/signup_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/auth/auth_state.dart';
import 'package:get_it/get_it.dart';

class AuthOrganiserNotifier extends StateNotifier<OrganiserAuthState> {
  final AuthOrganiserUseCases _authUseCases;

  AuthOrganiserNotifier(
    this._authUseCases,
  ) : super(const OrganiserAuthState.initial());

  Future<void> login(String email, String password) async {
    state = const OrganiserAuthState.loading();
    final result = await _authUseCases.loginUseCases
        .call(LoginParams(email: email, password: password));
    result.fold(
      (failure) => state = OrganiserAuthState.failure(failure),
      (organiser) {
        state = OrganiserAuthState.authenticated(
            organiser: organiserModelToEntity(organiser));
      },
    );
  }

  Future<void> signup(Map<String, dynamic> body) async {
    state = const OrganiserAuthState.loading();
    final result = await _authUseCases.registerUseCases
        .call(OrganiserRegistreParams(body: body));
    result.fold(
      (failure) => state = OrganiserAuthState.failure(failure),
      (user) {
        state = const OrganiserAuthState.success();
      },
    );
  }

  void logout() {
    GetIt.instance.get<OrganiserLocalDataSource>().logout();
    state = const OrganiserAuthState.initial();
  }
}
