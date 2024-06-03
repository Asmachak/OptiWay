import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/rate/domain/use_cases/give_reservation_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/domain/use_cases/update_rate_use_case.dart';
import 'package:front/features/rate/presentation/blocs/state/rate/rate_state.dart';

class RateNotifier extends StateNotifier<RateState> {
  final RateUseCases _rateUseCases;

  RateNotifier(
    this._rateUseCases,
  ) : super(const RateState.initial());

  Future<void> giveRate(
      String userid, String resid, Map<String, dynamic> body) async {
    state = const RateState.loading();
    final result = await _rateUseCases.giveReservationRateUsecases.call(
        GiveReservationRateParams(body: body, userid: userid, resid: resid));
    result.fold(
      (failure) => state = RateState.failure(failure),
      (response) {
        state = RateState.success(rateModel: response);
      },
    );
  }

  Future<void> updateRate(String resid, Map<String, dynamic> body) async {
    state = const RateState.loading();
    final result = await _rateUseCases.updateRateUsecases
        .call(UpdateRateParams(body: body, resid: resid));
    result.fold(
      (failure) => state = RateState.failure(failure),
      (response) {
        state = RateState.success(rateModel: response);
      },
    );
  }
}
