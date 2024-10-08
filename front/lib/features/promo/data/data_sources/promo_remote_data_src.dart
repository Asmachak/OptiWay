import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/promo/data/models/promo_model.dart';

abstract class PromoDataSource {
  Future<Either<AppException, List<PromoModel>>> getPromoList();
  Future<Either<AppException, PromoModel>> checkPromo(
      {required String idevent});
  Future<Either<AppException, PromoModel>> addPromo(
      {required String idevent, required Map<String, dynamic> body});
}

class PromoRemoteDataSource implements PromoDataSource {
  final NetworkService networkService;

  PromoRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, List<PromoModel>>> getPromoList() async {
    try {
      final eitherType = await networkService.get(
        '/promo/getPromo',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          List<PromoModel> promotions = [];
          if (response.data is List) {
            promotions = List<PromoModel>.from(
                response.data.map((x) => PromoModel.fromJson(x)));
          }
          return Right(promotions);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nPromoRemoteDataSource.getAllPromos',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, PromoModel>> checkPromo(
      {required String idevent}) async {
    try {
      final eitherType = await networkService.get(
        '/promo/getPromo/$idevent',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final promo = PromoModel.fromJson(response.data);
          return Right(promo);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nPromoRemoteDataSource.checkPromos',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, PromoModel>> addPromo(
      {required String idevent, required Map<String, dynamic> body}) async {
    try {
      final eitherType =
          await networkService.post('/promo/addPromo/$idevent', data: body);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final promo = PromoModel.fromJson(response.data);
          return Right(promo);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nPromoRemoteDataSource.checkPromos',
        ),
      );
    }
  }
}
