import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/parking/data/data_sources/parking_remote_data_source.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/domain/repositories/parkingRepo.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;

  ParkingRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, List<ParkingModel>>> GetAllParkings() {
    return remoteDataSource.getAllParkings();
  }
}
