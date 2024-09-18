import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class EditPasswordAdminUseCase
    implements UseCase<AdminModel, AdminEditPasswordParams> {
  final AdminRepository adminRepository;

  EditPasswordAdminUseCase(this.adminRepository);
  @override
  Future<Either<AppException, AdminModel>> call(
      AdminEditPasswordParams params) async {
    return await adminRepository.editPassword(body: params.body, id: params.id);
  }
}

class AdminEditPasswordParams<T> {
  final String id;
  final Map<String, dynamic> body;
  AdminEditPasswordParams({
    required this.body,
    required this.id,
  });
}
