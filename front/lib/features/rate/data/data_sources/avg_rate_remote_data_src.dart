import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/rate/data/models/avg_rate_model.dart';

abstract class AvgRateDataSource {
  Future<Either<AppException, RateAvgModel>> getAvgRate({required String id});
}

class AvgRateRemoteDataSource implements AvgRateDataSource {
  final NetworkService networkService;

  AvgRateRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, RateAvgModel>> getAvgRate(
      {required String id}) async {
    try {
      final eitherType = await networkService.get(
        '/avgRate/$id',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // Check if the response indicates no reservations or no rates
          if (response.data == null || response.data['averageRate'] == null) {
            // Gracefully handle no reservations or no rates
            return Right(RateAvgModel(
                averageRate: 0.0)); // or any default value like null
          }
          // Parse the valid response
          final rate = RateAvgModel.fromJson(response.data);
          return Right(rate);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nRateAvgRateRemoteDataSource.GiveRate',
        ),
      );
    }
  }
}
