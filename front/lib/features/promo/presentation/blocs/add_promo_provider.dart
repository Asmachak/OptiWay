import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/providers/providers.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/add_promo_state/add_promo_notifier.dart';
import 'package:front/features/promo/presentation/blocs/state/add_promo_state/add_promo_state.dart';

final addpromoNotifierProvider =
    StateNotifierProvider<AddPromoNotifier, AddPromoState>((ref) {
  final addPromoUseCases = ref.read(addPromoUseCaseProvider);

  final promoUseCases = AddPromoUseCases(
    addPromoUseCase: addPromoUseCases,
  );
  return AddPromoNotifier(promoUseCases);
});
