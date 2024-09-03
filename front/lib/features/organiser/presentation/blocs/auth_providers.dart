import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/providers/organiser_providers.dart';
import 'package:front/features/organiser/domain/use_cases/auth_use_cases.dart';
import 'package:front/features/organiser/presentation/blocs/state/auth/auth_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/auth/auth_state.dart';

final authOrganiserNotifierProvider =
    StateNotifierProvider<AuthOrganiserNotifier, OrganiserAuthState>((ref) {
  final loginOrganiserUseCases = ref.read(loginOrganiserUseCaseProvider);
  final registreOrganiserUsecase = ref.read(registerOrganiserUseCaseProvider);

  final authUseCases = AuthOrganiserUseCases(
    loginUseCases: loginOrganiserUseCases,
    registerUseCases: registreOrganiserUsecase,
  );
  return AuthOrganiserNotifier(authUseCases);
});
