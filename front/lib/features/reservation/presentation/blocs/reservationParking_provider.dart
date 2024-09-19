import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservationParking_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/reservationParking_uses_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationParking/reservationParking_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationParking/reservationParking_state.dart';

final reservationParkingNotifierProvider =
    StateNotifierProvider<ReservationParkingNotifier, ReservationParkingState>(
        (ref) {
  final addReservationParkingUseCases =
      ref.read(addReservationParkingUseCaseProvider);
  final getAllReservationParkingUseCases =
      ref.read(getAllReservationParkingUseCaseProvider);

  final reservationUseCases = ReservationParkingUseCases(
    addReservationUseCases: addReservationParkingUseCases,
    getAllReservationUseCases: getAllReservationParkingUseCases,
  );
  return ReservationParkingNotifier(reservationUseCases);
});
