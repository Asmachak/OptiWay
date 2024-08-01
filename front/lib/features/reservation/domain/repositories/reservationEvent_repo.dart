import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_event/reservationEvent_model.dart';

abstract class ReservationEventRepository {
  Future<Either<AppException, ReservationEventModel>> addReservationEvent({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idevent,
  });
}
