import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/data_sources/reservationParking_remote_data_src.dart';

import 'package:front/features/reservation/data/models/reservation_parking/reservationParking_model.dart';
import 'package:front/features/reservation/domain/repositories/reservationParking_repo.dart';

class ReservationParkingRepositoryImpl implements ReservationParkingRepository {
  final ReservationParkingDataSource remoteDataSource;

  ReservationParkingRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, ReservationParkingModel>> addReservationParking({
    required Map<String, dynamic> body,
    required String iduser,
    required String idvehicule,
    required String idparking,
  }) {
    return remoteDataSource.addReservationParking(
        body: body,
        idparking: idparking,
        iduser: iduser,
        idvehicule: idvehicule);
  }
}
