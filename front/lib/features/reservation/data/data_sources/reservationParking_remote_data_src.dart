import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';

abstract class ReservationParkingDataSource {
  Future<Either<AppException, ReservationParkingModel>> addReservationParking({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idparking,
  });
}

class ReservationParkingRemoteDataSource
    implements ReservationParkingDataSource {
  final NetworkService networkService;

  ReservationParkingRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ReservationParkingModel>> addReservationParking({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idparking,
  }) async {
    try {
      final eitherType = await networkService.post(
        '/reservationParking/addRes/$iduser/$idparking/$idvehicule',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final reservation = ReservationParkingModel.fromJson(response.data);
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
              '${e.toString()}\nReservationParkingRemoteDataSource.AddReservations',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<ReservationParkingModel>>> getReservation({
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
          List<ReservationParkingModel> reservations = [];
          if (response.data is List) {
            reservations = List<ReservationParkingModel>.from(
                response.data.map((x) => ReservationParkingModel.fromJson(x)));
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
              '${e.toString()}\nRegisterReservationParkingRemoteDataSource.GetReservations',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ReservationParkingModel>> extendReservation({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final eitherType =
          await networkService.post('/extendReservation/$id', data: body);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          return Right(ReservationParkingModel.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nReservationParkingRemoteDataSource.ExtendReservations',
        ),
      );
    }
  }
}
