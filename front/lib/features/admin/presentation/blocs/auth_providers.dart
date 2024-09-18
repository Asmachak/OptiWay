import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/domain/providers/admin_providers.dart';
import 'package:front/features/admin/domain/use_cases/auth_use_cases.dart';
import 'package:front/features/admin/presentation/blocs/state/auth/admin_auth_state.dart';
import 'package:front/features/admin/presentation/blocs/state/auth/auth_notifier.dart';

final authAdminNotifierProvider =
    StateNotifierProvider<AuthAdminNotifier, AdminAuthState>((ref) {
  final loginAdminUseCases = ref.read(logiAdminUseCaseProvider);
  final registreAdminUsecase = ref.read(registerAdminUseCaseProvider);

  final authUseCases = AuthAdminUseCases(
    loginUseCases: loginAdminUseCases,
    registerUseCases: registreAdminUsecase,
  );
  return AuthAdminNotifier(authUseCases);
});
