import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/login_response_model.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class UserDataSource {
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password});
  Future<Either<AppException, LoginResponseModel>> otpLogin(
      {required String email});
  Future<Either<AppException, LoginResponseModel>> verifyOTP(
      {required String email, required String otp});
  Future<Either<AppException, UserModel>> editProfile(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, UserModel>> editPassword(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, UserModel>> forgetPassword(
      {required Map<String, dynamic> body});
  Future<Either<AppException, UserModel>> uploadImage(
      {required File imageFile, required String id});
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
  Future<Either<AppException, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Retrieve the OneSignal Player ID
      String? playerId;
      playerId = OneSignal.User.pushSubscription.id;

      if (playerId == null) {
        return Left(
          AppException(
            "Failed to retrieve OneSignal Player ID",
            message: "Player ID is null",
            statusCode: 1,
            identifier: 'LoginUserRemoteDataSource.loginUser',
          ),
        );
      }

      // Prepare the body with email, password, and playerId
      final body = {
        'email': email,
        'password': password,
        'playerId': playerId,
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

  @override
  Future<Either<AppException, LoginResponseModel>> otpLogin(
      {required String email}) async {
    try {
      final body = {
        'email': email,
      };
      final eitherType = await networkService.post(
        '/otp-login',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final login = LoginResponseModel.fromJson(response.data);
          return Right(login);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginOTPUserRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, LoginResponseModel>> verifyOTP(
      {required String email, required String otp}) async {
    try {
      final body = {'email': email, 'otp': otp};
      final eitherType = await networkService.post(
        '/otp-verify',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final verify = LoginResponseModel.fromJson(response.data);
          return Right(verify);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginOTPUserRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/user/update/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final user = UserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setToken(user.token!);

            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setCurrentUser(user);

            await GetIt.instance.get<AuthLocalDataSource>().refreshUserData();
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
          identifier: '${e.toString()}\nUpdateUserRemoteDataSource.UpdateUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/user/editPassword/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final user = UserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setToken(user.token!);

            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setCurrentUser(user);

            await GetIt.instance.get<AuthLocalDataSource>().refreshUserData();
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
          identifier: '${e.toString()}\nUpdateUserRemoteDataSource.UpdateUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> forgetPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.put(
        '/user/forgetPassword',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
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
              '${e.toString()}\nUpdateUserRemoteDataSource.ForgetPassword',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> uploadImage(
      {required File imageFile, required String id}) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'image.jpg', 
        ),
      });
      final eitherType = await networkService.put(
        '/user/uploadImage/$id',
        formData: formData,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final user = UserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setToken(user.token!);

            await GetIt.instance
                .get<AuthLocalDataSource>()
                .setCurrentUser(user);

            await GetIt.instance.get<AuthLocalDataSource>().refreshUserData();
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
          identifier: '${e.toString()}\nUpdateUserRemoteDataSource.UploadImage',
        ),
      );
    }
  }
}
