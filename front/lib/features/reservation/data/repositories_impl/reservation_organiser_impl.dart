import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/data_sources/reservationOrganiser_remote_data_src.dart';
import 'package:front/features/reservation/data/models/reservationOrganiser/reservation_organiser_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationOrganiser_repo.dart';

class ReservationOrganiserRepositoryImpl
    implements ReservationOrganiserRepository {
  final ReservationOrganiserDataSource remoteDataSource;

  ReservationOrganiserRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, List<ReservationOrganiserModel>>>
      getEventReservationOrganiser({
    required String organiserid,
  }) {
    return remoteDataSource.getEventReservationOrganiser(
        organiserid: organiserid);
  }
}
