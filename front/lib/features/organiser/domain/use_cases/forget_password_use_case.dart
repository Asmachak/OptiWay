import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class ForgetPasswordOrganiserUseCase
    implements UseCase<OrganiserModel, OrganiserForgetPasswordParams> {
  final OrganiserRepository organiserRepository;

  ForgetPasswordOrganiserUseCase(this.organiserRepository);
  @override
  Future<Either<AppException, OrganiserModel>> call(
      OrganiserForgetPasswordParams params) async {
    return await organiserRepository.forgetPassword(body: params.body);
  }
}

class OrganiserForgetPasswordParams<T> {
  final Map<String, dynamic> body;
  OrganiserForgetPasswordParams({
    required this.body,
  });
}
