import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

class deleteOrganiserUseCase implements UseCase<String, DeleteOrganiserParams> {
  final OrganiserRepository organiserRepository;

  deleteOrganiserUseCase(this.organiserRepository);
  @override
  Future<Either<AppException, String>> call(
      DeleteOrganiserParams params) async {
    return await organiserRepository.deleteOrganiser(id: params.id);
  }
}

class DeleteOrganiserParams<T> {
  final String id;
  DeleteOrganiserParams({
    required this.id,
  });
}

class DeleteOrganiserUseCases {
  final deleteOrganiserUseCase deleteUseCases;

  DeleteOrganiserUseCases({
    required this.deleteUseCases,
  });
}
