import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/otp_use_cases.dart';
import 'package:front/features/organiser/domain/use_cases/verify_otp_use_case.dart';
import 'package:front/features/organiser/presentation/blocs/state/otp/otp_state.dart';

class OrganiserOtpNotifier extends StateNotifier<OrganiserOtpState> {
  final OtpOrganiserUseCases _otpUseCases;

  OrganiserOtpNotifier(
    this._otpUseCases,
  ) : super(const OrganiserOtpState.initial());

  Future<void> loginOtp(String email) async {
    state = const OrganiserOtpState.loading();
    final result = await _otpUseCases.loginOtpUseCase
        .call(OrganiserOtpParams(email: email));
    result.fold(
      (failure) => state = OrganiserOtpState.failure(failure),
      (login) {
        state = const OrganiserOtpState.received();
      },
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const OrganiserOtpState.loading();
    final result = await _otpUseCases.verifyOtpUseCase
        .call(OrganiserVerifyOtpParams(email: email, otp: otp));
    result.fold(
      (failure) => state = OrganiserOtpState.failure(failure),
      (verify) {
        state = const OrganiserOtpState.verified();
      },
    );
  }
}
