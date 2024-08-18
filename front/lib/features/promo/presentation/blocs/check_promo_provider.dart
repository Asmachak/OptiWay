import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/domain/providers/providers.dart';
import 'package:front/features/promo/domain/use_cases/promo_use_cases.dart';
import 'package:front/features/promo/presentation/blocs/state/check_promo_state/check_promo_notifier.dart';
import 'package:front/features/promo/presentation/blocs/state/check_promo_state/check_promo_state.dart';

final checkpromoNotifierProvider =
    StateNotifierProvider<CheckPromoNotifier, CheckPromoState>((ref) {
  final checkPromoUseCases = ref.read(checkPromoUseCaseProvider);

  final promoUseCases = CheckPromoUseCases(
    checkPromoUseCase: checkPromoUseCases,
  );
  return CheckPromoNotifier(promoUseCases);
});
