import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/providers/rate_provider.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/presentation/blocs/state/rate/rate_notifier.dart';
import 'package:front/features/rate/presentation/blocs/state/rate/rate_state.dart';

final rateNotifierProvider =
    StateNotifierProvider<RateNotifier, RateState>((ref) {
  final giveReservationRateUsecases =
      ref.read(giveReservationRateUsecaseProvider);
  final updateRateUsecases = ref.read(updateRateUsecaseProvider);
  final rateUseCases = RateUseCases(
      giveReservationRateUsecases: giveReservationRateUsecases,
      updateRateUsecases: updateRateUsecases);
  return RateNotifier(rateUseCases);
});
