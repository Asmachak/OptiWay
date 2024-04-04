import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/auth_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/login_otp_use_case.dart';
import 'package:front/features/user/presentation/blocs/state/auth_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCases = ref.read(loginUseCaseProvider);
  final registerUseCases = ref.read(registerUseCaseProvider);
  final loginOtpUseCase = ref.read(loginOtpUseCaseProvider);
  final verifyOtpUseCase = ref.read(verifyOtpUseCaseProvider);

  // final editProfileUseCases = ref.read(editProfileUseCaseProvider);
  // final updatePasswordUseCases = ref.read(updatePasswordUseCaseProvider);

  final authUseCases = AuthUseCases(
      loginUseCases: loginUseCases,
      registerUseCases: registerUseCases,

      // editProfileUseCases: editProfileUseCases,
      // updatePasswordUseCases: updatePasswordUseCases,
      );
  // final hiveBox = ref.watch(hiveBoxProvider);
  return AuthNotifier(authUseCases);
});
