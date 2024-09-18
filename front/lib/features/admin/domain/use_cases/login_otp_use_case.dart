import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_login_response_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginOtpAdminUseCase
    implements
        UseCase<AdminLoginResponseModel, AdminOtpParams<Map<String, dynamic>>> {
  final AdminRepository adminRepository;

  LoginOtpAdminUseCase(this.adminRepository);

  @override
  Future<Either<AppException, AdminLoginResponseModel>> call(
      AdminOtpParams params) async {
    return await adminRepository.otpLogin(email: params.email);
  }
}

class AdminOtpParams<T> {
  final String email;
  AdminOtpParams({required this.email});
}
