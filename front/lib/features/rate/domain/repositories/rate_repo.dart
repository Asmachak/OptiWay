import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

abstract class RateRepository {
  Future<Either<AppException, RateModel>> giveReservationRate(
      {required Map<String, dynamic> body,
      required String userid,
      required String resid});
  Future<Either<AppException, RateModel>> checkRate({required String resid});
  Future<Either<AppException, RateModel>> updateRate({
    required String resid,
    required Map<String, dynamic> body,
  });
}
