import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class EditPasswordOrganiserUseCase
    implements UseCase<OrganiserModel, OrganiserEditPasswordParams> {
  final OrganiserRepository organiserRepository;

  EditPasswordOrganiserUseCase(this.organiserRepository);
  @override
  Future<Either<AppException, OrganiserModel>> call(
      OrganiserEditPasswordParams params) async {
    return await organiserRepository.editPassword(
        body: params.body, id: params.id);
  }
}

class OrganiserEditPasswordParams<T> {
  final String id;
  final Map<String, dynamic> body;
  OrganiserEditPasswordParams({
    required this.body,
    required this.id,
  });
}
