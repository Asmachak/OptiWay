import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/user/data/data_sources/remote_data_source.dart';
import 'package:front/features/user/data/repositories_impl/user_repo_impl.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';

// Define a provider family for creating instances of SignUpUserDataSource.
final signUpDataSourceProvider =
    Provider.family<SignUpUserDataSource, NetworkService>(
  (_, networkService) => SignUpUserRemoteDataSource(networkService),
);

// Define a provider for creating instances of UserRepository using SignUpUserDataSource.
final signUpRepositoryProvider = Provider<UserRepository>(
  (ref) {
    // Retrieve the NetworkService dependency from the provider.
    final NetworkService networkService = ref.watch(networkServiceProvider);

    // Retrieve the SignUpUserDataSource dependency using the signUpDataSourceProvider.
    final SignUpUserDataSource dataSource =
        ref.watch(signUpDataSourceProvider(networkService));
    final localDataSource = ref.watch(authLocalDataSourceProvider);
    // Create an instance of UserRepositoryImpl using SignUpUserDataSource.
    return UserRepositoryImpl(dataSource /*,localDataSource*/);
  },
);
