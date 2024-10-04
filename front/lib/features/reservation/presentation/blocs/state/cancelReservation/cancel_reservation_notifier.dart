import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/reservation/cancel_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservation/reservation_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/cancelReservation/cancel_reservation_state.dart';

class CancelReservationNotifier extends StateNotifier<CancelReservationState> {
  final CancelReservationUseCases _reservationUseCases;

  CancelReservationNotifier(
    this._reservationUseCases,
  ) : super(const CancelReservationState.initial());

  Future<void> cancelReservation(String id) async {
    state = const CancelReservationState.loading();
    final result = await _reservationUseCases.cancelReservationUsecase
        .call(CancelReservationParams(id: id));
    result.fold(
      (failure) => state = CancelReservationState.failure(failure),
      (reservation) {
        state = const CancelReservationState.canceled();
      },
    );
  }
}
