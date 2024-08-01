import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/reservation/data/data_sources/reservationEvent_remote_data_src.dart';
import 'package:front/features/reservation/data/repositories_impl/reservationEvent_repo_impl.dart';
import 'package:front/features/reservation/domain/repositories/reservationEvent_repo.dart';
import 'package:front/features/reservation/domain/use_cases/reservationEvent/add_reservationEvent_use_case.dart';

final reservationEventdatasourceProvider =
    Provider.family<ReservationEventDataSource, NetworkService>(
  (_, networkService) => ReservationEventRemoteDataSource(networkService),
);

final reservationEventRepositoryProvider =
    Provider<ReservationEventRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource =
      ref.watch(reservationEventdatasourceProvider(networkService));
  final repository = ReservationEventRepositoryImpl(
    datasource,
  );

  return repository;
});

final addReservationEventUseCaseProvider =
    Provider<AddReservationEventUsecases>((ref) {
  return AddReservationEventUsecases(
      ref.read(reservationEventRepositoryProvider));
});
