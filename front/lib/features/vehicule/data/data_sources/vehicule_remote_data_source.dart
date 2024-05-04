import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:get_it/get_it.dart';

abstract class VehiculeDataSource {
  Future<Either<AppException, VehiculeModel>> addVehicule(
      {required Map<String, dynamic> body, required String iduser});
}

class VehiculeRemoteDataSource implements VehiculeDataSource {
  final NetworkService networkService;

  VehiculeRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, VehiculeModel>> addVehicule(
      {required Map<String, dynamic> body, required String iduser}) async {
    try {
      final eitherType = await networkService.post(
        '/vehicule/addVeh/$iduser',
        data: body,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          final vehicule = VehiculeModel.fromJson(response.data);
          if (response.statusCode == 200) {
            await GetIt.instance
                .get<VehiculeLocalDataSource>()
                .addVehicule(vehicule);
          }
          return Right(vehicule);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nAddVehiculeRemoteDataSource.addVehicule',
        ),
      );
    }
  }
}
