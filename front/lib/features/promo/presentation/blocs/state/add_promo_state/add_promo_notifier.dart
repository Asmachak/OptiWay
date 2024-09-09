import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/use_cases/add_promo_use_case.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/add_promo_state/add_promo_state.dart';

class AddPromoNotifier extends StateNotifier<AddPromoState> {
  final AddPromoUseCases _promoUseCases;

  AddPromoNotifier(
    this._promoUseCases,
  ) : super(const AddPromoState.initial());

  Future<void> addPromo(String idevent, Map<String, dynamic> body) async {
    state = const AddPromoState.loading();
    final result = await _promoUseCases.addPromoUseCase
        .call(AddPromoParams(idevent: idevent, body: body));
    result.fold(
      (failure) => state = AddPromoState.failure(failure),
      (promo) {
        state = AddPromoState.success(promo: promo);
      },
    );
  }
}
