import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';

abstract class ReservationRepository {
  Future<Either<AppException, ReservationModel>> addReservation({
    required Map<String, dynamic> body,
  });
  Future<Either<AppException, List<ReservationModel>>> getReservation(
      {required String iduser});
}
