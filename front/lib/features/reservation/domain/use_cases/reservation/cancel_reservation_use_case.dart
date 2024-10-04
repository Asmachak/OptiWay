import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';
import 'package:front/shared/use_case.dart';

class CancelReservationUsecase
    implements UseCase<String, CancelReservationParams> {
  final ReservationRepository reservationRepository;

  CancelReservationUsecase(this.reservationRepository);
  @override
  Future<Either<AppException, String>> call(
      CancelReservationParams params) async {
    return await reservationRepository.cancelReservation(id: params.id);
  }
}

class CancelReservationParams<T> {
  final String id;
  CancelReservationParams({
    required this.id,
  });
}
