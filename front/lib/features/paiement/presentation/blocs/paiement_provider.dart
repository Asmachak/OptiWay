import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/paiement/domain/providers/paiement_provider.dart';
import 'package:front/features/paiement/domain/use_cases/paiement_use_cases.dart';
import 'package:front/features/paiement/presentation/blocs/state/paiement_notifier.dart';
import 'package:front/features/paiement/presentation/blocs/state/paiement_state.dart';

final paiementNotifierProvider =
    StateNotifierProvider<PaiementNotifier, PaiementState>((ref) {
  final initPaymentSheetUseCase = ref.read(initPaymentSheetUseCaseProvider);

  final paiementUseCases = PaiementUseCases(
    initPaymentSheetUseCase: initPaymentSheetUseCase,
  );

  return PaiementNotifier(paiementUseCases);
});
