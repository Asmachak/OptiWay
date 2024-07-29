import 'package:front/features/reservation/domain/use_cases/reservation/add_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservation/extend_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservation/get_reservation_use_case.dart';

class ReservationUseCases {
  final AddReservationUsecases addReservationUseCases;
  final GetReservationUsecases getReservationUsecases;
  final ExtendReservationUsecases extendReservationUsecases;

  ReservationUseCases({
    required this.addReservationUseCases,
    required this.getReservationUsecases,
    required this.extendReservationUsecases,
  });
}
