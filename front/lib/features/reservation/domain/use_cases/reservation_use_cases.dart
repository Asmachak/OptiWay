import 'package:front/features/reservation/domain/use_cases/add_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/get_reservation_use_case.dart';

class ReservationUseCases {
  final AddReservationUsecases addReservationUseCases;
  final GetReservationUsecases getReservationUsecases;

  ReservationUseCases({
    required this.addReservationUseCases,
    required this.getReservationUsecases,
  });
}
