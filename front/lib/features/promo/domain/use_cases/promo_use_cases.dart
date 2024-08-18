import 'package:front/features/promo/domain/use_cases/check_promo_use_case.dart';
import 'package:front/features/promo/domain/use_cases/get_promo_list_use_case.dart';

class PromoUseCases {
  final GetPromoListUsecases getPromoListUsecases;

  PromoUseCases({
    required this.getPromoListUsecases,
  });
}

class CheckPromoUseCases {
  final CheckPromoUsecase checkPromoUseCase;

  CheckPromoUseCases({
    required this.checkPromoUseCase,
  });
}
