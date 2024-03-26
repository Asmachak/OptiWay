import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/data_sources/remote_data_source.dart';
import 'package:front/features/user/data/repositories_impl/user_repo_impl.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';

final userdatasourceProvider =
    Provider.family<SignUpUserRemoteDataSource, NetworkService>(
  (_, networkService) => SignUpUserRemoteDataSource(networkService),
);

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(userdatasourceProvider(networkService));
  final repository = UserRepositoryImpl(datasource);

  return repository;
});

final authLocalDataSourceProvider = Provider((ref) {
  final authLocal = AuthLocalDataSource();
  authLocal.initialize();
  return authLocal;
});

final IsLoggedIn = FutureProvider((ref) async {
  final localUser = ref.watch(authLocalDataSourceProvider);
  return await localUser.isLoggedIn();
});
