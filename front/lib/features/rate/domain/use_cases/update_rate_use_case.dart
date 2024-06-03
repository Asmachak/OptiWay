import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';
import 'package:front/features/rate/domain/repositories/rate_repo.dart';
import 'package:front/shared/use_case.dart';

class UpdateRateUsecases implements UseCase<RateModel, UpdateRateParams> {
  final RateRepository rateRepository;

  UpdateRateUsecases(this.rateRepository);
  @override
  Future<Either<AppException, RateModel>> call(UpdateRateParams params) async {
    return await rateRepository.updateRate(
        body: params.body, resid: params.resid);
  }
}

class UpdateRateParams<T> {
  final Map<String, dynamic> body;
  final String resid;
  UpdateRateParams({required this.body, required this.resid});
}
