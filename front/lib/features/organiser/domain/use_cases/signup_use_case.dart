import 'package:front/core/infrastructure/either.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

import '../../../../../core/infrastructure/exceptions/http_exception.dart';

class RegistreOrganiserUsecase
    implements UseCase<OrganiserModel, OrganiserRegistreParams<Map<String, dynamic>>> {
  final OrganiserRepository organiserRepository;

  RegistreOrganiserUsecase(this.organiserRepository);

  @override
  Future<Either<AppException, OrganiserModel>> call(
      OrganiserRegistreParams params) async {
    return await organiserRepository.signUpOrganiser(body: params.body);
  }
}

class OrganiserRegistreParams<T> {
  final Map<String, dynamic> body;
  OrganiserRegistreParams({required this.body});
}
