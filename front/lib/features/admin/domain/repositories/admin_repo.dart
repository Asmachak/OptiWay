import 'dart:io';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_login_response_model.dart';
import 'package:front/features/admin/data/models/admin_model.dart';

abstract class AdminRepository {
  Future<Either<AppException, AdminModel>> signUpAdmin(
      {required Map<String, dynamic> body});
  Future<Either<AppException, AdminModel>> loginAdmin(
      {required String email, required String password});
  Future<Either<AppException, AdminLoginResponseModel>> otpLogin(
      {required String email});
  Future<Either<AppException, AdminLoginResponseModel>> verifyOTP({
    required String email,
    required String otp,
  });
  Future<Either<AppException, AdminModel>> editProfile({
    required Map<String, dynamic> body,
    required String id,
  });
  Future<Either<AppException, AdminModel>> editPassword({
    required Map<String, dynamic> body,
    required String id,
  });
  Future<Either<AppException, AdminModel>> forgetPassword(
      {required Map<String, dynamic> body});
  Future<Either<AppException, AdminModel>> uploadImage(
      {required File imageFile, required String id});
}
