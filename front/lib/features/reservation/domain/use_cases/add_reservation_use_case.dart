import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reservation/data/models/reservation_model.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';
import 'package:front/shared/use_case.dart';

class AddReservationUsecases
    implements UseCase<ReservationModel, AddReservationParams> {
  final ReservationRepository reservationRepository;

  AddReservationUsecases(this.reservationRepository);
  @override
  Future<Either<AppException, ReservationModel>> call(
      AddReservationParams params) async {
    return await reservationRepository.addReservation(body: params.body);
  }
}

class AddReservationParams<T> {
  final Map<String, dynamic> body;
  AddReservationParams({
    required this.body,
  });
}
