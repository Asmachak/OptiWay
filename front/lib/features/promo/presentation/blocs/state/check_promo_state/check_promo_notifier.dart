import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/use_cases/check_promo_use_case.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/check_promo_state/check_promo_state.dart';

class CheckPromoNotifier extends StateNotifier<CheckPromoState> {
  final CheckPromoUseCases _promoUseCases;

  CheckPromoNotifier(
    this._promoUseCases,
  ) : super(const CheckPromoState.initial());

  Future<void> checkPromo(String idevent) async {
    state = const CheckPromoState.loading();
    final result = await _promoUseCases.checkPromoUseCase
        .call(CheckPromoParams(idevent: idevent));
    result.fold(
      (failure) => state = CheckPromoState.failure(failure),
      (promo) {
        state = CheckPromoState.success(promo: promo);
      },
    );
  }
}
