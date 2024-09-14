import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/avg_rate_model.dart';

abstract class AvgRateRepository {
  Future<Either<AppException, RateAvgModel>> getAvgRate({required String id});
}
