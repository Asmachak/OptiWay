import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reservation/data/models/reservation/reservation_model.dart';

abstract class ReservationDataSource {
  Future<Either<AppException, ReservationModel>> addReservation({
    required Map<String, dynamic> body,
  });
  Future<Either<AppException, List<ReservationModel>>> getReservation({
    required String iduser,
  });
  Future<Either<AppException, ReservationModel>> extendReservation({
    required String id,
    required Map<String, dynamic> body,
  });
  Future<Either<AppException, String>> cancelReservation({
    required String id,
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
              '${e.toString()}\nReservationRemoteDataSource.AddReservations',
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
              '${e.toString()}\nRervationReservationRemoteDataSource.GetReservations',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ReservationModel>> extendReservation({
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
          return Right(ReservationModel.fromJson(response.data));
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nReservationRemoteDataSource.ExtendReservations',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, String>> cancelReservation({
    required String id,
  }) async {
    try {
      final eitherType = await networkService.post('/cancelReservation/$id');
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          if (response.data == "Success") {
            return Right(response.data);
          } else {
            return Left("erreur" as AppException);
          }
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nReservationRemoteDataSource.CancelReservations',
        ),
      );
    }
  }
}
