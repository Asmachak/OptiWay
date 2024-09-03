import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class EditProfileOrganiserUsecases
    implements UseCase<OrganiserModel, OrganiserEditProfileParams> {
  final OrganiserRepository organiserRepository;

  EditProfileOrganiserUsecases(this.organiserRepository);
  @override
  Future<Either<AppException, OrganiserModel>> call(
      OrganiserEditProfileParams params) async {
    return await organiserRepository.editProfile(
        body: params.body, id: params.id);
  }
}

class OrganiserEditProfileParams<T> {
  final String id;
  final Map<String, dynamic> body;
  OrganiserEditProfileParams({
    required this.body,
    required this.id,
  });
}
