import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/parking/data/models/parking_model.dart';

abstract class ParkingDataSource {
  Future<Either<AppException, List<ParkingModel>>> getAllParkings();
  // Future<Either<AppException, ParkingModel>> getParkingID(
  //     {required String idparking});
}

class ParkingRemoteDataSource implements ParkingDataSource {
  final NetworkService networkService;

  ParkingRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, List<ParkingModel>>> getAllParkings() async {
    try {
      final eitherType = await networkService.get(
        '/parking',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<ParkingModel> parkings = [];
          if (response.data != null) {
            parkings = List<ParkingModel>.from(
                response.data.map((x) => ParkingModel.fromJson(x)));
          }
          return Right(parkings);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nParkingRemoteDataSource.GetAllParkings',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ParkingModel>> getParkingByID({
    required String idparking,
  }) async {
    try {
      final eitherType = await networkService.get(
        '/parking/$idparking',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          return Right(ParkingModel.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nParkingRemoteDataSource.GetParkingByID',
        ),
      );
    }
  }
}
