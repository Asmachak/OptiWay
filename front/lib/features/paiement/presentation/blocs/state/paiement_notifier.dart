import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front/features/paiement/domain/use_cases/initPaymentsheet_usecase.dart';
import 'package:front/features/paiement/domain/use_cases/paiement_use_cases.dart';
import 'package:front/features/paiement/presentation/blocs/state/paiement_state.dart';

class PaiementNotifier extends StateNotifier<PaiementState> {
  final PaiementUseCases _paiementUseCases;

  PaiementNotifier(this._paiementUseCases)
      : super(const PaiementState.initial());

  Future<void> initPaymentSheet(Map<String, dynamic> body) async {
    state = const PaiementState.loading();
    final result = await _paiementUseCases.initPaymentSheetUseCase
        .call(InitPaymentSheetParams(body: body));
    return result.fold(
      (failure) {
        state = PaiementState.failure(failure);
      },
      (response) async {
        state = PaiementState.success(paymentModel: response);
      },
    );
  }
}
