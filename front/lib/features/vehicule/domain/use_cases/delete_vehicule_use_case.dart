import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/shared/use_case.dart';

class DeleteVehiculeUseCase implements UseCase<String, DeleteVehiculeParams> {
  final VehiculeRepository vehiculeRepository;

  DeleteVehiculeUseCase(this.vehiculeRepository);

  @override
  Future<Either<AppException, String>> call(DeleteVehiculeParams params) async {
    return await vehiculeRepository.deleteVehicules(id: params.id);
  }
}

class DeleteVehiculeParams<T> {
  final String id;
  DeleteVehiculeParams({required this.id});
}
