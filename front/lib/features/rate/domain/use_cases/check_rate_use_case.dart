import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';
import 'package:front/features/rate/domain/repositories/rate_repo.dart';
import 'package:front/shared/use_case.dart';

class CheckRateUsecase implements UseCase<RateModel, CheckParams> {
  final RateRepository rateRepository;

  CheckRateUsecase(this.rateRepository);
  @override
  Future<Either<AppException, RateModel>> call(CheckParams params) async {
    return await rateRepository.checkRate(resid: params.resid);
  }
}

class CheckParams<T> {
  final String resid;
  CheckParams({required this.resid});
}
