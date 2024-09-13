import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reservation/data/models/reservationOrganiser/reservation_organiser_model.dart';

abstract class ReservationOrganiserDataSource {
  Future<Either<AppException, List<ReservationOrganiserModel>>>
      getEventReservationOrganiser({
    required String organiserid,
  });
}

class ReservationOrganiserRemoteDataSource
    implements ReservationOrganiserDataSource {
  final NetworkService networkService;

  ReservationOrganiserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, List<ReservationOrganiserModel>>>
      getEventReservationOrganiser({
    required String organiserid,
  }) async {
    try {
      final eitherType = await networkService.get(
        "/reservationOrganiser/$organiserid",
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<ReservationOrganiserModel> reservations = [];
          if (response.data is List) {
            reservations = List<ReservationOrganiserModel>.from(response.data
                .map((x) => ReservationOrganiserModel.fromJson(x)));
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
              '${e.toString()}\nReservationOrganiserRemoteDataSource.AddReservations',
        ),
      );
    }
  }
}
