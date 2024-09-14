import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/avg_rate_model.dart';
import 'package:front/features/rate/domain/repositories/avg_rate_repo.dart';
import 'package:front/shared/use_case.dart';

class AvgRateUsecase implements UseCase<RateAvgModel, AvgParams> {
  final AvgRateRepository rateRepository;

  AvgRateUsecase(this.rateRepository);
  @override
  Future<Either<AppException, RateAvgModel>> call(AvgParams params) async {
    return await rateRepository.getAvgRate(id: params.id);
  }
}

class AvgParams<T> {
  final String id;
  AvgParams({required this.id});
}
