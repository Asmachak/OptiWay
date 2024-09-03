import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginOrganiserUseCases implements UseCase<OrganiserModel, LoginParams> {
  final OrganiserRepository organiserRepository;

  LoginOrganiserUseCases(this.organiserRepository);

  @override
  Future<Either<AppException, OrganiserModel>> call(LoginParams params) async {
    return await organiserRepository.loginOrganiser(
        email: params.email, password: params.password);
  }
}

class LoginParams<T> {
  /*T? data;
  String? newPassword;*/
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}
