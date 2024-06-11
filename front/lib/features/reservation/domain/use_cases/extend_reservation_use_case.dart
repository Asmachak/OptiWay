import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';
import 'package:front/shared/use_case.dart';

class ExtendReservationUsecases
    implements UseCase<ReservationModel, ExtendReservationParams> {
  final ReservationRepository reservationRepository;

  ExtendReservationUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, ReservationModel>> call(
      ExtendReservationParams params) async {
    return await reservationRepository.addReservation(body: params.body);
  }
}

class ExtendReservationParams<T> {
  final Map<String, dynamic> body;
  final String id;

  ExtendReservationParams({
    required this.body,
    required this.id,
  });
}
