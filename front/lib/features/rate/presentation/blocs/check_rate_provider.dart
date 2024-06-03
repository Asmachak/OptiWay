import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/providers/rate_provider.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/presentation/blocs/state/check_rate/check_rate_notifier.dart';
import 'package:front/features/rate/presentation/blocs/state/check_rate/check_state.dart';

final checkRateNotifierProvider =
    StateNotifierProvider<CheckRateNotifier, CheckRateState>((ref) {
  final checkRateUsecases = ref.read(checkRateUsecaseProvider);

  final checkRateUseCases =
      CheckRateUseCases(checkRateUseCase: checkRateUsecases);
  return CheckRateNotifier(checkRateUseCases);
});
