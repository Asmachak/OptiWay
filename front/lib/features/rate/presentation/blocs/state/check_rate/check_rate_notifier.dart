import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/use_cases/check_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/presentation/blocs/state/check_rate/check_state.dart';

class CheckRateNotifier extends StateNotifier<CheckRateState> {
  final CheckRateUseCases _checkrateUseCases;

  CheckRateNotifier(
    this._checkrateUseCases,
  ) : super(const CheckRateState.initial());

  Future<void> checkRate(String resid) async {
    state = const CheckRateState.loading();
    final result = await _checkrateUseCases.checkRateUseCase
        .call(CheckParams(resid: resid));
    result.fold(
      (failure) => state = CheckRateState.failure(failure),
      (response) {
        print("tay $response");
        if (response.id == null) {
          state = const CheckRateState.failed();
        } else {
          state = CheckRateState.success(rate: response);
        }
      },
    );
  }
}
