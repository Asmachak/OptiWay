import 'package:dio/dio.dart';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/exception_handler_mixin.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/response.dart' as response;
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:get_it/get_it.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  final Dio dio;
  // ignore: non_constant_identifier_names
  Duration DEFAULT_TIMEOUT = const Duration(seconds: 30);
  DioNetworkService(this.dio) {
    // this throws error while running test

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        receiveTimeout: DEFAULT_TIMEOUT,
      );
  @override
  String get baseUrl => AppConfigs.baseUrl;

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
        'Authorisation':
            "Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}"
      };
  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    // if (!kTestMode) {
    dio.options.headers = header;
    // }
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) {
    String finalEndpoint = '$baseUrl$endpoint';

    final res = handleException(
      () => dio.post(
        finalEndpoint,
        data: data,
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> put(String endpoint,
      {FormData? formData, Map<String, dynamic>? body}) async {
    String finalEndpoint = '$baseUrl$endpoint';
    final res = await handleException(() async {
      if (formData != null) {
        return await dio.put(
          finalEndpoint,
          data: formData,
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}',
            },
          ),
        );
      } else {
        return await dio.put(
          finalEndpoint,
          data: body,
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}',
            },
          ),
        );
      }
    }, endpoint: endpoint);
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    String finalEndpoint = '$baseUrl$endpoint';

    final res = handleException(
      () => dio.get(
        finalEndpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorisation':
                "Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> patch(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    String finalEndpoint = '$baseUrl$endpoint';

    final res = handleException(
      () => dio.patch(
        finalEndpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorisation':
                "Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}) {
    String finalEndpoint = '$baseUrl$endpoint';

    final res = handleException(
      () => dio.delete(
        finalEndpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorisation':
                "Bearer ${GetIt.instance.get<AuthLocalDataSource>().token}"
          },
        ),
      ),
      endpoint: endpoint,
    );
    return res;
  }
}

class AppConfigs {
  static String baseUrl = 'http://10.0.2.2:8000';
}
