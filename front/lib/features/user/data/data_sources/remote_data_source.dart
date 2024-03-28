import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:get_it/get_it.dart';

abstract class UserDataSource {
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password});
}

class UserRemoteDataSource implements UserDataSource {
  final NetworkService networkService;

  UserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.post(
        '/user/signup',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = UserModel.fromJson(response.data);
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRegisterUserRemoteDataSource.SignupUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password}) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };
      final eitherType = await networkService.post(
        '/user/login',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final user = UserModel.fromJson(response.data);
          // ignore: avoid_print
          print("from remote data src${user.token}");
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setToken(user.token!);

            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setCurrentUser(user);
          }

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
