import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/paiement/data/models/paiement_model.dart';

abstract class PaymentRepository {
  Future<Either<AppException, PaiementModel>> InitPaymentSheet(
      {required Map<String, dynamic> body});
}
