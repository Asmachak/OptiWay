import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/data/models/vehicule_model.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/shared/use_case.dart';

class GetVehiculeUseCase
    implements UseCase<List<VehiculeModel>, GetVehiculeParams> {
  final VehiculeRepository vehiculeRepository;

  GetVehiculeUseCase(this.vehiculeRepository);

  @override
  Future<Either<AppException, List<VehiculeModel>>> call(
      GetVehiculeParams params) async {
    return await vehiculeRepository.getAllVehicules(iduser: params.iduser);
  }
}

class GetVehiculeParams<T> {
  final String iduser;
  GetVehiculeParams({required this.iduser});
}
