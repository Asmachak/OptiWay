import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/data_sources/remote_data_source.dart';
import 'package:front/features/user/data/models/login_response_model.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;

  UserRepositoryImpl(
    this.remoteDataSource,
    /* this.localDataSource*/
  );

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

  @override
  Future<Either<AppException, LoginResponseModel>> otpLogin(
      {required String email}) async {
    return remoteDataSource.otpLogin(email: email);
  }

  @override
  Future<Either<AppException, LoginResponseModel>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    return remoteDataSource.verifyOTP(email: email, otp: otp);
  }

  @override
  Future<Either<AppException, UserModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editProfile(body: body, id: id);
  }

  @override
  Future<Either<AppException, UserModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editPassword(body: body, id: id);
  }

  @override
  Future<Either<AppException, UserModel>> uploadImage(
      {required File imageFile, required String id}) async {
    return remoteDataSource.uploadImage(imageFile: imageFile, id: id);
  }
}
