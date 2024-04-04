import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/login_response_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginOtpUseCase
    implements UseCase<LoginResponseModel, OtpParams<Map<String, dynamic>>> {
  final UserRepository userRepository;

  LoginOtpUseCase(this.userRepository);

  @override
  Future<Either<AppException, LoginResponseModel>> call(
      OtpParams params) async {
    return await userRepository.otpLogin(email: params.email);
  }
}

class OtpParams<T> {
  final String email;
  OtpParams({required this.email});
}
