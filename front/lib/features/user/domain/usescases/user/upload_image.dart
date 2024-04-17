import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class UploadImageUsecases implements UseCase<UserModel, UploadImageParams> {
  final UserRepository userRepository;

  UploadImageUsecases(this.userRepository);
  @override
  Future<Either<AppException, UserModel>> call(UploadImageParams params) async {
    return await userRepository.uploadImage(
        imageFile: params.imageFile, id: params.id);
  }
}

class UploadImageParams<T> {
  final String id;
  final File imageFile;
  UploadImageParams({
    required this.imageFile,
    required this.id,
  });
}
