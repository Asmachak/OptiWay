import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginUseCases implements UseCase<UserModel, Params> {
  final UserRepository authRepository;

  LoginUseCases(this.authRepository);

  @override
  Future<Either<AppException, UserModel>> call(Params params) async {
    return await authRepository.loginUser(
        email: params.email, password: params.password);
  }
}

class Params<T> {
  /*T? data;
  String? newPassword;*/
  final String email;
  final String password;
  Params({required this.email, required this.password});
}
