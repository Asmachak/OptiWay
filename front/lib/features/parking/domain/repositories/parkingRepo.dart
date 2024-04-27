
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/parking/data/models/parking_model.dart';

abstract class ParkingRepository {
  Future<Either<AppException,List<ParkingModel> >> GetAllParkings(
     );
}
