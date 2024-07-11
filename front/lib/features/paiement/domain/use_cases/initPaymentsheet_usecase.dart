import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/paiement/data/models/paiement_model.dart';
import 'package:front/features/paiement/domain/repositories/paiement_repo.dart';

class InitPaymentSheetUseCase {
  final PaymentRepository paiementRepository;

  InitPaymentSheetUseCase(this.paiementRepository);

  @override
  Future<Either<AppException, PaiementModel>> call(
      InitPaymentSheetParams params) async {
    return await paiementRepository.InitPaymentSheet(body: params.body);
  }
}

class InitPaymentSheetParams<T> {
  final Map<String, dynamic> body;
  InitPaymentSheetParams({
    required this.body,
  });
}
