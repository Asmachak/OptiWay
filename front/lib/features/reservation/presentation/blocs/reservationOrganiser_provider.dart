import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservationOrganiser_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservationOrganiser/reservationOrganiser_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationOrganiser/reservationOrganiser_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationOrganiser/reservationOrganiser_state.dart';

final reservationOrganiserNotifierProvider = StateNotifierProvider<
    ReservationOrganiserNotifier, ReservationOrganiserState>((ref) {
  final getReservationOrganiserUseCases =
      ref.read(getReservationOrganiserUseCaseProvider);

  final reservationUseCases = ReservationOrganiserUseCases(
    getReservationOrganiserUsecases: getReservationOrganiserUseCases,
  );
  return ReservationOrganiserNotifier(reservationUseCases);
});
