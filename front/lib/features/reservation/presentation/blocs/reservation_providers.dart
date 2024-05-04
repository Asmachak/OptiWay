import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/domain/providers.dart/reservation_provider.dart';
import 'package:front/features/reservation/domain/use_cases/reservation_use_cases.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_notifier.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation_state.dart';
import 'package:front/features/user/domain/providers/user_provider.dart';
import 'package:front/features/user/domain/usescases/user/auth_use_cases.dart';
import 'package:front/features/user/presentation/blocs/state/auth_notifier.dart';
import 'package:front/features/user/presentation/blocs/state/auth/auth_state.dart';

final reservationNotifierProvider =
    StateNotifierProvider<ReservationNotifier, ReservationState>((ref) {
  final addReservationUseCases = ref.read(addReservationUseCaseProvider);
  // final updatePasswordUseCases = ref.read(updatePasswordUseCaseProvider);

  final reservationUseCases = ReservationUseCases(
    addReservationUseCases: addReservationUseCases,
    // updatePasswordUseCases: updatePasswordUseCases,
  );
  // final hiveBox = ref.watch(hiveBoxProvider);
  return ReservationNotifier(reservationUseCases);
});
