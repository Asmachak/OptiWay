import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';
import 'package:front/features/reclamation/domain/repositories/reclamation_repo.dart';
import 'package:front/shared/use_case.dart';

class GetReclamationUsecases
    implements UseCase<List<ReclamationModel>, NoParams> {
  final ReclamationRepository reclamationRepository;

  GetReclamationUsecases(this.reclamationRepository);
  @override
  Future<Either<AppException, List<ReclamationModel>>> call(noParams) async {
    return await reclamationRepository.getReclamations();
  }
}
