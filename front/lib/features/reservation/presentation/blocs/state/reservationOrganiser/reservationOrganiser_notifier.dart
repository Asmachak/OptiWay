import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/use_cases/reservationOrganiser/getReservationOrganiser_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationOrganiser/reservationOrganiser_use_cases.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/add_reservationParking_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/reservationParking_uses_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationOrganiser/reservationOrganiser_state.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationParking/reservationParking_state.dart';

class ReservationOrganiserNotifier
    extends StateNotifier<ReservationOrganiserState> {
  final ReservationOrganiserUseCases _reservationUseCases;

  ReservationOrganiserNotifier(
    this._reservationUseCases,
  ) : super(const ReservationOrganiserState.initial());

  Future<void> getReservationOrganiser(String oragniserid) async {
    state = const ReservationOrganiserState.loading();
    final result = await _reservationUseCases.getReservationOrganiserUsecases
        .call(GetReservationOrganiserParams(organiserid: oragniserid));
    result.fold(
      (failure) => state = ReservationOrganiserState.failure(failure),
      (reservations) {
        state = ReservationOrganiserState.loaded(reservations: reservations);
      },
    );
  }
}
