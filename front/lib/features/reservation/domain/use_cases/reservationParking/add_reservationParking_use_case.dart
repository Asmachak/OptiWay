import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationParking_repo.dart';
import 'package:front/shared/use_case.dart';

class AddReservationParkingUsecases
    implements UseCase<ReservationParkingModel, AddReservationParkingParams> {
  final ReservationParkingRepository reservationRepository;

  AddReservationParkingUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, ReservationParkingModel>> call(
      AddReservationParkingParams params) async {
    return await reservationRepository.addReservationParking(
        body: params.body,
        idparking: params.idparking,
        iduser: params.iduser,
        idvehicule: params.idvehicule);
  }
}

class AddReservationParkingParams<T> {
  final Map<String, dynamic> body;
  final String iduser;
  final String idvehicule;
  final String idparking;
  AddReservationParkingParams({
    required this.body,
    required this.iduser,
    required this.idvehicule,
    required this.idparking,
  });
}
