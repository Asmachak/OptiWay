import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginAdminUseCases implements UseCase<AdminModel, AdminLoginParams> {
  final AdminRepository adminepository;

  LoginAdminUseCases(this.adminepository);

  @override
  Future<Either<AppException, AdminModel>> call(AdminLoginParams params) async {
    return await adminepository.loginAdmin(
        email: params.email, password: params.password);
  }
}

class AdminLoginParams<T> {
  /*T? data;
  String? newPassword;*/
  final String email;
  final String password;
  AdminLoginParams({required this.email, required this.password});
}
