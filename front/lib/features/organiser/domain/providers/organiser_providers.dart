import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/organiser/data/data_sources/organiser_remote_data_src.dart';
import 'package:front/features/organiser/data/repositories_impl/organiser_repo_impl.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/features/organiser/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/edit_profile.dart';
import 'package:front/features/organiser/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/login_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/signup_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/upload_image_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/verify_otp_use_case.dart';


final organiserdatasourceProvider =
    Provider.family<OrganiserRemoteDataSource, NetworkService>(
  (_, networkService) => OrganiserRemoteDataSource(networkService),
);

final organiserRepositoryProvider = Provider<OrganiserRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(organiserdatasourceProvider(networkService));
  // final localDataSource = ref.watch(authLocalDataSourceProvider);
  final repository = OrganiserRepositoryImpl(
    datasource, /*localDataSource:localDataSource*/
  );

  return repository;
});

final loginOrganiserUseCaseProvider = Provider<LoginOrganiserUseCases>((ref) {
  return LoginOrganiserUseCases(ref.read(organiserRepositoryProvider));
});

final registerOrganiserUseCaseProvider =
    Provider<RegistreOrganiserUsecase>((ref) {
  return RegistreOrganiserUsecase(ref.read(organiserRepositoryProvider));
});

final loginOtpOrganiserUseCaseProvider =
    Provider<LoginOtpOrganiserUseCase>((ref) {
  return LoginOtpOrganiserUseCase(ref.read(organiserRepositoryProvider));
});

final verifyOtpOrganiserUseCaseProvider =
    Provider<VerifyOtpOrganiserUseCase>((ref) {
  return VerifyOtpOrganiserUseCase(ref.read(organiserRepositoryProvider));
});

final editProfileOrganiserUseCaseProvider =
    Provider<EditProfileOrganiserUsecases>((ref) {
  return EditProfileOrganiserUsecases(ref.read(organiserRepositoryProvider));
});
final uploadImageOrganiserUseCaseProvider =
    Provider<UploadImageOrganiserUsecases>((ref) {
  return UploadImageOrganiserUsecases(ref.read(organiserRepositoryProvider));
});

final editPasswordOrganiserUseCaseProvider =
    Provider<EditPasswordOrganiserUseCase>((ref) {
  return EditPasswordOrganiserUseCase(ref.read(organiserRepositoryProvider));
});

final forgetPasswordOrganiserUseCaseProvider =
    Provider<ForgetPasswordOrganiserUseCase>((ref) {
  return ForgetPasswordOrganiserUseCase(ref.read(organiserRepositoryProvider));
});
