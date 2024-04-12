import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/user/data/data_sources/remote_data_source.dart';
import 'package:front/features/user/data/repositories_impl/user_repo_impl.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/features/user/domain/usescases/user/login_otp_use_case.dart';
import 'package:front/features/user/domain/usescases/user/login_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/register_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/verify_otp_use_case.dart';

final userdatasourceProvider =
    Provider.family<UserRemoteDataSource, NetworkService>(
  (_, networkService) => UserRemoteDataSource(networkService),
);

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(userdatasourceProvider(networkService));
  // final localDataSource = ref.watch(authLocalDataSourceProvider);
  final repository = UserRepositoryImpl(
    datasource, /*localDataSource:localDataSource*/
  );

  return repository;
});

final loginUseCaseProvider = Provider<LoginUseCases>((ref) {
  return LoginUseCases(ref.read(userRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegistreUsecase>((ref) {
  return RegistreUsecase(ref.read(userRepositoryProvider));
});

final loginOtpUseCaseProvider = Provider<LoginOtpUseCase>((ref) {
  return LoginOtpUseCase(ref.read(userRepositoryProvider));
});

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  return VerifyOtpUseCase(ref.read(userRepositoryProvider));
});

// final editProfileUseCaseProvider = Provider<EditProfileUsecases>((ref) {
//   return EditProfileUsecases(ref.read(userRepositoryProvider));
// });

// final updatePasswordUseCaseProvider = Provider<UpdatePasswordUsecases>((ref) {
//   return UpdatePasswordUsecases(ref.read(userRepositoryProvider));
// });
