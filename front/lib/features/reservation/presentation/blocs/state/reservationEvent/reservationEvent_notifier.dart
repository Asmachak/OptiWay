import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/reservationEvent/add_reservationEvent_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationEvent/reservationEvent_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationEvent/reservationEvent_state.dart';

class ReservationEventNotifier extends StateNotifier<ReservationEventState> {
  final ReservationEventUseCases _reservationUseCases;

  ReservationEventNotifier(
    this._reservationUseCases,
  ) : super(const ReservationEventState.initial());

  Future<void> addReservationEvent(Map<String, dynamic> body, String iduser,
      String idvehicule, String idevent) async {
    state = const ReservationEventState.loading();
    final result = await _reservationUseCases.addReservationUseCases.call(
        AddReservationEventParams(
            body: body,
            iduser: iduser,
            idvehicule: idvehicule,
            idevent: idevent));
    result.fold(
      (failure) => state = ReservationEventState.failure(failure),
      (reservation) {
        state = ReservationEventState.success(reservation: reservation);
      },
    );
  }
}
