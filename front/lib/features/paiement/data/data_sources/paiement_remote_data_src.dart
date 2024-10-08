import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/paiement/data/models/paiement_model.dart';

abstract class PaiementDataSource {
  Future<Either<AppException, PaiementModel>> initPaymentSheet(
      {required Map<String, dynamic> body});
}

class PaiementRemoteDataSource implements PaiementDataSource {
  final NetworkService networkService;

  PaiementRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, PaiementModel>> initPaymentSheet(
      {required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.post(
        '/create-payment-intent',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final paie = PaiementModel.fromJson(response.data);

          return Right(paie);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nPaiementRemoteDataSource.initPaymentSheet',
        ),
      );
    }
  }
}
