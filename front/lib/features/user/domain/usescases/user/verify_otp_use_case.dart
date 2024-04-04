import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/login_response_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class VerifyOtpUseCase
    implements
        UseCase<LoginResponseModel, VerifyOtpParams<Map<String, dynamic>>> {
  final UserRepository userRepository;

  VerifyOtpUseCase(this.userRepository);

  @override
  Future<Either<AppException, LoginResponseModel>> call(
      VerifyOtpParams params) async {
    return await userRepository.verifyOTP(email: params.email, otp: params.otp);
  }
}

class VerifyOtpParams<T> {
  final String email;
  final String otp;
  VerifyOtpParams({required this.email, required this.otp});
}
