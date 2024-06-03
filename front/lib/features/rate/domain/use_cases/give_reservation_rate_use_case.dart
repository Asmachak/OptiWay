import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';
import 'package:front/features/rate/domain/repositories/rate_repo.dart';
import 'package:front/shared/use_case.dart';

class GiveReservationRateUsecases
    implements UseCase<RateModel, GiveReservationRateParams> {
  final RateRepository rateRepository;

  GiveReservationRateUsecases(this.rateRepository);
  @override
  Future<Either<AppException, RateModel>> call(
      GiveReservationRateParams params) async {
    return await rateRepository.giveReservationRate(
        body: params.body, userid: params.userid, resid: params.resid);
  }
}

class GiveReservationRateParams<T> {
  final Map<String, dynamic> body;
  final String userid;
  final String resid;
  GiveReservationRateParams(
      {required this.body, required this.userid, required this.resid});
}
