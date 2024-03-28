import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/data_sources/remote_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource remoteDataSource;
 // final AuthLocalDataSource localDataSource;

  UserRepositoryImpl(this.remoteDataSource,/* this.localDataSource*/);

  @override
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body}) async {
    return remoteDataSource.signUpUser(body: body);
  }

  @override
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password}) async {
    return remoteDataSource.loginUser(email: email, password: password);
  }
}
