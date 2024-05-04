import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/shared/use_case.dart';

class AddVehiculeUseCase implements UseCase<VehiculeModel, AddVehiculeParams> {
  final VehiculeRepository vehiculeRepository;

  AddVehiculeUseCase(this.vehiculeRepository);

  @override
  Future<Either<AppException, VehiculeModel>> call(
      AddVehiculeParams params) async {
    return await vehiculeRepository.addVehicule(
        iduser: params.iduser, body: params.body);
  }
}

class AddVehiculeParams<T> {
  final String iduser;
  final Map<String, dynamic> body;
  AddVehiculeParams({required this.body, required this.iduser});
}
