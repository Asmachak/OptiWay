import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationParking_repo.dart';
import 'package:front/shared/use_case.dart';

class GetAllReservationParkingUsecases
    implements UseCase<List<ReservationParkingModel>, NoParams> {
  final ReservationParkingRepository reservationRepository;

  GetAllReservationParkingUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, List<ReservationParkingModel>>> call(
      noParams) async {
    return await reservationRepository.getAllReservationParking();
  }
}
