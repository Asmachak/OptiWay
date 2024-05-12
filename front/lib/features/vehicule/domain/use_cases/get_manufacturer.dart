import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/shared/use_case.dart';

class GetManufacturerUseCase implements UseCase<List<dynamic>, NoParams> {
  final VehiculeRepository vehiculeRepository;

  GetManufacturerUseCase(this.vehiculeRepository);

  @override
  Future<Either<AppException, List<dynamic>>> call(NoParams) async {
    return await vehiculeRepository.getAllManufacturer();
  }
}
