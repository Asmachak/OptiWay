import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/rate/data/data_sources/avg_rate_remote_data_src.dart';
import 'package:front/features/rate/data/repositories_impl/avg_rate_impl.dart';
import 'package:front/features/rate/domain/repositories/avg_rate_repo.dart';
import 'package:front/features/rate/domain/use_cases/avg_rate_use_case.dart';

final avgRatedatasourceProvider =
    Provider.family<AvgRateDataSource, NetworkService>(
  (_, networkService) => AvgRateRemoteDataSource(networkService),
);

final rateRepositoryProvider = Provider<AvgRateRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(avgRatedatasourceProvider(networkService));
  final repository = AvgRateRepositoryImpl(
    datasource,
  );

  return repository;
});

final getAvgRateUsecaseProvider = Provider<AvgRateUsecase>((ref) {
  return AvgRateUsecase(ref.read(rateRepositoryProvider));
});
