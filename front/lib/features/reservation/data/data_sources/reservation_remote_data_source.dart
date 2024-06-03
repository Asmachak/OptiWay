import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';

abstract class ReservationDataSource {
  Future<Either<AppException, ReservationModel>> addReservation({
    required Map<String, dynamic> body,
  });
  Future<Either<AppException, List<ReservationModel>>> getReservation({
    required String iduser,
  });
}

class ReservationRemoteDataSource implements ReservationDataSource {
  final NetworkService networkService;

  ReservationRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ReservationModel>> addReservation({
    required Map<String, dynamic> body,
  }) async {
    try {
      final eitherType = await networkService.post(
        '/reservation/addRes',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final reservation = ReservationModel.fromJson(response.data);
          return Right(reservation);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRegisterReservationRemoteDataSource.AddReservations',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<ReservationModel>>> getReservation({
    required String iduser,
  }) async {
    try {
      final eitherType = await networkService.get(
        '/reservation/$iduser',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<ReservationModel> reservations = [];
          if (response.data is List) {
            reservations = List<ReservationModel>.from(
                response.data.map((x) => ReservationModel.fromJson(x)));
          }
          return Right(reservations);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nRegisterReservationRemoteDataSource.GetReservations',
        ),
      );
    }
  }
}
