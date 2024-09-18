import 'package:front/features/admin/domain/use_cases/login_use_case.dart';
import 'package:front/features/admin/domain/use_cases/signup_use_case.dart';

class AuthAdminUseCases {
  final LoginAdminUseCases loginUseCases;
  final RegistreAdminUsecase registerUseCases;

  AuthAdminUseCases({
    required this.loginUseCases,
    required this.registerUseCases,
  });
}
