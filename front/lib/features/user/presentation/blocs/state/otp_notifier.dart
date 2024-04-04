import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/domain/usescases/user/login_otp_use_case.dart';
import 'package:front/features/user/domain/usescases/user/otp_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/verify_otp_use_case.dart';
import 'package:front/features/user/presentation/blocs/state/otp_state.dart';

class OtpNotifier extends StateNotifier<OtpState> {
  final OtpUseCases _otpUseCases;

  OtpNotifier(
    this._otpUseCases,
  ) : super(const OtpState.initial()) {}

  Future<void> loginOtp(String email) async {
    state = const OtpState.loading();
    final result =
        await _otpUseCases.loginOtpUseCase.call(OtpParams(email: email));
    result.fold(
      (failure) => state = OtpState.failure(failure),
      (login) {
        state = const OtpState.received();
      },
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = const OtpState.loading();
    final result = await _otpUseCases.verifyOtpUseCase.call(
        VerifyOtpParams(email: email, otp: otp));
    result.fold(
      (failure) => state = OtpState.failure(failure),
      (verify) {
        state = const OtpState.verified();
      },
    );
  }
}
