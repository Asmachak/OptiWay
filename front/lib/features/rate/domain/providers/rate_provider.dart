import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/rate/data/data_sources/rate_remote_data_source.dart';
import 'package:front/features/rate/data/repositories_impl/rate_repo_impl.dart';
import 'package:front/features/rate/domain/repositories/rate_repo.dart';
import 'package:front/features/rate/domain/use_cases/check_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/give_reservation_rate_use_case.dart';
import 'package:front/features/rate/domain/use_cases/rate_use_cases.dart';
import 'package:front/features/rate/domain/use_cases/update_rate_use_case.dart';

final ratedatasourceProvider = Provider.family<RateDataSource, NetworkService>(
  (_, networkService) => RateRemoteDataSource(networkService),
);

final rateRepositoryProvider = Provider<RateRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(ratedatasourceProvider(networkService));
  final repository = RateRepositoryImpl(
    datasource,
  );

  return repository;
});

final giveReservationRateUsecaseProvider =
    Provider<GiveReservationRateUsecases>((ref) {
  return GiveReservationRateUsecases(ref.read(rateRepositoryProvider));
});
final checkRateUsecaseProvider = Provider<CheckRateUsecase>((ref) {
  return CheckRateUsecase(ref.read(rateRepositoryProvider));
});
final updateRateUsecaseProvider = Provider<UpdateRateUsecases>((ref) {
  return UpdateRateUsecases(ref.read(rateRepositoryProvider));
});
