import 'package:dio/src/form_data.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

import 'either.dart';
import 'response.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, Response>> patch(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, Response>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    FormData formData,
  });
  Future<Either<AppException, Response>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });
}
