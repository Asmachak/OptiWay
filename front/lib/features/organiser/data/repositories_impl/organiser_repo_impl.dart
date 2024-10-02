import 'dart:io';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/data_sources/organiser_remote_data_src.dart';
import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';

class OrganiserRepositoryImpl implements OrganiserRepository {
  final OrganiserRemoteDataSource remoteDataSource;

  OrganiserRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, OrganiserModel>> signUpOrganiser(
      {required Map<String, dynamic> body}) async {
    return remoteDataSource.signUpOrganiser(body: body);
  }

  @override
  Future<Either<AppException, OrganiserModel>> loginOrganiser(
      {required String email, required String password}) async {
    return remoteDataSource.loginOrganiser(email: email, password: password);
  }

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> otpLogin(
      {required String email}) async {
    return remoteDataSource.otpLogin(email: email);
  }

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    return remoteDataSource.verifyOTP(email: email, otp: otp);
  }

  @override
  Future<Either<AppException, OrganiserModel>> editProfile(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editProfile(body: body, id: id);
  }

  @override
  Future<Either<AppException, OrganiserModel>> editPassword(
      {required Map<String, dynamic> body, required String id}) async {
    return remoteDataSource.editPassword(body: body, id: id);
  }

  @override
  Future<Either<AppException, OrganiserModel>> forgetPassword(
      {required Map<String, dynamic> body}) async {
    return remoteDataSource.forgetPassword(body: body);
  }

  @override
  Future<Either<AppException, OrganiserModel>> uploadImage(
      {required File imageFile, required String id}) async {
    return remoteDataSource.uploadImage(imageFile: imageFile, id: id);
  }

  @override
  Future<Either<AppException, List<OrganiserModel>>> getOrganisers() async {
    return remoteDataSource.getOrganisers();
  }

  @override
  Future<Either<AppException, String>> deleteOrganiser(
      {required String id}) async {
    return remoteDataSource.deleteOrganiser(id: id);
  }
}
