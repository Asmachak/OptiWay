import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/paiement/data/data_sources/paiement_remote_data_src.dart';
import 'package:front/features/paiement/data/repositories_impl/paiement_repo_impl.dart';
import 'package:front/features/paiement/domain/repositories/paiement_repo.dart';
import 'package:front/features/paiement/domain/use_cases/initPaymentsheet_usecase.dart';

final paiementdatasourceProvider =
    Provider.family<PaiementRemoteDataSource, NetworkService>(
  (_, networkService) => PaiementRemoteDataSource(networkService),
);

final paiementRepositoryProvider = Provider<PaymentRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(paiementdatasourceProvider(networkService));

  final repository = PaymentRepositoryImpl(
    datasource,
  );

  return repository;
});

final initPaymentSheetUseCaseProvider =
    Provider<InitPaymentSheetUseCase>((ref) {
  return InitPaymentSheetUseCase(ref.read(paiementRepositoryProvider));
});
