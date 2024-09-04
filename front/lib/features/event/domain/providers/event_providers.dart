import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/event/data/data_sources/event_remote_data_src.dart';
import 'package:front/features/event/data/repositories_impl/event_repo_impl.dart';
import 'package:front/features/event/domain/repositories/event_repo.dart';
import 'package:front/features/event/domain/use_cases/add_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/delete_event_use_case.dart';
import 'package:front/features/event/domain/use_cases/get_event_organiser_use_case.dart';

final eventOrganiserdatasourceProvider =
    Provider.family<EventRemoteDataSource, NetworkService>(
  (_, networkService) => EventRemoteDataSource(networkService),
);

final eventOrganiserRepositoryProvider =
    Provider<OrganiserEventRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource =
      ref.watch(eventOrganiserdatasourceProvider(networkService));
  final repository = OrganiserEventRepositoryImpl(
    datasource,
  );

  return repository;
});

final addEventOrganiserUseCaseProvider = Provider<AddEventUsecases>((ref) {
  return AddEventUsecases(ref.read(eventOrganiserRepositoryProvider));
});

final getEventOrganiserUseCaseProvider = Provider<GetEventUsecases>((ref) {
  return GetEventUsecases(ref.read(eventOrganiserRepositoryProvider));
});

final deleteEventOrganiserUseCaseProvider =
    Provider<DeleteEventUsecases>((ref) {
  return DeleteEventUsecases(ref.read(eventOrganiserRepositoryProvider));
});
