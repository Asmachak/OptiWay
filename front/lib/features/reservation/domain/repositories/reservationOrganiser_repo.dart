import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservationOrganiser/reservation_organiser_model.dart';

abstract class ReservationOrganiserRepository {
  Future<Either<AppException, List<ReservationOrganiserModel>>>
      getEventReservationOrganiser({
    required String organiserid,
  });
}
