import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password});
}
