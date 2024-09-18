import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class ForgetPasswordAdminUseCase
    implements UseCase<AdminModel, AdminForgetPasswordParams> {
  final AdminRepository adminRepository;

  ForgetPasswordAdminUseCase(this.adminRepository);
  @override
  Future<Either<AppException, AdminModel>> call(
      AdminForgetPasswordParams params) async {
    return await adminRepository.forgetPassword(body: params.body);
  }
}

class AdminForgetPasswordParams<T> {
  final Map<String, dynamic> body;
  AdminForgetPasswordParams({
    required this.body,
  });
}
