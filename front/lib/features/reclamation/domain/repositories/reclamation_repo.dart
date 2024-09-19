import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';

abstract class ReclamationRepository {
  Future<Either<AppException, ReclamationModel>> addReclamation(
      {required String targetId,
      required String reclaimerId,
      required Map<String, dynamic> body});
  Future<Either<AppException, List<ReclamationModel>>> getReclamations();
}
