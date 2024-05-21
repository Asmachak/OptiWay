import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/reservation/data/data_sources/reservation_remote_data_source.dart';
import 'package:front/features/reservation/data/repositories_impl/reservation_repo_impl.dart';
import 'package:front/features/reservation/domain/repositories/reservation_repo.dart';
import 'package:front/features/reservation/domain/use_cases/add_reservation_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/get_reservation_use_case.dart';

final reservationdatasourceProvider =
    Provider.family<ReservationDataSource, NetworkService>(
  (_, networkService) => ReservationRemoteDataSource(networkService),
);

final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(reservationdatasourceProvider(networkService));
  // final localDataSource = ref.watch(authLocalDataSourceProvider);
  final repository = ReservationRepositoryImpl(
    datasource, /*localDataSource:localDataSource*/
  );

  return repository;
});

final addReservationUseCaseProvider = Provider<AddReservationUsecases>((ref) {
  return AddReservationUsecases(ref.read(reservationRepositoryProvider));
});

final getReservationUseCaseProvider = Provider<GetReservationUsecases>((ref) {
  return GetReservationUsecases(ref.read(reservationRepositoryProvider));
});
