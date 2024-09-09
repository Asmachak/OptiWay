import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/data_sources/promo_remote_data_src.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
import 'package:front/features/promo/domain/repositories/promo_repo.dart';

class PromoRepositoryImpl implements PromoRepository {
  final PromoDataSource remoteDataSource;

  PromoRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, List<PromoModel>>> getPromoList() {
    return remoteDataSource.getPromoList();
  }

  @override
  Future<Either<AppException, PromoModel>> checkPromo({required idevent}) {
    return remoteDataSource.checkPromo(idevent: idevent);
  }

  @override
  Future<Either<AppException, PromoModel>> addPromo(
      {required idevent, required body}) {
    return remoteDataSource.addPromo(idevent: idevent, body: body);
  }
}
