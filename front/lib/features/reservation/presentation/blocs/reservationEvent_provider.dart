import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservationEvent_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservationEvent/reservationEvent_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationEvent/reservationEvent_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservationEvent/reservationEvent_state.dart';

final reservationEventNotifierProvider =
    StateNotifierProvider<ReservationEventNotifier, ReservationEventState>(
        (ref) {
  final addReservationEventUseCases =
      ref.read(addReservationEventUseCaseProvider);

  final reservationUseCases = ReservationEventUseCases(
    addReservationUseCases: addReservationEventUseCases,
  );
  return ReservationEventNotifier(reservationUseCases);
});
