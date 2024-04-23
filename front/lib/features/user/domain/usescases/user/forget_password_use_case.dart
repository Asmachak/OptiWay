import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class ForgetPasswordUseCase
    implements UseCase<UserModel, ForgetPasswordParams> {
  final UserRepository userRepository;

  ForgetPasswordUseCase(this.userRepository);
  @override
  Future<Either<AppException, UserModel>> call(
      ForgetPasswordParams params) async {
    return await userRepository.forgetPassword(body: params.body);
  }
}

class ForgetPasswordParams<T> {
  final Map<String, dynamic> body;
  ForgetPasswordParams({
    required this.body,
  });
}
