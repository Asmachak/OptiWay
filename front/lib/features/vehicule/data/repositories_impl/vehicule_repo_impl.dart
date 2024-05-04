import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_remote_data_source.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';

class VehiculeRepositoryImpl implements VehiculeRepository {
  final VehiculeDataSource remoteDataSource;

  VehiculeRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, VehiculeModel>> addVehicule(
      {required Map<String, dynamic> body, required String iduser}) async {
    return remoteDataSource.addVehicule(body: body, iduser: iduser);
  }
}
