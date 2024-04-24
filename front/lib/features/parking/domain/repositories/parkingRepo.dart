
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/domain/use_cases/get_all_parkings_use_case.dart';

abstract class ParkingRepository {
  Future<Either<AppException,List<ParkingModel> >> GetAllParkings(
     );
}
