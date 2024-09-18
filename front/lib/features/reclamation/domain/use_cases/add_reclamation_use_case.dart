import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';
import 'package:front/features/reclamation/domain/repositories/reclamation_repo.dart';
import 'package:front/shared/use_case.dart';

class AddReclamationUsecases
    implements UseCase<ReclamationModel, AddReclamationParams> {
  final ReclamationRepository reclamationRepository;

  AddReclamationUsecases(this.reclamationRepository);
  @override
  Future<Either<AppException, ReclamationModel>> call(
      AddReclamationParams params) async {
    return await reclamationRepository.addReclamation(
        body: params.body,
        targetId: params.targetId,
        reclaimerId: params.reclaimerId);
  }
}

class AddReclamationParams<T> {
  final String reclaimerId;
  final String targetId;
  final Map<String, dynamic> body;
  AddReclamationParams({
    required this.body,
    required this.reclaimerId,
    required this.targetId,
  });
}
