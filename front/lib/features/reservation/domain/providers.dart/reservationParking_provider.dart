import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/reservation/data/data_sources/reservationParking_remote_data_src.dart';
import 'package:front/features/reservation/data/repositories_impl/reservationParking_repo_impl.dart';
import 'package:front/features/reservation/domain/repositories/reservationParking_repo.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/add_reservationParking_use_case.dart';
import 'package:front/features/reservation/domain/use_cases/reservationParking/get_all_reservationParking_use_case.dart';

final reservationParkingdatasourceProvider =
    Provider.family<ReservationParkingDataSource, NetworkService>(
  (_, networkService) => ReservationParkingRemoteDataSource(networkService),
);

final reservationParkingRepositoryProvider =
    Provider<ReservationParkingRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource =
      ref.watch(reservationParkingdatasourceProvider(networkService));
  final repository = ReservationParkingRepositoryImpl(
    datasource,
  );

  return repository;
});

final addReservationParkingUseCaseProvider =
    Provider<AddReservationParkingUsecases>((ref) {
  return AddReservationParkingUsecases(
      ref.read(reservationParkingRepositoryProvider));
});

final getAllReservationParkingUseCaseProvider =
    Provider<GetAllReservationParkingUsecases>((ref) {
  return GetAllReservationParkingUsecases(
      ref.read(reservationParkingRepositoryProvider));
});
