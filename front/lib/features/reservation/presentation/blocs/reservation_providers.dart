import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservation_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservation_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_state.dart';

final reservationNotifierProvider =
    StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  final addReservationUseCases = ref.read(addReservationUseCaseProvider);
  final getReservationUseCases = ref.read(getReservationUseCaseProvider);

  final reservationUseCases = ReservationUseCases(
    addReservationUseCases: addReservationUseCases,
    getReservationUsecases: getReservationUseCases,
  );
  return ReservationNotifier(reservationUseCases);
});
