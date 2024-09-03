import 'package:front/core/infrastructure/either.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';
import 'package:front/features/organiser/domain/repositories/organiser_repo.dart';
import 'package:front/shared/use_case.dart';

class VerifyOtpOrganiserUseCase
    implements
        UseCase<LoginResponseOrganiserModel,
            OrganiserVerifyOtpParams<Map<String, dynamic>>> {
  final OrganiserRepository organiserRepository;

  VerifyOtpOrganiserUseCase(this.organiserRepository);

  @override
  Future<Either<AppException, LoginResponseOrganiserModel>> call(
      OrganiserVerifyOtpParams params) async {
    return await organiserRepository.verifyOTP(
        email: params.email, otp: params.otp);
  }
}

class OrganiserVerifyOtpParams<T> {
  final String email;
  final String otp;
  OrganiserVerifyOtpParams({required this.email, required this.otp});
}
