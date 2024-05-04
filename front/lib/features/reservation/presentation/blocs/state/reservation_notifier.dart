import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/add_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservation_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_state.dart';

class ReservationNotifier extends StateNotifier<ReservationState> {
  final ReservationUseCases _reservationUseCases;

  ReservationNotifier(
    this._reservationUseCases,
  ) : super(const ReservationState.initial());

  Future<void> addReservation(Map<String, dynamic> body) async {
    state = const ReservationState.loading();
    final result = await _reservationUseCases.addReservationUseCases
        .call(AddReservationParams(
      body: body,
    ));
    result.fold(
      (failure) => state = ReservationState.failure(failure),
      (reservation) {
        state = ReservationState.success(reservation: reservation);
      },
    );
  }
}
