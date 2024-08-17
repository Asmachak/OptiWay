import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
import 'package:front/features/promo/domain/repositories/promo_repo.dart';
import 'package:front/shared/use_case.dart';

class GetPromoListUsecases implements UseCase<List<PromoModel>, NoParams> {
  final PromoRepository promoRepository;

  GetPromoListUsecases(this.promoRepository);
  @override
  Future<Either<AppException, List<PromoModel>>> call(noParams) async {
    return await promoRepository.getPromoList();
  }
}
