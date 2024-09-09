import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
import 'package:front/features/promo/domain/repositories/promo_repo.dart';
import 'package:front/shared/use_case.dart';

class AddPromoUsecase implements UseCase<PromoModel, AddPromoParams> {
  final PromoRepository promoRepository;

  AddPromoUsecase(this.promoRepository);
  @override
  Future<Either<AppException, PromoModel>> call(AddPromoParams params) async {
    return await promoRepository.addPromo(
        idevent: params.idevent, body: params.body);
  }
}

class AddPromoParams<T> {
  final String idevent;
  final Map<String, dynamic> body;
  AddPromoParams({required this.idevent, required this.body});
}
