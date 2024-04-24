import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/parking/data/data_sources/parking_remote_data_source.dart';
import 'package:front/features/parking/data/repositories_impl/ParkingRepositoryImpl.dart';
import 'package:front/features/parking/domain/repositories/parkingRepo.dart';
import 'package:front/features/parking/domain/use_cases/get_all_parkings_use_case.dart';

final parkingdatasourceProvider =
    Provider.family<ParkingRemoteDataSource, NetworkService>(
  (_, networkService) => ParkingRemoteDataSource(networkService),
);

final parkingRepositoryProvider = Provider<ParkingRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(parkingdatasourceProvider(networkService));

  final repository = ParkingRepositoryImpl(
    datasource,
  );

  return repository;
});

final getAllParkingsUseCaseProvider = Provider<GetAllParkingsUseCase>((ref) {
  return GetAllParkingsUseCase(ref.read(parkingRepositoryProvider));
});
