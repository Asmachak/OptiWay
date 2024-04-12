import 'package:front/core/infrastructure/either.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/domain/repositories/user_repo.dart';
import 'package:front/shared/use_case.dart';

import '../../../../../core/infrastructure/exceptions/http_exception.dart';

class RegistreUsecase
    implements UseCase<UserModel, RegistreParams<Map<String, dynamic>>> {
  final UserRepository userRepository;

  RegistreUsecase(this.userRepository);

  @override
  Future<Either<AppException, UserModel>> call(RegistreParams params) async {
    return await userRepository.signUpUser(body: params.body);
  }
}

class RegistreParams<T> {
  final Map<String, dynamic> body;
  RegistreParams({required this.body});
}
