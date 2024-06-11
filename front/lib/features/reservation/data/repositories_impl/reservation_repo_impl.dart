import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/data_sources/reservation_remote_data_source.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationDataSource remoteDataSource;

  ReservationRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, ReservationModel>> addReservation({
    required Map<String, dynamic> body,
  }) {
    return remoteDataSource.addReservation(body: body);
  }

  @override
  Future<Either<AppException, List<ReservationModel>>> getReservation({
    required String iduser,
  }) {
    return remoteDataSource.getReservation(iduser: iduser);
  }

  @override
  Future<Either<AppException, ReservationModel>> extendReservation({
    required String id,
    required Map<String, dynamic> body,
  }) {
    return remoteDataSource.extendReservation(id: id, body: body);
  }
}
