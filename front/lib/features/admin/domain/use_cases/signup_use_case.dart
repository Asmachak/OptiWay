import 'package:front/core/infrastructure/either.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

import '../../../../../core/infrastructure/exceptions/http_exception.dart';

class RegistreAdminUsecase
    implements UseCase<AdminModel, AdminRegistreParams<Map<String, dynamic>>> {
  final AdminRepository adminRepository;

  RegistreAdminUsecase(this.adminRepository);

  @override
  Future<Either<AppException, AdminModel>> call(
      AdminRegistreParams params) async {
    return await adminRepository.signUpAdmin(body: params.body);
  }
}

class AdminRegistreParams<T> {
  final Map<String, dynamic> body;
  AdminRegistreParams({required this.body});
}
