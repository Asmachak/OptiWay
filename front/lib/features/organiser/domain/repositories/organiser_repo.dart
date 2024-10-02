import 'dart:io';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';

abstract class OrganiserRepository {
  Future<Either<AppException, OrganiserModel>> signUpOrganiser(
      {required Map<String, dynamic> body});
  Future<Either<AppException, OrganiserModel>> loginOrganiser(
      {required String email, required String password});
  Future<Either<AppException, LoginResponseOrganiserModel>> otpLogin(
      {required String email});
  Future<Either<AppException, LoginResponseOrganiserModel>> verifyOTP({
    required String email,
    required String otp,
  });
  Future<Either<AppException, OrganiserModel>> editProfile({
    required Map<String, dynamic> body,
    required String id,
  });
  Future<Either<AppException, OrganiserModel>> editPassword({
    required Map<String, dynamic> body,
    required String id,
  });
  Future<Either<AppException, OrganiserModel>> forgetPassword(
      {required Map<String, dynamic> body});
  Future<Either<AppException, OrganiserModel>> uploadImage(
      {required File imageFile, required String id});
  Future<Either<AppException, List<OrganiserModel>>> getOrganisers();
  Future<Either<AppException, String>> deleteOrganiser({required String id});
}
