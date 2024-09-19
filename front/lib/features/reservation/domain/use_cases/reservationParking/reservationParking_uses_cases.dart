import 'package:front/features/reservation/domain/use_cases/reservationParking/add_reservationParking_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/get_all_reservationParking_use_case.dart';

class ReservationParkingUseCases {
  final AddReservationParkingUsecases addReservationUseCases;
  final GetAllReservationParkingUsecases getAllReservationUseCases;

  ReservationParkingUseCases({
    required this.addReservationUseCases,
    required this.getAllReservationUseCases,
  });
}
