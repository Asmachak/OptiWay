import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';

abstract class VehiculeRepository {
  Future<Either<AppException, VehiculeModel>> addVehicule(
      {required Map<String, dynamic> body, required String iduser});
}
