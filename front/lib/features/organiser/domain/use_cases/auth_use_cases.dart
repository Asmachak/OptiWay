import 'package:front/features/organiser/domain/use_cases/login_use_case.dart';
import 'package:front/features/organiser/domain/use_cases/signup_use_case.dart';

class AuthOrganiserUseCases {
  final LoginOrganiserUseCases loginUseCases;
  final RegistreOrganiserUsecase registerUseCases;

  AuthOrganiserUseCases({
    required this.loginUseCases,
    required this.registerUseCases,
  });
}
