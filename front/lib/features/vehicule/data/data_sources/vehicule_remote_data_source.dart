import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_local_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:get_it/get_it.dart';

abstract class VehiculeDataSource {
  Future<Either<AppException, VehiculeModel>> addVehicule(
      {required Map<String, dynamic> body, required String iduser});
  Future<Either<AppException, List<VehiculeModel>>> getAllVehicules(
      {required String iduser});
  Future<Either<AppException, String>> deleteVehicules({required String id});
  Future<Either<AppException, List<dynamic>>> getAllManufacturer();
  Future<Either<AppException, List<dynamic>>> getAllModels(
      {required String manufacturerId});
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

  @override
  Future<Either<AppException, List<VehiculeModel>>> getAllVehicules(
      {required String iduser}) async {
    try {
      // Call the network service to get available vehicles
      final eitherType = await networkService.get(
        '/vehicule/$iduser',
      );
      return eitherType.fold((exception) {
        return Left(exception);
      }, (response) async {
        List<VehiculeModel> vehicules = [];
        if (response.data != null) {
          vehicules = List<VehiculeModel>.from(
            response.data.map((x) => VehiculeModel.fromJson(x)),
          );

          // Clear and populate local data source
          final vehiculeLocalDataSource =
              GetIt.instance.get<VehiculeLocalDataSource>();
          await vehiculeLocalDataSource.voidVehiculeBox(); // Clear the box
          vehicules.forEach((vehicule) {
            vehiculeLocalDataSource.addVehicule(vehicule); // Add each vehicle
          });
        }
        return Right(vehicules);
      });
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nVehiculeRemoteDataSource.getAllVehicules',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, String>> deleteVehicules(
      {required String id}) async {
    try {
      final eitherType = await networkService.post(
        '/vehicule/delete/$id',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          return Right(response.statusCode.toString());
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

  @override
  Future<Either<AppException, List<dynamic>>> getAllManufacturer() async {
    try {
      final eitherType = await networkService.get('/cars');
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          print("maaan ${response.data}");
          return Right(response.data);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nAddVehiculeRemoteDataSource.GetManufacturer',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<dynamic>>> getAllModels(
      {required String manufacturerId}) async {
    try {
      final eitherType = await networkService.get(
        '/cars/$manufacturerId',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) async {
          return Right(response.data);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier:
              '${e.toString()}\nAddVehiculeRemoteDataSource.GetManufacturer',
        ),
      );
    }
  }
}
