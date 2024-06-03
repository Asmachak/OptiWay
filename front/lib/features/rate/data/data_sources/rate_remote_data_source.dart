import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

abstract class RateDataSource {
  Future<Either<AppException, RateModel>> giveReservationRate(
      {required Map<String, dynamic> body,
      required String userid,
      required String resid});
  Future<Either<AppException, RateModel>> checkRate({required String resid});
  Future<Either<AppException, RateModel>> updateRate(
      {required Map<String, dynamic> body, required String resid});
}

class RateRemoteDataSource implements RateDataSource {
  final NetworkService networkService;

  RateRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, RateModel>> giveReservationRate(
      {required Map<String, dynamic> body,
      required String userid,
      required String resid}) async {
    try {
      final eitherType = await networkService.post(
        '/rate/$userid/$resid',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final rate = RateModel.fromJson(response.data);
          return Right(rate);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nRateRateRemoteDataSource.GiveRate',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, RateModel>> checkRate({
    required String resid,
  }) async {
    try {
      final eitherType = await networkService.get(
        '/rate/$resid',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          print("response data src $response");
          print("response.data == {} ::::::::: ${response.data == {}}");
          if (response.data == {}) {
            return Right(response.data);
          } else {
            final rate = RateModel.fromJson(response.data);

            return Right(rate);
          }
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nRateRateRemoteDataSource.checkRateRate',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, RateModel>> updateRate(
      {required String resid, required Map<String, dynamic> body}) async {
    try {
      final eitherType =
          await networkService.post('/update/rate/$resid', data: body);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final rate = RateModel.fromJson(response.data);

          return Right(rate);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRateRateRemoteDataSource.updateRateRate',
        ),
      );
    }
  }
}
