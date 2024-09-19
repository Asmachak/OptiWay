import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';

abstract class ReservationParkingRepository {
  Future<Either<AppException, ReservationParkingModel>> addReservationParking({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idparking,
  });
  Future<Either<AppException, List<ReservationParkingModel>>>
      getAllReservationParking();
}
