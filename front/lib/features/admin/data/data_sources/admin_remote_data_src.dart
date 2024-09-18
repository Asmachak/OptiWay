import 'dart:io';
import 'package:dio/dio.dart';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';
import 'package:front/features/admin/data/models/admin_login_response_model.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class AdminDataSource {
  Future<Either<AppException, AdminModel>> signUpAdmin(
      {required Map<String, dynamic> body});
  Future<Either<AppException, AdminModel>> loginAdmin(
      {required String email, required String password});
  Future<Either<AppException, AdminLoginResponseModel>> otpLogin(
      {required String email});
  Future<Either<AppException, AdminLoginResponseModel>> verifyOTP(
      {required String email, required String otp});
  Future<Either<AppException, AdminModel>> editProfile(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, AdminModel>> editPassword(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, AdminModel>> forgetPassword(
      {required Map<String, dynamic> body});
  Future<Either<AppException, AdminModel>> uploadImage(
      {required File imageFile, required String id});
}

class AdminRemoteDataSource implements AdminDataSource {
  final NetworkService networkService;

  AdminRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, AdminModel>> signUpAdmin(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.post(
        '/admin/signup',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final admin = AdminModel.fromJson(response.data);
          return Right(admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRegisterAdminRemoteDataSource.SignupAdmin',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminModel>> loginAdmin({
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
            identifier: 'LoginOrganiserRemoteDataSource.loginOrganiser',
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
        '/admin/login',
        data: body,
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final admin = AdminModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setToken(admin.token!);
            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setCurrentAdmin(admin);
          }
          return Right(admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nLoginAdminRemoteDataSource.loginOrganiser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminLoginResponseModel>> otpLogin(
      {required String email}) async {
    try {
      final body = {
        'email': email,
      };
      final eitherType = await networkService.post(
        '/admin/otp-login',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final login = AdminLoginResponseModel.fromJson(response.data);
          return Right(login);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginOTPAdminRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminLoginResponseModel>> verifyOTP(
      {required String email, required String otp}) async {
    try {
      final body = {'email': email, 'otp': otp};
      final eitherType = await networkService.post(
        '/admin/otp-verify',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final verify = AdminLoginResponseModel.fromJson(response.data);
          return Right(verify);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nLoginOTPAdminRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/admin/update/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final Admin = AdminModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setToken(Admin.token!);

            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setCurrentAdmin(Admin);

            await GetIt.instance.get<AdminLocalDataSource>().refreshAdminData();
          }
          return Right(Admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateAdminRemoteDataSource.UpdateAdmin',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/admin/editPassword/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final Admin = AdminModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setToken(Admin.token!);

            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setCurrentAdmin(Admin);

            await GetIt.instance.get<AdminLocalDataSource>().refreshAdminData();
          }
          return Right(Admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateAdminRemoteDataSource.UpdateAdmin',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminModel>> forgetPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.put(
        '/admin/forgetPassword',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final Admin = AdminModel.fromJson(response.data);
          return Right(Admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateAdminRemoteDataSource.ForgetPassword',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, AdminModel>> uploadImage(
      {required File imageFile, required String id}) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'image.jpg', // Provide a filename for the uploaded file
        ),
      });
      final eitherType = await networkService.put(
        '/admin/uploadImage/$id',
        formData: formData,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final Admin = AdminModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setToken(Admin.token!);

            await GetIt.instance
                .get<AdminLocalDataSource>()
                .setCurrentAdmin(Admin);

            await GetIt.instance.get<AdminLocalDataSource>().refreshAdminData();
          }
          return Right(Admin);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateAdminRemoteDataSource.UploadImage',
        ),
      );
    }
  }
}
