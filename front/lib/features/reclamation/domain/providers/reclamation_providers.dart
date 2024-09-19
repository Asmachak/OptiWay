import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/reclamation/data/data_sources/reclamation_remote_data_src.dart';
import 'package:front/features/reclamation/data/repositories_impl/reclamation_repo_impl.dart';
import 'package:front/features/reclamation/domain/repositories/reclamation_repo.dart';
import 'package:front/features/reclamation/domain/use_cases/add_reclamation_use_case.dart';
import 'package:front/features/reclamation/domain/use_cases/get_reclamation_use_case.dart';

final reclamationdatasourceProvider =
    Provider.family<ReclamationRemoteDataSource, NetworkService>(
  (_, networkService) => ReclamationRemoteDataSource(networkService),
);

final reclamationRepositoryProvider = Provider<ReclamationRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(reclamationdatasourceProvider(networkService));

  final repository = ReclamationRepositoryImpl(
    datasource,
  );

  return repository;
});

final addReclamationUseCaseProvider = Provider<AddReclamationUsecases>((ref) {
  return AddReclamationUsecases(ref.read(reclamationRepositoryProvider));
});

final getReclamationUseCaseProvider = Provider<GetReclamationUsecases>((ref) {
  return GetReclamationUsecases(ref.read(reclamationRepositoryProvider));
});