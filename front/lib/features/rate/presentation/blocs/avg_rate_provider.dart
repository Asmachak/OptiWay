import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/providers/avg_rate_provider.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/presentation/blocs/state/average_rate.dart/avg_rate_notifier.dart';
import 'package:front/features/rate/presentation/blocs/state/average_rate.dart/avg_rate_state.dart';

final avgRateNotifierProvider =
    StateNotifierProvider<AvgRateNotifier, AvgRateState>((ref) {
  final avgRateUsecases = ref.read(getAvgRateUsecaseProvider);

  final avgRateUseCases = AvgRateUseCases(avgRateUseCase: avgRateUsecases);
  return AvgRateNotifier(avgRateUseCases);
});
