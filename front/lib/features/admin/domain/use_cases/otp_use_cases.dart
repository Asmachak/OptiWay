import 'package:front/features/admin/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/admin/domain/use_cases/verify_otp_use_case.dart';

class OtpAdminUseCases {
  final LoginOtpAdminUseCase loginOtpUseCase;
  final VerifyOtpAdminUseCase verifyOtpUseCase;

  OtpAdminUseCases(
      {required this.loginOtpUseCase, required this.verifyOtpUseCase});
}
