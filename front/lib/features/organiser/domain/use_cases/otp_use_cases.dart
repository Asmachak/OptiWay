import 'package:front/features/organiser/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/verify_otp_use_case.dart';

class OtpOrganiserUseCases {
  final LoginOtpOrganiserUseCase loginOtpUseCase;
  final VerifyOtpOrganiserUseCase verifyOtpUseCase;

  OtpOrganiserUseCases(
      {required this.loginOtpUseCase, required this.verifyOtpUseCase});
}
