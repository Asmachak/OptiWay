import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class LoginOtpOrganiserUseCase
    implements
        UseCase<LoginResponseOrganiserModel, OrganiserOtpParams<Map<String, dynamic>>> {
  final OrganiserRepository organiserRepository;

  LoginOtpOrganiserUseCase(this.organiserRepository);

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> call(
      OrganiserOtpParams params) async {
    return await organiserRepository.otpLogin(email: params.email);
  }
}

class OrganiserOtpParams<T> {
  final String email;
  OrganiserOtpParams({required this.email});
}
