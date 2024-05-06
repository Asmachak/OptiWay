import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/vehicule/data/data_sources/vehicule_remote_data_source.dart';
import 'package:front/features/vehicule/data/repositories_impl/vehicule_repo_impl.dart';
import 'package:front/features/vehicule/domain/repositories/vehicule_repo.dart';
import 'package:front/features/vehicule/domain/use_cases/add_vehicule_use_case.dart';
import 'package:front/features/vehicule/domain/use_cases/get_all_vehicules_use_case.dart';

final vehiculedatasourceProvider =
    Provider.family<VehiculeRemoteDataSource, NetworkService>(
  (_, networkService) => VehiculeRemoteDataSource(networkService),
);

final vehiculeRepositoryProvider = Provider<VehiculeRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(vehiculedatasourceProvider(networkService));
  // final localDataSource = ref.watch(authLocalDataSourceProvider);
  final repository = VehiculeRepositoryImpl(
    datasource,
  );

  return repository;
});

final addVehiculeUseCaseProvider = Provider<AddVehiculeUseCase>((ref) {
  return AddVehiculeUseCase(ref.read(vehiculeRepositoryProvider));
});
final getAllVehiculeUseCaseProvider = Provider<GetVehiculeUseCase>((ref) {
  return GetVehiculeUseCase(ref.read(vehiculeRepositoryProvider));
});
