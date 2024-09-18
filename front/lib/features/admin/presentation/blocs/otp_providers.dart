import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/domain/providers/admin_providers.dart';
import 'package:front/features/admin/domain/use_cases/otp_use_cases.dart';
import 'package:front/features/admin/presentation/blocs/state/otp/admin_otp_state.dart';
import 'package:front/features/admin/presentation/blocs/state/otp/otp_notifier.dart';

final otpAdminNotifierProvider =
    StateNotifierProvider<AdminOtpNotifier, AdminOtpState>((ref) {
  final loginOtpUseCase = ref.read(loginOtpAdminUseCaseProvider);
  final verifyOtpUseCase = ref.read(verifyOtpAdminUseCaseProvider);

  // final editProfileUseCases = ref.read(editProfileUseCaseProvider);
  // final updatePasswordUseCases = ref.read(updatePasswordUseCaseProvider);

  final authUseCases = OtpAdminUseCases(
      loginOtpUseCase: loginOtpUseCase, verifyOtpUseCase: verifyOtpUseCase);
  // final hiveBox = ref.watch(hiveBoxProvider);
  return AdminOtpNotifier(authUseCases);
});
