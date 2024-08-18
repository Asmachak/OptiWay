import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/promo_state/promo_state.dart';
import 'package:front/shared/use_case.dart';

class PromoNotifier extends StateNotifier<PromoState> {
  final PromoUseCases _promoUseCases;

  PromoNotifier(
    this._promoUseCases,
  ) : super(const PromoState.initial());

  Future<void> getPromoList() async {
    state = const PromoState.loading();
    final result = await _promoUseCases.getPromoListUsecases.call(NoParams());
    result.fold(
      (failure) => state = PromoState.failure(failure),
      (promos) {
        state = PromoState.loaded(promos: promos);
      },
    );
  }
}
