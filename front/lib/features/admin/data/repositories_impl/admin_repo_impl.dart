import 'dart:io';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/data_sources/admin_remote_data_src.dart';
import 'package:front/features/admin/data/models/admin_login_response_model.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, AdminModel>> signUpAdmin(
      {required Map<String, dynamic> body}) async {
    return remoteDataSource.signUpAdmin(body: body);
  }

  @override
  Future<Either<AppException, AdminModel>> loginAdmin(
      {required String email, required String password}) async {
    return remoteDataSource.loginAdmin(email: email, password: password);
  }

  @override
  Future<Either<AppException, AdminLoginResponseModel>> otpLogin(
      {required String email}) async {
    return remoteDataSource.otpLogin(email: email);
  }

  @override
  Future<Either<AppException, AdminLoginResponseModel>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    return remoteDataSource.verifyOTP(email: email, otp: otp);
  }

  @override
  Future<Either<AppException, AdminModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editProfile(body: body, id: id);
  }

  @override
  Future<Either<AppException, AdminModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editPassword(body: body, id: id);
  }

  @override
  Future<Either<AppException, AdminModel>> forgetPassword(
      {required Map<String, dynamic> body}) async {
    return remoteDataSource.forgetPassword(body: body);
  }

  @override
  Future<Either<AppException, AdminModel>> uploadImage(
      {required File imageFile, required String id}) async {
    return remoteDataSource.uploadImage(imageFile: imageFile, id: id);
  }
}
