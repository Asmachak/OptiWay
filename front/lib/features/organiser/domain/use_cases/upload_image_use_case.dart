import 'dart:io';

import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class UploadImageOrganiserUsecases
    implements UseCase<OrganiserModel, OrganiserUploadImageParams> {
  final OrganiserRepository organiserRepository;

  UploadImageOrganiserUsecases(this.organiserRepository);
  @override
  Future<Either<AppException, OrganiserModel>> call(
      OrganiserUploadImageParams params) async {
    return await organiserRepository.uploadImage(
        imageFile: params.imageFile, id: params.id);
  }
}

class OrganiserUploadImageParams<T> {
  final String id;
  final File imageFile;
  OrganiserUploadImageParams({
    required this.imageFile,
    required this.id,
  });
}
