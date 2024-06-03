import 'package:front/features/rate/domain/use_cases/check_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/give_reservation_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/update_rate_use_case.dart';

class RateUseCases {
  final GiveReservationRateUsecases giveReservationRateUsecases;
  final UpdateRateUsecases updateRateUsecases;

  RateUseCases({
    required this.giveReservationRateUsecases,
    required this.updateRateUsecases,
  });
}

class CheckRateUseCases {
  final CheckRateUsecase checkRateUseCase;

  CheckRateUseCases({
    required this.checkRateUseCase,
  });
}
