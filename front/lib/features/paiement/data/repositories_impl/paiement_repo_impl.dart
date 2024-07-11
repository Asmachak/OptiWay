import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/paiement/data/data_sources/paiement_remote_data_src.dart';
import 'package:front/features/paiement/data/models/paiement_model.dart';
import 'package:front/features/paiement/domain/repositories/paiement_repo.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaiementDataSource remoteDataSource;

  PaymentRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, PaiementModel>> InitPaymentSheet({required Map<String, dynamic> body}) {
    return remoteDataSource.initPaymentSheet(body: body);
  }
}
