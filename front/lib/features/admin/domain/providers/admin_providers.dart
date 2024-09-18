import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/network_service.dart';
import 'package:front/core/infrastructure/providers/network_service_provider.dart';
import 'package:front/features/admin/data/data_sources/admin_remote_data_src.dart';
import 'package:front/features/admin/data/repositories_impl/admin_repo_impl.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/features/admin/domain/use_cases/edit_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/edit_profile.dart';
import 'package:front/features/admin/domain/use_cases/forget_password_use_case.dart';
import 'package:front/features/admin/domain/use_cases/login_otp_use_case.dart';
import 'package:front/features/admin/domain/use_cases/login_use_case.dart';
import 'package:front/features/admin/domain/use_cases/signup_use_case.dart';
import 'package:front/features/admin/domain/use_cases/upload_image_use_case.dart';
import 'package:front/features/admin/domain/use_cases/verify_otp_use_case.dart';

final admindatasourceProvider =
    Provider.family<AdminRemoteDataSource, NetworkService>(
  (_, networkService) => AdminRemoteDataSource(networkService),
);

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(admindatasourceProvider(networkService));
  // final localDataSource = ref.watch(authLocalDataSourceProvider);
  final repository = AdminRepositoryImpl(
    datasource, /*localDataSource:localDataSource*/
  );

  return repository;
});

final logiAdminUseCaseProvider = Provider<LoginAdminUseCases>((ref) {
  return LoginAdminUseCases(ref.read(adminRepositoryProvider));
});

final registerAdminUseCaseProvider = Provider<RegistreAdminUsecase>((ref) {
  return RegistreAdminUsecase(ref.read(adminRepositoryProvider));
});

final loginOtpAdminUseCaseProvider = Provider<LoginOtpAdminUseCase>((ref) {
  return LoginOtpAdminUseCase(ref.read(adminRepositoryProvider));
});

final verifyOtpAdminUseCaseProvider = Provider<VerifyOtpAdminUseCase>((ref) {
  return VerifyOtpAdminUseCase(ref.read(adminRepositoryProvider));
});

final editProfileAdminUseCaseProvider =
    Provider<EditProfileAdminUsecases>((ref) {
  return EditProfileAdminUsecases(ref.read(adminRepositoryProvider));
});

final uploadImageAdminUseCaseProvider =
    Provider<UploadImageAdminUsecases>((ref) {
  return UploadImageAdminUsecases(ref.read(adminRepositoryProvider));
});

final editPasswordAdminUseCaseProvider =
    Provider<EditPasswordAdminUseCase>((ref) {
  return EditPasswordAdminUseCase(ref.read(adminRepositoryProvider));
});

final forgetPasswordAdminUseCaseProvider =
    Provider<ForgetPasswordAdminUseCase>((ref) {
  return ForgetPasswordAdminUseCase(ref.read(adminRepositoryProvider));
});
