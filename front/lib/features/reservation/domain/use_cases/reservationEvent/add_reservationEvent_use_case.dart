import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_event/reservationEvent_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationEvent_repo.dart';
import 'package:front/shared/use_case.dart';

class AddReservationEventUsecases
    implements UseCase<ReservationEventModel, AddReservationEventParams> {
  final ReservationEventRepository reservationRepository;

  AddReservationEventUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, ReservationEventModel>> call(
      AddReservationEventParams params) async {
    return await reservationRepository.addReservationEvent(
      body: params.body,
      iduser: params.iduser,
      idvehicule: params.idvehicule,
      idevent: params.idevent,
    );
  }
}

class AddReservationEventParams<T> {
  final Map<String, dynamic> body;
  final String iduser;
  final String idvehicule;
  final String idevent;

  AddReservationEventParams({
    required this.body,
    required this.iduser,
    required this.idvehicule,
    required this.idevent,
  });
}
