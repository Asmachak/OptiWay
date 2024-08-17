import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';

abstract class PromoRepository {
  Future<Either<AppException, List<PromoModel>>> getPromoList();
}
