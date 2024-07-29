import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/add_reservationParking_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/reservationParking_uses_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationParking/reservationParking_state.dart';

class ReservationParkingNotifier
    extends StateNotifier<ReservationParkingState> {
  final ReservationParkingUseCases _reservationUseCases;

  ReservationParkingNotifier(
    this._reservationUseCases,
  ) : super(const ReservationParkingState.initial());

  Future<void> addReservationParking(Map<String, dynamic> body,
      String idparking, String iduser, String idvehicule) async {
    state = const ReservationParkingState.loading();
    final result = await _reservationUseCases.addReservationUseCases.call(
        AddReservationParkingParams(
            body: body,
            idparking: idparking,
            iduser: iduser,
            idvehicule: idvehicule));
    result.fold(
      (failure) => state = ReservationParkingState.failure(failure),
      (reservation) {
        state = ReservationParkingState.success(reservation: reservation);
      },
    );
  }
}
