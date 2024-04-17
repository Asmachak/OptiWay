import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/login_response_model.dart';
import 'package:front/features/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<AppException, UserModel>> signUpUser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, UserModel>> loginUser(
      {required String email, required String password});
  Future<Either<AppException, LoginResponseModel>> otpLogin(
      {required String email});
  Future<Either<AppException, LoginResponseModel>> verifyOTP({
    required String email,
    required String otp,
  });
  Future<Either<AppException, UserModel>> editProfile({
    required Map<String, dynamic> body,
    required String id,
  });
  Future<Either<AppException, UserModel>> uploadImage(
      {required File imageFile, required String id});
}
