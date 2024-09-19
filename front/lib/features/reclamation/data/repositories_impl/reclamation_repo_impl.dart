import 'dart:io';
import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reclamation/data/data_sources/reclamation_remote_data_src.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';
import 'package:front/features/reclamation/domain/repositories/reclamation_repo.dart';

class ReclamationRepositoryImpl implements ReclamationRepository {
  final ReclamationDataSource remoteDataSource;

  ReclamationRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<AppException, ReclamationModel>> addReclamation(
      {required String targetId,
      required String reclaimerId,
      required Map<String, dynamic> body}) async {
    return remoteDataSource.addReclamation(
        body: body, reclaimerId: reclaimerId, targetId: targetId);
  }

  @override
  Future<Either<AppException, List<ReclamationModel>>> getReclamations() async {
    return remoteDataSource.getReclamations();
  }
}
