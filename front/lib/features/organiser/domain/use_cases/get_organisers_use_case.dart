import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class GetAllOrganisersUseCase
    implements UseCase<List<OrganiserModel>, NoParams> {
  final OrganiserRepository organiserRepository;

  GetAllOrganisersUseCase(this.organiserRepository);
  @override
  Future<Either<AppException, List<OrganiserModel>>> call(NoParams) async {
    return await organiserRepository.getOrganisers();
  }
}

class GetOrganisersUseCases {
  final GetAllOrganisersUseCase getOrganisersUseCase;

  GetOrganisersUseCases({
    required this.getOrganisersUseCase,
  });
}
