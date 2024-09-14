import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/use_cases/avg_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/presentation/blocs/state/average_rate.dart/avg_rate_state.dart';

class AvgRateNotifier extends StateNotifier<AvgRateState> {
  final AvgRateUseCases _avgRateUseCases;

  AvgRateNotifier(
    this._avgRateUseCases,
  ) : super(const AvgRateState.initial());

  Future<void> avgRate(String id) async {
    state = const AvgRateState.loading();
    final result =
        await _avgRateUseCases.avgRateUseCase.call(AvgParams(id: id));
    result.fold(
      (failure) => state = AvgRateState.failure(failure),
      (response) {
        state = AvgRateState.success(rate: response);
      },
    );
  }
}
