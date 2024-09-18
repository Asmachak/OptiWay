import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class EditProfileAdminUsecases
    implements UseCase<AdminModel, AdminEditProfileParams> {
  final AdminRepository adminRepository;

  EditProfileAdminUsecases(this.adminRepository);
  @override
  Future<Either<AppException, AdminModel>> call(
      AdminEditProfileParams params) async {
    return await adminRepository.editProfile(body: params.body, id: params.id);
  }
}

class AdminEditProfileParams<T> {
  final String id;
  final Map<String, dynamic> body;
  AdminEditProfileParams({
    required this.body,
    required this.id,
  });
}
