import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/data_sources/rate_remote_data_source.dart';
import 'package:front/features/rate/data/models/rate_model.dart';
import 'package:front/features/rate/domain/repositories/rate_repo.dart';

class RateRepositoryImpl implements RateRepository {
  final RateDataSource remoteDataSource;

  RateRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, RateModel>> giveReservationRate(
      {required Map<String, dynamic> body,
      required String userid,
      required resid}) {
    return remoteDataSource.giveReservationRate(
        body: body, userid: userid, resid: resid);
  }

  @override
  Future<Either<AppException, RateModel>> checkRate({required resid}) {
    return remoteDataSource.checkRate(resid: resid);
  }

   @override
  Future<Either<AppException, RateModel>> updateRate({required resid,required Map<String, dynamic> body}) {
    return remoteDataSource.updateRate(resid: resid,body: body);
  }
}
