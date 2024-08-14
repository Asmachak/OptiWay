import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/notification/data/data_sources/notification_remote_data_src.dart';
import 'package:front/features/notification/data/repositories_impl/notification_repo_impl.dart';
import 'package:front/features/notification/domain/repositories/notification_repo.dart';
import 'package:front/features/notification/domain/use_cases/get_notification_use_case.dart';
import 'package:front/features/parking/data/data_sources/parking_remote_data_source.dart';
import 'package:front/features/parking/data/repositories_impl/ParkingRepositoryImpl.dart';
import 'package:front/features/parking/domain/repositories/parkingRepo.dart';
import 'package:front/features/parking/domain/use_cases/get_all_parkings_use_case.dart';

final notificationdatasourceProvider =
    Provider.family<NotificationRemoteDataSource, NetworkService>(
  (_, networkService) => NotificationRemoteDataSource(networkService),
);

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(notificationdatasourceProvider(networkService));

  final repository = NotificationRepositoryImpl(
    datasource,
  );

  return repository;
});

final getNotificationsUseCaseProvider =
    Provider<GetNotificationsUsecases>((ref) {
  return GetNotificationsUsecases(ref.read(notificationRepositoryProvider));
});
