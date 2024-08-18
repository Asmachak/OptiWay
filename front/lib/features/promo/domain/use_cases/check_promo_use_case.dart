import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
import 'package:front/features/promo/domain/repositories/promo_repo.dart';
import 'package:front/shared/use_case.dart';

class CheckPromoUsecase implements UseCase<PromoModel, CheckPromoParams> {
  final PromoRepository promoRepository;

  CheckPromoUsecase(this.promoRepository);
  @override
  Future<Either<AppException, PromoModel>> call(CheckPromoParams params) async {
    return await promoRepository.checkPromo(idevent: params.idevent);
  }
}

class CheckPromoParams<T> {
  final String idevent;
  CheckPromoParams({required this.idevent});
}
