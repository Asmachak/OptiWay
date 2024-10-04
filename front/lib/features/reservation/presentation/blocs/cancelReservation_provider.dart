import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservation_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservation/reservation_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/cancelReservation/cancel_reservation_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/cancelReservation/cancel_reservation_state.dart';

final CancelReservationNotifierProvider =
    StateNotifierProvider<CancelReservationNotifier, CancelReservationState>(
        (ref) {
  final cancelReservationUseCases = ref.read(cancelReservationUseCaseProvider);

  final reservationUseCases = CancelReservationUseCases(
      cancelReservationUsecase: cancelReservationUseCases);
  return CancelReservationNotifier(reservationUseCases);
});
