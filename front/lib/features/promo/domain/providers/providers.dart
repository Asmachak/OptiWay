import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/promo/data/data_sources/promo_remote_data_src.dart';
import 'package:front/features/promo/data/repositories_impl/promo_repo_impl.dart';
import 'package:front/features/promo/domain/repositories/promo_repo.dart';
import 'package:front/features/promo/domain/use_cases/add_promo_use_case.dart';
import 'package:front/features/promo/domain/use_cases/check_promo_use_case.dart';
import 'package:front/features/promo/domain/use_cases/get_promo_list_use_case.dart';

final promodatasourceProvider =
    Provider.family<PromoDataSource, NetworkService>(
  (_, networkService) => PromoRemoteDataSource(networkService),
);

final promoRepositoryProvider = Provider<PromoRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(promodatasourceProvider(networkService));
  final repository = PromoRepositoryImpl(
    datasource,
  );

  return repository;
});

final getPromoListUseCaseProvider = Provider<GetPromoListUsecases>((ref) {
  return GetPromoListUsecases(ref.read(promoRepositoryProvider));
});

final checkPromoUseCaseProvider = Provider<CheckPromoUsecase>((ref) {
  return CheckPromoUsecase(ref.read(promoRepositoryProvider));
});

final addPromoUseCaseProvider = Provider<AddPromoUsecase>((ref) {
  return AddPromoUsecase(ref.read(promoRepositoryProvider));
});
