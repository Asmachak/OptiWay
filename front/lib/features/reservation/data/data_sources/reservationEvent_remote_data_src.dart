import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reservation/data/models/reservation_event/reservationEvent_model.dart';
import 'package:intl/intl.dart';

abstract class ReservationEventDataSource {
  Future<Either<AppException, ReservationEventModel>> addReservationEvent({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idevent,
  });
}

class ReservationEventRemoteDataSource implements ReservationEventDataSource {
  final NetworkService networkService;

  ReservationEventRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ReservationEventModel>> addReservationEvent({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idevent,
  }) async {
    try {
      final eitherType = await networkService.post(
        '/reservationEvent/addRes/$iduser/$idvehicule/$idevent',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          print("response.data ${response.data}");
          final reservation = ReservationEventModel.fromJson(response.data);
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
              '${e.toString()}\nReservationEventRemoteDataSource.AddReservations',
        ),
      );
    }
  }
}
