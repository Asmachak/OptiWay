import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservationOrganiser/reservation_organiser_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationOrganiser_repo.dart';
import 'package:front/shared/use_case.dart';

class GetReservationOrganiserUsecases
    implements
        UseCase<List<ReservationOrganiserModel>,
            GetReservationOrganiserParams> {
  final ReservationOrganiserRepository reservationRepository;

  GetReservationOrganiserUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, List<ReservationOrganiserModel>>> call(
      GetReservationOrganiserParams params) async {
    return await reservationRepository.getEventReservationOrganiser(
      organiserid: params.organiserid,
    );
  }
}

class GetReservationOrganiserParams<T> {
  final String organiserid;

  GetReservationOrganiserParams({
    required this.organiserid,
  });
}
