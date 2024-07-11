import 'package:front/features/paiement/domain/use_cases/initPaymentsheet_usecase.dart';
import 'package:front/features/parking/domain/use_cases/get_all_parkings_use_case.dart';

class PaiementUseCases {
  final InitPaymentSheetUseCase initPaymentSheetUseCase;

  PaiementUseCases({
    required this.initPaymentSheetUseCase,
  });
}
