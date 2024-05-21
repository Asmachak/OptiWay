import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';
import 'package:front/shared/use_case.dart';

class GetReservationUsecases
    implements UseCase<List<ReservationModel>, GetReservationParams> {
  final ReservationRepository reservationRepository;

  GetReservationUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, List<ReservationModel>>> call(
      GetReservationParams params) async {
    return await reservationRepository.getReservation(iduser: params.iduser);
  }
}

class GetReservationParams<T> {
  final String iduser;
  GetReservationParams({
    required this.iduser,
  });
}
