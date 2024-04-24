import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/domain/repositories/parkingRepo.dart';

class GetAllParkingsUseCase {
  final ParkingRepository parkingRepository;

  GetAllParkingsUseCase(this.parkingRepository);

  @override
  Future<Either<AppException, List<ParkingModel>>> call(noParams) async {
    return await parkingRepository.GetAllParkings();
  }
}
