import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/data_sources/reservationEvent_remote_data_src.dart';
import 'package:front/features/reservation/data/models/reservation_event/reservationEvent_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationEvent_repo.dart';

class ReservationEventRepositoryImpl implements ReservationEventRepository {
  final ReservationEventDataSource remoteDataSource;

  ReservationEventRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, ReservationEventModel>> addReservationEvent({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idevent,
  }) {
    return remoteDataSource.addReservationEvent(
        body: body,
        iduser: iduser,
        idvehicule: idvehicule,
        idevent: idevent);
  }
}
