import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

abstract class EventDataSource {
  Future<Either<AppException, RateModel>> moviesList(
      {required Map<String, dynamic> body,
      required String userid,
      required String resid});

}

class RateRemoteDataSource implements EventDataSource {
  final NetworkService networkService;

  RateRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, RateModel>> moviesList(
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


}
