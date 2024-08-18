import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/providers/providers.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/promo_state/promo_notifier.dart';
import 'package:front/features/promo/presentation/blocs/state/promo_state/promo_state.dart';

final promoNotifierProvider =
    StateNotifierProvider<PromoNotifier, PromoState>((ref) {
  final getPromoListUseCases = ref.read(getPromoListUseCaseProvider);

  final promoUseCases = PromoUseCases(
    getPromoListUsecases: getPromoListUseCases,
  );
  return PromoNotifier(promoUseCases);
});
