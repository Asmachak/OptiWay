import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';

abstract class ReclamationDataSource {
  Future<Either<AppException, ReclamationModel>> addReclamation(
      {required String targetId,
      required String reclaimerId,
      required Map<String, dynamic> body});
}

class ReclamationRemoteDataSource implements ReclamationDataSource {
  final NetworkService networkService;

  ReclamationRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ReclamationModel>> addReclamation(
      {required String targetId,
      required String reclaimerId,
      required Map<String, dynamic> body}) async {
    try {
      final eitherType = await networkService.post(
        '/addReclamation/$reclaimerId/$targetId',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final reclamation = ReclamationModel.fromJson(response.data);

          return Right(reclamation);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nReclamationRemoteDataSource.addReclamation',
        ),
      );
    }
  }
}
