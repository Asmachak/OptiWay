import 'dart:io';
import 'package:dio/dio.dart';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';

import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

abstract class OrganiserDataSource {
  Future<Either<AppException, OrganiserModel>> signUpOrganiser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, OrganiserModel>> loginOrganiser(
      {required String email, required String password});
  Future<Either<AppException, LoginResponseOrganiserModel>> otpLogin(
      {required String email});
  Future<Either<AppException, LoginResponseOrganiserModel>> verifyOTP(
      {required String email, required String otp});
  Future<Either<AppException, OrganiserModel>> editProfile(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, OrganiserModel>> editPassword(
      {required Map<String, dynamic> body, required String id});
  Future<Either<AppException, OrganiserModel>> forgetPassword(
      {required Map<String, dynamic> body});
  Future<Either<AppException, OrganiserModel>> uploadImage(
      {required File imageFile, required String id});
  Future<Either<AppException, List<OrganiserModel>>> getOrganisers();
}

class OrganiserRemoteDataSource implements OrganiserDataSource {
  final NetworkService networkService;

  OrganiserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, OrganiserModel>> signUpOrganiser(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.post(
        '/organiser/signup',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final organiser = OrganiserModel.fromJson(response.data);
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRegisterOrganiserRemoteDataSource.SignupOrganiser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, OrganiserModel>> loginOrganiser({
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
        '/organiser/login',
        data: body,
      );

      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final organiser = OrganiserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setToken(organiser.token!);
            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setCurrentOrganiser(organiser);
          }
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nLoginOrganiserRemoteDataSource.loginOrganiser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> otpLogin(
      {required String email}) async {
    try {
      final body = {
        'email': email,
      };
      final eitherType = await networkService.post(
        '/organiser/otp-login',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final login = LoginResponseOrganiserModel.fromJson(response.data);
          return Right(login);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nLoginOTPOrganiserRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> verifyOTP(
      {required String email, required String otp}) async {
    try {
      final body = {'email': email, 'otp': otp};
      final eitherType = await networkService.post(
        '/organiser/otp-verify',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final verify = LoginResponseOrganiserModel.fromJson(response.data);
          return Right(verify);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nLoginOTPOrganiserRemoteDataSource.loginOTP',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, OrganiserModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/organiser/update/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final organiser = OrganiserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setToken(organiser.token!);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setCurrentOrganiser(organiser);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .refreshOrganiserData();
          }
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateOrganiserRemoteDataSource.UpdateOrganiser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, OrganiserModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    try {
      final eitherType = await networkService.put(
        '/organiser/editPassword/$id',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final organiser = OrganiserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setToken(organiser.token!);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setCurrentOrganiser(organiser);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .refreshOrganiserData();
          }
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateOrganiserRemoteDataSource.UpdateOrganiser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, OrganiserModel>> forgetPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.put(
        '/organiser/forgetPassword',
        body: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final organiser = OrganiserModel.fromJson(response.data);
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateOrganiserRemoteDataSource.ForgetPassword',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, OrganiserModel>> uploadImage(
      {required File imageFile, required String id}) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'image.jpg', // Provide a filename for the uploaded file
        ),
      });
      final eitherType = await networkService.put(
        '/organiser/uploadImage/$id',
        formData: formData,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final organiser = OrganiserModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setToken(organiser.token!);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .setCurrentOrganiser(organiser);

            await GetIt.instance
                .get<OrganiserLocalDataSource>()
                .refreshOrganiserData();
          }
          return Right(organiser);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nUpdateOrganiserRemoteDataSource.UploadImage',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<OrganiserModel>>> getOrganisers() async {
    try {
      final eitherType = await networkService.get(
        '/admin/organisers',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          List<OrganiserModel> users = [];
          if (response.data != null) {
            users = List<OrganiserModel>.from(
                response.data.map((x) => OrganiserModel.fromJson(x)));
          }
          return Right(users);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nUserRemoteDataSource.getUsers',
        ),
      );
    }
  }
}
