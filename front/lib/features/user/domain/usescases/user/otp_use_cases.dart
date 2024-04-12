import 'package:front/features/user/domain/usescases/user/login_otp_use_case.dart';
import 'package:front/features/user/domain/usescases/user/verify_otp_use_case.dart';

class OtpUseCases {
  final LoginOtpUseCase loginOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpUseCases({required this.loginOtpUseCase, required this.verifyOtpUseCase});
}
