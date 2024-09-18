import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_login_response_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class VerifyOtpAdminUseCase
    implements
        UseCase<AdminLoginResponseModel,
            AdminVerifyOtpParams<Map<String, dynamic>>> {
  final AdminRepository adminRepository;

  VerifyOtpAdminUseCase(this.adminRepository);

  @override
  Future<Either<AppException, AdminLoginResponseModel>> call(
      AdminVerifyOtpParams params) async {
    return await adminRepository.verifyOTP(
        email: params.email, otp: params.otp);
  }
}

class AdminVerifyOtpParams<T> {
  final String email;
  final String otp;
  AdminVerifyOtpParams({required this.email, required this.otp});
}
