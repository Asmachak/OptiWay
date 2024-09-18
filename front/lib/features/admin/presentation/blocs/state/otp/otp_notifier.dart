import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/admin/domain/use_cases/otp_use_cases.dart';
import 'package:front/features/admin/domain/use_cases/verify_otp_use_case.dart';
import 'package:front/features/admin/presentation/blocs/state/otp/admin_otp_state.dart';
import 'package:front/features/organiser/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/otp_use_cases.dart';
import 'package:front/features/organiser/domain/use_cases/verify_otp_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/otp/otp_state.dart';

class AdminOtpNotifier extends StateNotifier<AdminOtpState> {
  final OtpAdminUseCases _otpUseCases;

  AdminOtpNotifier(
    this._otpUseCases,
  ) : super(const AdminOtpState.initial());

  Future<void> loginOtp(String email) async {
    state = const AdminOtpState.loading();
    final result =
        await _otpUseCases.loginOtpUseCase.call(AdminOtpParams(email: email));
    result.fold(
      (failure) => state = AdminOtpState.failure(failure),
      (login) {
        state = const AdminOtpState.received();
      },
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const AdminOtpState.loading();
    final result = await _otpUseCases.verifyOtpUseCase
        .call(AdminVerifyOtpParams(email: email, otp: otp));
    result.fold(
      (failure) => state = AdminOtpState.failure(failure),
      (verify) {
        state = const AdminOtpState.verified();
      },
    );
  }
}
