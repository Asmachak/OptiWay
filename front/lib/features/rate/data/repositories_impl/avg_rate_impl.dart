import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/data_sources/avg_rate_remote_data_src.dart';
import 'package:front/features/rate/data/models/avg_rate_model.dart';
import 'package:front/features/rate/domain/repositories/avg_rate_repo.dart';

class AvgRateRepositoryImpl implements AvgRateRepository {
  final AvgRateDataSource remoteDataSource;

  AvgRateRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, RateAvgModel>> getAvgRate({required id}) {
    return remoteDataSource.getAvgRate(id: id);
  }
}
