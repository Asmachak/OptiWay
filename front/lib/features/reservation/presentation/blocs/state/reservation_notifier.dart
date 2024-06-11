import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/add_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/extend_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/get_reservation_use_case.dart';
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

  Future<void> getReservation(String iduser) async {
    state = const ReservationState.loading();
    final result = await _reservationUseCases.getReservationUsecases
        .call(GetReservationParams(
      iduser: iduser,
    ));
    result.fold(
      (failure) => state = ReservationState.failure(failure),
      (reservations) {
        state = ReservationState.loaded(reservations: reservations);
      },
    );
  }

  Future<void> extendReservation(String id, Map<String, dynamic> body) async {
    state = const ReservationState.loading();
    final result = await _reservationUseCases.extendReservationUsecases
        .call(ExtendReservationParams(body: body, id: id));
    result.fold(
      (failure) => state = ReservationState.failure(failure),
      (reservation) {
        state = ReservationState.extended(reservation: reservation);
      },
    );
  }
}
