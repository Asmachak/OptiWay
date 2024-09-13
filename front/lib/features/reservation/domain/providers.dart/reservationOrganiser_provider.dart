import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/reservation/data/data_sources/reservationOrganiser_remote_data_src.dart';
import 'package:front/features/reservation/data/repositories_impl/reservation_organiser_impl.dart';
import 'package:front/features/reservation/domain/repositories/reservationOrganiser_repo.dart';
import 'package:front/features/reservation/domain/use_cases/reservationOrganiser/getReservationOrganiser_use_case.dart';

final reservationOrganiserdatasourceProvider =
    Provider.family<ReservationOrganiserDataSource, NetworkService>(
  (_, networkService) => ReservationOrganiserRemoteDataSource(networkService),
);

final reservationOrganiserRepositoryProvider =
    Provider<ReservationOrganiserRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource =
      ref.watch(reservationOrganiserdatasourceProvider(networkService));
  final repository = ReservationOrganiserRepositoryImpl(
    datasource,
  );

  return repository;
});

final getReservationOrganiserUseCaseProvider =
    Provider<GetReservationOrganiserUsecases>((ref) {
  return GetReservationOrganiserUsecases(
      ref.read(reservationOrganiserRepositoryProvider));
});
