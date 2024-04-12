import 'package:front/features/user/domain/usescases/user/login_use_cases.dart';
import 'package:front/features/user/domain/usescases/user/register_use_cases.dart';

class AuthUseCases {
  final LoginUseCases loginUseCases;
  final RegistreUsecase registerUseCases;

  //final EditProfileUsecases editProfileUseCases;
  //final UpdatePasswordUsecases updatePasswordUseCases;

  AuthUseCases({
    required this.loginUseCases,
    required this.registerUseCases,

    // required this.editProfileUseCases,
    // required this.updatePasswordUseCases,
  });
}
