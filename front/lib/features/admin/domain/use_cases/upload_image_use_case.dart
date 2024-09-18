import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:front/features/admin/domain/repositories/admin_repo.dart';
import 'package:front/shared/use_case.dart';

class UploadImageAdminUsecases
    implements UseCase<AdminModel, AdminUploadImageParams> {
  final AdminRepository adminRepository;

  UploadImageAdminUsecases(this.adminRepository);
  @override
  Future<Either<AppException, AdminModel>> call(
      AdminUploadImageParams params) async {
    return await adminRepository.uploadImage(
        imageFile: params.imageFile, id: params.id);
  }
}

class AdminUploadImageParams<T> {
  final String id;
  final File imageFile;
  AdminUploadImageParams({
    required this.imageFile,
    required this.id,
  });
}
