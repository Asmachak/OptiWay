import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/shared/use_case.dart';

class GetModelsUseCase implements UseCase<List<dynamic>, GetModelsParams> {
  final VehiculeRepository vehiculeRepository;

  GetModelsUseCase(this.vehiculeRepository);

  @override
  Future<Either<AppException, List<dynamic>>> call(GetModelsParams) async {
    return await vehiculeRepository.getAllModels(
        manufacturerId: GetModelsParams.manufacturerId);
  }
}

class GetModelsParams<T> {
  final String manufacturerId;
  GetModelsParams({required this.manufacturerId});
}
